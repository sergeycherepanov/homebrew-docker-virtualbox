class DockerMachineNfs < Formula
  desc "Activates NFS on docker-machine (with generic driver support)"
  homepage "https://github.com/sergeycherepanov/docker-machine-nfs"
  url "https://github.com/sergeycherepanov/docker-machine-nfs/archive/0.5.4.1.tar.gz"
  sha256 "cec306b86a9b1d3e52768a813a40ab833a1f95becbf6e07b1aea6c4efc60c611"
  license "MIT"

  bottle :unneeded

  def install
    bin.install "docker-machine-nfs.sh" => "docker-machine-nfs-generic"
  end

  test do
    system "#{bin}/docker-machine-nfs-generic"
  end
end
