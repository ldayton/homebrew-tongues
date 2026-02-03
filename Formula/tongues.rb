class Tongues < Formula
  desc "Write your library once in Python. Get native, idiomatic code in every language."
  homepage "https://github.com/ldayton/Tongues"
  url "https://github.com/ldayton/Tongues/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "20949197fccb9ea5f5d177e84efef0dd70d816c7561e3eef84e17a70f7299ec4"
  license "MIT"
  head "https://github.com/ldayton/Tongues.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "python"

  def install
    libexec.install Dir["tongues/*"]
    bin.install_symlink libexec/"bin/tongues"
  end

  test do
    pipe_output("#{bin}/tongues --verify", "x: int = 1\n", 0)
  end
end
