Vagrant.configure("2") do |config|
  config.vm.box = "archlinux/archlinux"
  config.vm.provider "virtualbox" do |v|
    v.gui = true
  end
  config.vm.provision "shell", inline: $vagrantSpecific
  config.vm.provision :shell, path: "install.sh", privileged: false
  config.vm.provision "shell", inline: "sudo chsh -s /usr/bin/zsh vagrant"
  config.vm.provision 'shell', reboot: true
end

$vagrantSpecific= <<-SCRIPT
  pacman --noconfirm -Syyu
  pacman --noconfirm -R virtualbox-guest-utils-nox && pacman --noconfirm -S virtualbox-guest-{utils,iso}
SCRIPT
