# typed: false
# frozen_string_literal: true

class Jaspernode < Formula
  desc "AI-powered industrial automation runtime"
  homepage "https://www.jasperx.com.au/"
  version "1.2.7-beta"

  # Define URLs and checksums for different architectures
  on_intel do
    url "https://dl.jasperx.io/jn/mac64/1.2.7-beta"
    sha256 "bc09869d8b981552134f19338a1349213019be10e6e1bc6093fb7711548b591c"
  end

  on_arm do
    url "https://dl.jasperx.io/jn/macA64/1.2.7-beta"
    sha256 "b0307b332a3164a7f008473aa0ead21e3bd02c84b7fbba9994a4305556465111"
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
