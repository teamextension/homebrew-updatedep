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
  
    # Store exclude.txt in libexec (not Home directory yet)
    resource("exclude").stage do
      cp "exclude.txt", libexec/"exclude.txt"
    end
  
    # Wrapper script to handle first-time copying
    (bin/"updatedep").write <<~EOS
      #!/bin/bash
      ud_dir="$HOME/.ud"
      exclude_file="$ud_dir/exclude.txt"
      
      # Ensure ~/.ud exists and copy exclude.txt only once
      if [ ! -d "$ud_dir" ]; then
        mkdir -p "$ud_dir"
        cp "#{libexec}/exclude.txt" "$exclude_file"
      elif [ ! -f "$exclude_file" ]; then
        cp "#{libexec}/exclude.txt" "$exclude_file"
      fi
  
      # Run updatedep.jar
      exec "#{Formula["openjdk@11"].opt_bin}/java" --add-opens java.base/sun.security.ssl=ALL-UNNAMED -jar "#{libexec}/updatedep.jar" "$@"
    EOS
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
