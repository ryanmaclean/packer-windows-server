source "googlecompute" "windows-server" {
  communicator      = "winrm"
  disk_size         = 60
  disk_type         = "pd-ssd"
  image_description = "Windows Server instance for use within Instruqt platform"
  image_name        = "windows-server-{{timestamp}}"
  image_family      = "windows-server"
  machine_type      = "n1-standard-2"
  metadata = {
    windows-shutdown-script-ps1 = "C:/cleanup-packer.ps1"
    windows-startup-script-cmd  = "winrm quickconfig -quiet & net user /add packer_user & net localgroup administrators packer_user /add & winrm set winrm/config/service/auth @{Basic=\"true\"}"
  }
  network             = "default"
  on_host_maintenance = "TERMINATE"
  project_id          = "instruqt"
  region              = "us-west1"
  zone                = "us-west1-b"
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
    elevated_user     = "SYSTEM"
    elevated_password = ""
    scripts = [
      "./scripts/disable-uac.ps1",
      "./scripts/install-chocolatey.ps1",
      "./scripts/run-chocolatey.ps1",
      "./scripts/miscellaneous.ps1",
      "./scripts/browser-settings.ps1",
      "./scripts/install-myrtille.ps1",
      "./scripts/install-openssh.ps1",
    ]
    valid_exit_codes = [0, 3010]
  }
  provisioner "windows-restart" {
    restart_timeout = "15m"
  }
  provisioner "powershell" {
    inline = [
      "Set-Service -Name sshd -StartupType 'Automatic'",
      "New-Item -Path \"C:/\" -Name \"packer.done\" -ItemType \"file\"",
      "GCESysprep -NoShutdown",
    ]
  }
}
