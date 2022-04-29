require 'formula'

class DockerCli < Formula
  homepage 'https://github.com/docker/cli'
  if OS.linux?
    url 'https://download.docker.com/linux/static/stable/x86_64/docker-20.10.9.tgz'
    sha256 'caf74e54b58c0b38bb4d96c8f87665f29b684371c9a325562a3904b8c389995e'
  else
    url 'https://download.docker.com/mac/static/stable/x86_64/docker-20.10.9.tgz'
    sha256 'f045f816579a96a45deef25aaf3fc116257b4fb5782b51265ad863dcae21f879'
  end
  version "20.10.9"
  revision 1

  keg_only "this package may conflict with official docker client"

  def install
    bin.install "docker"
  end

  def test
    system "docker --version"
  end
end
