class DockerMachineNfsGeneric < Formula
  desc "Activates NFS on docker-machine (with generic driver support)"
  homepage "https://github.com/sergeycherepanov/docker-machine-nfs"
  url "https://github.com/sergeycherepanov/docker-machine-nfs/archive/0.5.4.2.tar.gz"
  sha256 "5067da89d8ba1205883cfa0087106cbbe5bc4140ee4b9f45ed1a7b772363417b"
  license "MIT"
  version "0.5.4"
  revision 2

  bottle :unneeded

  def install
    bin.install "docker-machine-nfs.sh" => "docker-machine-nfs-generic"
  end

  test do
    system "#{bin}/docker-machine-nfs-generic"
  end
end
