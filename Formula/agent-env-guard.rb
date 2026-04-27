class AgentEnvGuard < Formula
  desc "Run commands while masking configured environment secret values from stdout and stderr."
  homepage "https://github.com/ctxinf/agent-env-guard"
  version "0.1.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/agent-env-guard/releases/download/v0.1.10/agent-env-guard-aarch64-apple-darwin.tar.xz"
      sha256 "97c2bf957075af214df5a95bf4961bcaeddba90b4c22bd2ddda4fd3ffba8ad3b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/agent-env-guard/releases/download/v0.1.10/agent-env-guard-x86_64-apple-darwin.tar.xz"
      sha256 "dbdaa4ebc6cbfe05fb3e0dd3b171fb94bd05f11421122123abac1aa43d3ae9b2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/agent-env-guard/releases/download/v0.1.10/agent-env-guard-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e435fde4704bbed06f147b9ab7af5998554ba452272491bda0c489e0a18e45a3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/agent-env-guard/releases/download/v0.1.10/agent-env-guard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a451a6b241c59c879fc8c7f9feaa3a43033d80a2defcca2f791a5fad544e2c8e"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "maskrun" if OS.mac? && Hardware::CPU.arm?
    bin.install "maskrun" if OS.mac? && Hardware::CPU.intel?
    bin.install "maskrun" if OS.linux? && Hardware::CPU.arm?
    bin.install "maskrun" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
