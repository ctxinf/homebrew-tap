class AgentEnvGuard < Formula
  desc "Run commands while masking configured environment secret values from stdout and stderr."
  homepage "https://github.com/ctxinf/agent-env-guard"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/agent-env-guard/releases/download/v0.1.4/agent-env-guard-aarch64-apple-darwin.tar.xz"
      sha256 "fa5ca2e07625278141ebfd8ad457798c998b0f50719cbff12ddf606f13f2b09f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/agent-env-guard/releases/download/v0.1.4/agent-env-guard-x86_64-apple-darwin.tar.xz"
      sha256 "b8607e4110e53fbf34353a1f408ef6e247aedc331c706c5c90fd78fddb8b3cd7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/agent-env-guard/releases/download/v0.1.4/agent-env-guard-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d3ebf5483e99087fa0f95cf1d66b9098d4bd48daeac7ce8f13de5929bb673a6b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/agent-env-guard/releases/download/v0.1.4/agent-env-guard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b48882108756767ef7e4f060f764ee99da2a6885d7314b199a8c31fd960981e9"
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
