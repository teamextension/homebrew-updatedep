class Updatedep < Formula
  desc "Updatedep is an application that analyzes the dependencies of a project, this helps check what dependency versions can be used with less to no vulnerabilities."
  homepage "https://github.com/teamextension/homebrew-updatedep"
  url "https://github.com/teamextension/homebrew-updatedep/releases/download/1.1.0/updatedep.jar"
  sha256 "D834F95D657B3BFBDECC9475BFD99266E415BCCE652BE111ED06F89F0DB82D02"
  license "MIT"

  depends_on "openjdk@11"

  resource "excludes" do
    url "https://raw.githubusercontent.com/teamextension/homebrew-updatedep/main/excludes.txt"
    sha256 "a343c7a468b75d521eaab54531412060280bcf7d20242670ee3a3b333418e6ed"
  end

  def install
    libexec.install "updatedep.jar"
    bin.write_jar_script libexec/"updatedep.jar", "updatedep"

    resource("excludes").stage do
      libexec.install "excludes.txt"
    end
  end

  def caveats
    <<~EOS
      The excludes.txt file is installed at:
        #{libexec}/excludes.txt
    EOS
  end

  test do
    system "#{bin}/updatedep", "--version"
  end
end
