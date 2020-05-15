require 'formula'

class DockerPf < Formula
  url 'https://github.com/johanhaleby/docker-machine-port-forwarder/archive/d58e7b8f267b6d9e4156f0c5939c01a84afb52ec.tar.gz'
  homepage 'https://github.com/johanhaleby/docker-machine-port-forwarder'
  sha256 '0acd6f61c71b4f719613c92e2b5df5231ec5d76816ef4e321c2b7c2150d1fcdf'

  def install
    mkdir_p buildpath/"bin"
    mv "pf", "bin/pf"
    chmod 0755, Dir["bin/*"]
    prefix.install "bin"
  end
end
