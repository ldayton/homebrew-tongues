class Tongues < Formula
  desc "Write your library once in Python. Get native, idiomatic code in every language."
  homepage "https://github.com/ldayton/Tongues"
  url "https://github.com/ldayton/Tongues/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "65ae44dbbda9a004abd32b9b3142d9e6a15fc5a811bdc7a06f0797e521ffbb31"
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
