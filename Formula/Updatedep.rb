class Updatedep < Formula
  desc "Updatedep is an application that analyzes the dependencies of a project, this helps check what dependency versions can be used with less to no vulnerabilities."
  homepage "https://github.com/teamextension/homebrew-updatedep"
  url "https://github.com/teamextension/homebrew-updatedep/releases/download/1.1.0/updatedep.jar"
  sha256 "D834F95D657B3BFBDECC9475BFD99266E415BCCE652BE111ED06F89F0DB82D02"
  license "MIT"

  depends_on "openjdk"

  def install
    libexec.install "updatedep.jar"
    bin.write_jar_script libexec/"updatedep.jar", "updatedep"
  end

  test do
    system "#{bin}/updatedep", "--version"
  end
end
