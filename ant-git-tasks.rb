class AntGitTasks < Formula
  desc "Git tasks for Apache Ant"
  homepage "https://github.com/rimerosolutions/ant-git-tasks"
  url "https://oss.sonatype.org/content/repositories/releases/com/rimerosolutions/ant/ant-git-tasks/1.3.2/ant-git-tasks-1.3.2.jar"
  version "1.3.2"
  sha256 "c1b304bd8fe0c39668a0c5b7450a516da87a25b8c13f8cb280820534522820db"

  bottle :unneeded

  depends_on "ant"

  resource "jsch" do
    url "http://repo1.maven.org/maven2/com/jcraft/jsch/0.1.54/jsch-0.1.54.jar"
    sha256 "92eb273a3316762478fdd4fe03a0ce1842c56f496c9c12fe1235db80450e1fdb"
  end

  resource "jgit" do
    url "http://repo1.maven.org/maven2/org/eclipse/org.eclipse.jgit/org.eclipse.jgit/4.6.0.201612231935-r/org.eclipse.jgit-4.6.0.201612231935-r.jar"
    sha256 "64b6ff5b85947191ae028a85fdc782fe516b9343c3232a2e9a0e634bd6eab853"
  end

  resource "jgit-ant" do
    url "http://repo1.maven.org/maven2/org/eclipse/org.eclipse.jgit/org.eclipse.jgit.ant/4.6.0.201612231935-r/org.eclipse.jgit.ant-4.6.0.201612231935-r.jar"
    sha256 "85246e9de0e1bd07cf1bd36584fe1b7d5e2f4721fdd290e725204486438e2a46"
  end

  def install
    (share+"ant").install "ant-git-tasks-1.3.2.jar"

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
