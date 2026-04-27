class AgentEnvGuard < Formula
  desc "Run commands while masking configured environment secret values from stdout and stderr."
  homepage "https://github.com/ctxinf/agent-env-guard"
  version "0.1.11"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/agent-env-guard/releases/download/v0.1.11/agent-env-guard-aarch64-apple-darwin.tar.xz"
      sha256 "d193b75c3210e18e6994031be785fa3bf9f488cf017a3423356499cabe14b5ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/agent-env-guard/releases/download/v0.1.11/agent-env-guard-x86_64-apple-darwin.tar.xz"
      sha256 "ab32039dea6ccf529e32868e8a8239de97128d73e5c748856aa7c6f0ecee89f0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/agent-env-guard/releases/download/v0.1.11/agent-env-guard-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7f417027cab6bb1610c8ade543c3df1dc683cb33d55df22f758216fb8ae1dda1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/agent-env-guard/releases/download/v0.1.11/agent-env-guard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cc2a656aab5e38dbed04915be35727c148796fc89f0325763c359e204056347f"
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
