class AgentEnvGuard < Formula
  desc "Run commands while masking configured environment secret values from stdout and stderr."
  homepage "https://github.com/ctxinf/agent-env-guard"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/agent-env-guard/releases/download/v0.1.3/agent-env-guard-aarch64-apple-darwin.tar.xz"
      sha256 "e8bfc5ca811820cbad0eac59e4c7f5d31ea941da434976c29318daf336b1381f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/agent-env-guard/releases/download/v0.1.3/agent-env-guard-x86_64-apple-darwin.tar.xz"
      sha256 "af5d884dc0bb9a249f33f3aa8eabaac4a93e8cbf30e964d6ff8523f5c5ace67a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/agent-env-guard/releases/download/v0.1.3/agent-env-guard-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "47b12911bc75a929c66127a062fc935ac84b03e715e21525b394043b29c27cd7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/agent-env-guard/releases/download/v0.1.3/agent-env-guard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8ec9e4110f031b62f32a452d88f530a190b680e0c00b61041ca7b5ae37c3d518"
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
