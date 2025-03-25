class Updatedep < Formula
  desc "Updatedep is an application that analyzes the dependencies of a project, this helps check what dependency versions can be used with less to no vulnerabilities."
  homepage "https://github.com/teamextension/updatedep"
  url "https://github.com/teamextension/updatedep/releases/download/1.3.0/updatedep.jar"
  sha256 "498B3AC532646CE4DA76F3CB5FDC7DC722D84ACD725386FE68DF95A2617AD4B1"
  license "MIT"

  depends_on "openjdk@11"

  resource "exclude" do
    url "https://raw.githubusercontent.com/teamextension/updatedep/main/exclude.txt"
    sha256 "bfd021a1d27256daf2f915717f3201c43955fe5ac28ef308b34a3dc2c6be8c0d"
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
