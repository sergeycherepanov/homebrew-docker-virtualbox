require 'formula'

class DockerCli < Formula
  homepage 'https://github.com/docker/cli'
  if OS.linux?
    url 'https://download.docker.com/linux/static/stable/x86_64/docker-20.10.1.tgz'
    sha256 '8790f3b94ee07ca69a9fdbd1310cbffc729af0a07e5bf9f34a79df1e13d2e50e'
  else
    url 'https://download.docker.com/mac/static/stable/x86_64/docker-20.10.1.tgz'
    sha256 'bfcbfa86b7df1c1312293ccf7faf29dd55ec501e5bbdc9cb38eb47ed976e554c'
  end
  version "20.10.1"
  revision 3

  keg_only "this package may conflict with official docker client"

  def install
    bin.install "docker"
  end

  def test
    system "docker --version"
  end
end
