/**
 * Deno script to update the Homebrew formula for JasperNode.
 *
 * This script fetches the latest release information, including version and checksums,
 * from the JasperX server and automatically updates the `jaspernode.rb` formula file.
 *
 * USAGE:
 * deno run --allow-net --allow-read --allow-write --allow-run release.ts
 */

// --- Configuration ---
const FORMULA_PATH = "./Formula/jaspernode.rb";
const VERSION_URL = "https://dl.jasperx.io/jn/version";

// --- Main Logic ---
async function main() {
  console.log("🚀 Starting JasperNode Homebrew release process...");

  try {
    // 1. Fetch latest release metadata
    console.log(`Fetching latest version info from ${VERSION_URL}...`);
    const response = await fetch(VERSION_URL);
    if (!response.ok) {
      throw new Error(`Failed to fetch version info: ${response.statusText}`);
    }
    const releaseData = await response.json();

    const { version } = releaseData;
    const intelInfo = releaseData.platforms["darwin-x86_64"];
    const armInfo = releaseData.platforms["darwin-aarch64"];

    if (!version || !intelInfo || !armInfo) {
      throw new Error("Incomplete release data received from server.");
    }
    console.log(`Found latest version: ${version}`);

    // 2. Generate the complete formula content
    console.log("Generating formula content...");
    const formulaContent = `# typed: false
# frozen_string_literal: true

class Jaspernode < Formula
  desc "AI-powered industrial automation runtime"
  homepage "https://www.jasperx.com.au/"
  version "${version}"

  # Define URLs and checksums for different architectures
  on_intel do
    url "${intelInfo.url}"
    sha256 "${intelInfo.signature}"
  end

  on_arm do
    url "${armInfo.url}"
    sha256 "${armInfo.signature}"
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
    # This is a basic test block. It runs \`jaspernode --version\` and checks
    # if the output contains the word "version".
    # You might need to adjust this depending on your app's actual output.
    assert_match "version", shell_output("#{bin}/jaspernode --version")
  end
end
`;

    // 3. Write the generated content to the formula file
    await Deno.writeTextFile(FORMULA_PATH, formulaContent);
    console.log(
      `✅ Successfully updated ${FORMULA_PATH} to version ${version}!`,
    );

    // 4. Git operations
    console.log("Committing and pushing changes...");

    const gitAdd = new Deno.Command("git", {
      args: ["add", "."],
    });
    await gitAdd.output();

    const gitCommit = new Deno.Command("git", {
      args: ["commit", "-m", `Release v${version}`],
    });
    await gitCommit.output();

    const gitPush = new Deno.Command("git", {
      args: ["push", "origin", "main"],
    });
    await gitPush.output();

    console.log(`✅ Changes committed and pushed to main!`);
  } catch (error: any) {
    console.error("❌ An error occurred during the release process:");
    console.error(error.message);
    Deno.exit(1);
  }
}

main();
