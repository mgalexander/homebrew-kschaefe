class MavenAntTasks < Formula
  desc "Maven tasks for Apache Ant"
  homepage "http://maven.apache.org/components/ant-tasks/"
  url "http://archive.apache.org/dist/maven/ant-tasks/2.1.3/binaries/maven-ant-tasks-2.1.3.jar"
  version "2.1.3"
  sha256 "f16b5ea711dfe0323454b880180aa832420ec039936e4aa75fb978748634808a"

  bottle :unneeded

  depends_on "ant"

  def install
    (share+"ant").install "maven-ant-tasks-2.1.3.jar"
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
