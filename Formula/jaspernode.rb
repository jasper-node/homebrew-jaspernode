# typed: false
# frozen_string_literal: true

class Jaspernode < Formula
  desc "AI-powered industrial automation runtime"
  homepage "https://www.jasperx.com.au/"
  version "1.3.0-beta1"

  # Define URLs and checksums for different architectures
  on_intel do
    url "https://dl.jasperx.io/jn/mac64/1.3.0-beta1"
    sha256 "4c3afe41bc39d10ddb23df3983f407a3a47f20d51b4f9866b25bf8a8c2ef71a0"
  end

  on_arm do
    url "https://dl.jasperx.io/jn/macA64/1.3.0-beta1"
    sha256 "485a273d8adcd0a6ff14e8d880d99fc73b461e645e94a61d4e13c8460770fc8d"
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
