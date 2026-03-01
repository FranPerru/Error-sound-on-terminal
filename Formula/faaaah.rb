# frozen_string_literal: true

class Faaaah < Formula
  desc "Play a sound when a command fails in the terminal"
  homepage "https://github.com/FranPerru/Error-sound-on-terminal"
  head "https://github.com/FranPerru/Error-sound-on-terminal.git", branch: "main"
  license "MIT"

  def install
    prefix.install Dir["*"]
  end

  def caveats
    <<~EOS
      To complete installation, run:
        #{opt_prefix}/install.sh

      This will add FAAAAH to your shell config (~/.zshrc or ~/.bashrc).
    EOS
  end
end
