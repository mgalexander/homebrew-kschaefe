class AntGitTasks < Formula
  desc "Git tasks for Apache Ant"
  homepage "https://github.com/rimerosolutions/ant-git-tasks"
  url "https://oss.sonatype.org/content/repositories/releases/com/rimerosolutions/ant/ant-git-tasks/1.3.2/ant-git-tasks-1.3.2.jar"
  version "1.3.2"
  sha256 "c1b304bd8fe0c39668a0c5b7450a516da87a25b8c13f8cb280820534522820db"

  bottle :unneeded

  depends_on "ant"

  resource "jsch" do
    url "http://repo1.maven.org/maven2/com/jcraft/jsch/0.1.50/jsch-0.1.50.jar"
    sha1 "fae4a0b1f2a96cb8f58f38da2650814c991cea01"
  end

  resource "jgit" do
    url "http://repo1.maven.org/maven2/org/eclipse/jgit/org.eclipse.jgit/3.0.0.201306101825-r/org.eclipse.jgit-3.0.0.201306101825-r.jar"
    sha1 "c79117e7b178df4483d3f5f0bbfe961bb436697b"
  end

  resource "jgit-ant" do
    url "http://repo1.maven.org/maven2/org/eclipse/jgit/org.eclipse.jgit.ant/3.0.0.201306101825-r/org.eclipse.jgit.ant-3.0.0.201306101825-r.jar"
    sha1 "9d81e64a8211ee9a9dda32502a7a6a8cd28c4d30"
  end

  def install
    (share+"ant").install "ant-git-tasks-0.0.1.jar"

    resource("jsch").stage do
      (share+"ant").install Dir["*.jar"]
    end

    resource("jgit").stage do
      (share+"ant").install Dir["*.jar"]
    end

    resource("jgit-ant").stage do
      (share+"ant").install Dir["*.jar"]
    end
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
