# Proxmox Server Setup Documentation

## Table of Contents
1. [Installing Proxmox](#installing-proxmox)
2. [Adding ISO Images to Proxmox](#adding-iso-images-to-proxmox)
3. [Creating New Virtual Machine](#creating-new-virtual-machine)

---

# Installing Proxmox

## Prerequisites
- Proxmox ISO (Download from official Proxmox website)
- USB stick (minimum 8GB)
- Rufus software for creating bootable USB

## Creating Bootable USB
1. Download and install Rufus from [rufus.ie](https://rufus.ie/en/) and create a bootable USB

## Installation Steps
2. Insert USB into target server and boot from the Rufus USB
3. Follow installation wizard
   - **Important**: Note down the IP address assigned to Proxmox
   - **Important**: Remember the root password you set

## Accessing Proxmox
1. Open web browser
2. Navigate to `https://[proxmox-ip]:8006`
   - Example: `https://192.168.1.50:8006`
3. Login with root credentials

# Adding ISO Images to Proxmox

## Upload Process
1. Navigate to: Datacenter → Proxmox → local(proxmox) → ISO Images
2. Choose upload method:
   - Option 1: Upload from local computer
   - Option 2: Download from URL

# Creating New Virtual Machine

## VM Configuration Steps
1. Click "Create VM" button
2. General:
   - Set VM ID (auto-generated)
   - Enter VM name
   - Select ISO file
3. OS:
   - Select operating system
4. System:
   - Machine: Set to q35
   - BIOS: Change to OVMF (UEFI)
5. Disks:
   - Set desired disk size
6. CPU:
   - Configure CPU cores and sockets
7. Memory:
   - Set RAM allocation
8. Network:
   - Keep default settings

## Post-Installation Setup
1. During OS installation:
   - Choose manual IP configuration
   - Configure IP according to network diagram
   - **Do not use DHCP**

## First-Time Machine Setup
1. Prerequisites on main machine:
   - Ensure you have `id_rsa.pub` file
   - Download `first_time_setup.sh` from repository's scripts folder

2. SSH Setup:
   ```bash
   ssh-copy-id tomer@[new-machine-ip]
   scp first_time_setup.sh tomer@[new-machine-ip]:/home/tomer
   ```

3. Final Configuration:
   - SSH into new machine
   - Execute `first_time_setup.sh`
   - This creates ansible user for future configurations
   - IMPORTANT: after executing the script, log out from the machine and SSH to the Ansible user.

4. Ansible Integration:
   - Navigate to ansible folder in repository
   - Add the new machine to inventory file:
     ```ini
     [new-machine-group]
     machine-fqdn ansible_host=[machine-ip]
     ```
   - Test connectivity with:
     ```bash
     ansible [host-name] -m ping
     ```
   - **Note**: If ping fails or asks for fingerprint validation:
     1. SSH directly to the ansible user on target machine:
        ```bash
        ssh ansible@[machine-ip]
        ```
     2. Exit and try ping test again
   - Execute system_init role

## Reference Materials
- [Proxmox Installation Guide Video](https://www.youtube.com/watch?v=sZcOlW-DwrU)
- [Rufus Official Website](https://rufus.ie/en/)


