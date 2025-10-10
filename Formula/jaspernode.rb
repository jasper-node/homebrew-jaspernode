# typed: false
# frozen_string_literal: true

class Jaspernode < Formula
  desc "AI-powered industrial automation runtime"
  homepage "https://www.jasperx.com.au/"
  version "1.2.5-beta"

  # Define URLs and checksums for different architectures
  on_intel do
    url "https://dl.jasperx.io/jn/mac64/1.2.5-beta"
    sha256 "0a338352485fd7466ce7646afe9521a8d97fb0d357df2d058a185f1754ab4d7c"
  end

  on_arm do
    url "https://dl.jasperx.io/jn/macA64/1.2.5-beta"
    sha256 "32eaa81309cd21a55c5ebad2b55bba9f589b725d477c00305ab045d18de8084b"
  end

  def install
    # The downloaded file is a versioned binary. We rename it to 'jaspernode'
    # and install it into the binary directory.
    if OS.mac? && Hardware::CPU.intel?
      bin.install "1.2.5-beta" => "jaspernode"
    elsif OS.mac? && Hardware::CPU.arm?
      bin.install "1.2.5-beta" => "jaspernode"
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
