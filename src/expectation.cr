require "stdio"
require "file_utils"

module HaveFiles
  struct Expectation
    @diff : String?
    def diff; @diff as String; end

    def initialize(@expected_dir : String, @base_dir : String, @cleanup : Bool, @block : (String ->)? = nil)
    end

    def match(actual_dir)
      tmpdir(base: @base_dir, cleanup: @cleanup) do |dir|
        diff_dir = "#{dir}/diff"
        run "git", %w(init), chdir: dir
        File.write "#{dir}/initial", ""
        run "git", %w(checkout -b actual), chdir: dir
        run "git", %w(add .), chdir: dir
        run "git", %w(commit -m "initial"), chdir: dir
        run "git", %w(checkout -b expected), chdir: dir
        FileUtils.cp_r @expected_dir, diff_dir
        run "git", %w(add .), chdir: dir
        run "git", %w(commit -m "expected"), chdir: dir
        run "git", %w(checkout actual), chdir: dir
        FileUtils.cp_r actual_dir, diff_dir if actual_dir
        Dir.mkdir_p diff_dir
        if block = @block
          block.call diff_dir
        end
        run "git", %w(add .), chdir: dir
        run "git", %w(commit -m "actual"), chdir: dir
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
        raise io.err.gets_to_end.rstrip unless status.success?
        io.out.gets_to_end
      end
    end

    module C
      lib Lib
        fun mkdtemp(template : LibC::Char*) : Char*
      end
    end

    def tmpdir(base : String, cleanup : Bool, &block)
      ptmpdir = "#{base}/XXXXXX".bytes + [0_u8]
      raise "mkdtemp() error." if C::Lib.mkdtemp(ptmpdir) == 0
      tmpdir = String.new(ptmpdir.to_unsafe)
      begin
        yield tmpdir
      ensure
        FileUtils.rm_r(tmpdir) if cleanup
      end
    end
  end
end
