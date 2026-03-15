class Tongues < Formula
  desc "Write your library once in Python. Get native, idiomatic code in every language."
  homepage "https://github.com/ldayton/Tongues"
  url "https://github.com/ldayton/Tongues/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "5bede69da007dcec5cc6e5ea46917f1833c1d2306d88412c5a705526f8c0197d"
  license "MIT"
  head "https://github.com/ldayton/Tongues.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "node"
  depends_on "python@3.12" => :build

  def install
    cd "tongues" do
      mkdir_p ".out"
      system Formula["python@3.12"].opt_bin/"python3.12",
             "bin/tongues", "--target", "javascript", "-o", ".out/tongues.js", "src"
    end
    (libexec/"bin").install "tongues/bin/tongues.js"
    (libexec/"lib").install "tongues/.out/tongues.js"
    (bin/"tongues").write <<~SH
      #!/bin/sh
      exec node "#{libexec}/bin/tongues.js" "$@"
    SH
  end

  test do
    assert_match "from __future__", pipe_output("#{bin}/tongues --target python", "x: int = 1\n")
  end
end
