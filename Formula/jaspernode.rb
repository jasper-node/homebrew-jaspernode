# typed: false
# frozen_string_literal: true

class Jaspernode < Formula
  desc "AI-powered industrial automation runtime"
  homepage "https://www.jasperx.com.au/"
  version "1.2.6-beta"

  # Define URLs and checksums for different architectures
  on_intel do
    url "https://dl.jasperx.io/jn/mac64/1.2.6-beta"
    sha256 "fcf3acb3efb3f79b7c01f34984b66ee217e34dc7eae78d51ca53be0100b99252"
  end

  on_arm do
    url "https://dl.jasperx.io/jn/macA64/1.2.6-beta"
    sha256 "a18c93a300fa06d711b7eb2f91d68aefaee54b9618f7a976d1a04aec9fdf3168"
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
