require 'formula'

class DockerCli < Formula
  homepage 'https://github.com/docker/cli'
  if OS.linux?
    url 'https://download.docker.com/linux/static/stable/x86_64/docker-19.03.8.tgz'
    sha256 '7f4115dc6a3c19c917f8b9664d7b51c904def1c984e082c4600097433323cf6f'
  else
    url 'https://download.docker.com/mac/static/stable/x86_64/docker-19.03.8.tgz'
    sha256 'fe65c0039959b9ca326471427f26b1fcbd7b45079fe6e773c987c4fbbf87be71'
  end
  version "19.03.8"
  revision 2

  keg_only "this package may conflict with official docker client"

  def install
    bin.install "docker"
  end

  def test
    system "docker --version"
  end
end
