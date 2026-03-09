# typed: false
# frozen_string_literal: true

class Jaspernode < Formula
  desc "AI-powered industrial automation runtime"
  homepage "https://www.jasperx.com.au/"
  version "1.3.0-beta3"

  # Define URLs and checksums for different architectures
  on_intel do
    url "https://dl.jasperx.io/jn/mac64/1.3.0-beta3"
    sha256 "8c828976591cb750c5ec9b1bc0ee74113d7f45bc8bd38f4e8acdfa6a42ae4213"
  end

  on_arm do
    url "https://dl.jasperx.io/jn/macA64/1.3.0-beta3"
    sha256 "55c257c68bc099aa02958cda095293175f1575916f50b650fe3ad7ca1f3196db"
  end

  def install
    # The downloaded file is a versioned binary. We rename it to 'jaspernode'
    # and install it into the binary directory.
    if Hardware::CPU.intel?
      bin.install "jaspernode_#{version}_mac64" => "jaspernode"
    elsif Hardware::CPU.arm?
      bin.install "jaspernode_#{version}_macA64" => "jaspernode"
    end
  end

  def caveats
    <<~EOS
      JasperNode has been installed successfully!
      
      To get started run:
        jaspernode
      
      Documentation: Use JasperNode AI Assistant to get information about the application.
    EOS
  end

  test do
    # This is a basic test block. It runs `jaspernode --version` and checks
    # if the output contains the word "version".
    # You might need to adjust this depending on your app's actual output.
    assert_match "version", shell_output("#{bin}/jaspernode --version")
  end
end
