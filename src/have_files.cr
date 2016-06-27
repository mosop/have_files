require "./version"

module HaveFiles
  module C
    lib Lib
      fun mkdtemp(template : LibC::Char*) : Char*
    end
  end

  def self.tmpdir(base : String = "/tmp", cleanup : Bool = true, &block)
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
