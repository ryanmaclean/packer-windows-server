source "googlecompute" "windows-server" {
  communicator      = "winrm"
  disk_size         = 100
  disk_type         = "pd-ssd"
  image_description = "Windows Server instance for use within Instruqt platform"
  image_name        = "windows-server"
  machine_type      = "n1-standard-2"
  metadata = {
    windows-shutdown-script-ps1 = "C:/cleanup-packer.ps1"
    windows-startup-script-cmd  = "winrm quickconfig -quiet & net user /add packer_user & net localgroup administrators packer_user /add & winrm set winrm/config/service/auth @{Basic=\"true\"}"
  }
  network             = "default"
  on_host_maintenance = "TERMINATE"
  project_id          = "instruqt"
  region              = "europe-west1"
  zone                = "europe-west1-b"
  source_image_family = "windows-2019"
  tags                = ["allow-winrm-ingress-to-packer"]
  winrm_insecure      = true
  winrm_use_ssl       = true
  winrm_username      = "packer_user"
}

build {
  sources = ["source.googlecompute.windows-server"]

  provisioner "file" {
    destination = "C:/packages.config"
    source      = "./scripts/packages.config"
  }
  provisioner "file" {
    destination = "C:/cleanup-packer.ps1"
    source      = "./scripts/cleanup-packer.ps1"
  }
  provisioner "powershell" {
    scripts = [
      "./scripts/disable-uac.ps1",
      "./scripts/install-chocolatey.ps1",
      "./scripts/run-chocolatey.ps1",
      "./scripts/miscellaneous.ps1",
      "./scripts/browser-settings.ps1",
    ]
  }
  provisioner "powershell" {
    elevated_user     = "SYSTEM"
    elevated_password = ""
    scripts = [
      "./scripts/install-myrtille.ps1",
      "./scripts/install-openssh.ps1",
    ]
  }
  provisioner "windows-restart" {
    restart_timeout = "60m"
  }
  provisioner "powershell" {
    inline = [
      "New-Item -Path \"C:/\" -Name \"packer.done\" -ItemType \"file\"",
      "GCESysprep -NoShutdown",
    ]
  }
}
