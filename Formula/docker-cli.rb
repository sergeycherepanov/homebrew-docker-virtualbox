require 'formula'

class DockerCli < Formula
  url 'https://github.com/docker/cli/archive/v19.03.8.tar.gz'
  homepage 'https://github.com/docker/cli'
  sha256 '36dd85273c95f4755e08b37ea9660a1bf5c315570b679a0ce268750ca1ed3801'

  depends_on 'go' => :build

  keg_only "this package may conflict with official docker client"

  def install
    system "make -f docker.Makefile cross"
    if OS.mac?
        prefix.install "bin/docker-darwin-amd64"  => "bin/docker-cli"
    else
        if OS.linux?
            prefix.install "bin/docker-linux-amd64" => "bin/docker-cli"
        end
    end
  end

  def test
    system "sshpass"
  end
end
