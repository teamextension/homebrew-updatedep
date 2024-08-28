class Updatedep < Formula
  desc "Updatedep is an application that analyzes the dependencies of a project, this helps check what dependency versions can be used with less to no vulnerabilities."
  homepage "https://github.com/teamextension/homebrew-updatedep"
  url "https://github.com/teamextension/homebrew-updatedep/releases/download/1.0.0/updatedep.jar"
  sha256 "6EFD78A45B9EEB2C09838CA5DB7E77816806BB5CED8DFAADA812865001D82ADE"
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
