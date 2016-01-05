class SvnAnt < Formula
  desc "SVN support for Apache Ant"
  homepage "http://subclipse.tigris.org/svnant.html"
  url "http://subclipse.tigris.org/files/documents/906/49042/svnant-1.3.1.zip"
  version "1.3.1"
  sha256 "43225c0776c12744366d5ff3e8ea49d938aacffefbde951daec77726e63bd9d4"

  bottle :unneeded

  depends_on "ant"

  def install
    (share+"ant").install Dir["lib/*.jar"]
  end

  test do
    (testpath/"build.xml").write <<-EOS.undent
      <project name="HomebrewTest" default="init" basedir="."
          xmlns:git="antlib:com.rimerosolutions.ant.git">
        <taskdef resource="net/sf/antcontrib/antcontrib.properties"/>
        <target name="init">
          <if>
            <equals arg1="BREW" arg2="BREW" />
            <then>
              <echo message="Test passes!"/>
            </then>
          </if>
        </target>
      </project>
    EOS
    system Formula["ant"].opt_bin/"ant"
  end
end
