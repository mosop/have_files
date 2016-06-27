require "stdio"
require "file_utils"

module HaveFiles
  struct Expectation
    @diff : String?
    def diff; @diff as String; end

    def initialize(@expected_dir : String, @base_dir : String = "/tmp", @cleanup : Bool = true)
      @block = nil
    end

    def initialize(@expected_dir : String, @base_dir : String = "/tmp", @cleanup : Bool = true, &@block : (String ->))
    end

    def match(actual_dir)
      HaveFiles.tmpdir(base: @base_dir, cleanup: @cleanup) do |dir|
        diff_dir = "#{dir}/diff"
        run "git", %w(init), chdir: dir
        run "git", %w(config user.email "test@a.b.com"), chdir: dir
        run "git", %w(config user.name "test"), chdir: dir
        File.write "#{dir}/initial", ""
        run "git", %w(checkout -b actual), chdir: dir
        run "git", %w(add .), chdir: dir
        run "git", %w(commit -m "initial"), chdir: dir
        run "git", %w(checkout -b expected), chdir: dir
        FileUtils.cp_r @expected_dir, diff_dir
        run "git", %w(add .), chdir: dir
        diff = run("git", %w(--no-pager diff --cached), chdir: dir).rstrip
        unless diff.empty?
          run "git", %w(commit -m "expected"), chdir: dir
        end
        run "git", %w(checkout actual), chdir: dir
        FileUtils.rm_r diff_dir if Dir.exists?(diff_dir)
        if actual_dir
          FileUtils.cp_r actual_dir, diff_dir
        else
          Dir.mkdir_p diff_dir
        end
        if block = @block
          block.call diff_dir
        end
        run "git", %w(add .), chdir: dir
        diff = run("git", %w(--no-pager diff --cached), chdir: dir).rstrip
        unless diff.empty?
          run "git", %w(commit -m "actual"), chdir: dir
        end
        diff = run("git", %w(--no-pager diff expected actual), chdir: dir).rstrip
        diff_stat = run("git", %w(--no-pager diff expected actual --stat), chdir: dir).rstrip
        a = %w()
        a << diff_stat unless diff_stat.empty?
        a << diff unless diff.empty?
        @diff = a.join("\n\n")
        diff.empty?
      end
    end

    def failure_message(actual_dir)
      diff
    end

    def negative_failure_message(actual_dir)
    end

    def run(command, args, chdir = nil)
      Stdio.capture do |io|
        status = Process.run(command, args, shell: true, chdir: chdir, output: io.out!, error: io.err!)
        unless status.success?
          out = io.out.gets_to_end.rstrip
          err = io.err.gets_to_end.rstrip
          a = %w()
          a << out unless out.empty?
          a << err unless err.empty?
          raise a.join("\n")
        end
        io.out.gets_to_end
      end
    end
  end
end
