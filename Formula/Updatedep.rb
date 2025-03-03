class Updatedep < Formula
  desc "Updatedep is an application that analyzes the dependencies of a project, this helps check what dependency versions can be used with less to no vulnerabilities."
  homepage "https://github.com/teamextension/updatedep"
  url "https://github.com/teamextension/updatedep/releases/download/1.2.0/updatedep.jar"
  sha256 "E988B282CAE50B085422B3B71185EB8B27FE3AD7BC60607A52FC6A2CC1DBB9EA"
  license "MIT"

  depends_on "openjdk@11"

  resource "exclude" do
    url "https://raw.githubusercontent.com/teamextension/updatedep/main/exclude.txt"
    sha256 "c691821aa1f6300751e0d6a6c8e06ba7f1585843f934e8ea50a41aae68533946"
  end

  def install
    libexec.install "updatedep.jar"
    bin.write_jar_script libexec/"updatedep.jar", "updatedep"

    resource("exclude").stage do
      libexec.install "exclude.txt"
    end
  end

  def caveats
    <<~EOS
      The exclude.txt file is installed at:
        #{libexec}/exclude.txt
    EOS
  end

  test do
    system "#{bin}/updatedep", "--version"
  end
end
