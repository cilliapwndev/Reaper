#!/bin/bash
set -e  # Exit on error

#⚠️ THIS SCRIPT WILL CREATE A DELIBERATELY VULNERABLE MACHINE
#⚠️ FOR PENETRATION TESTING, MALWARE DEPLOYMENT, AND EXPLOIT DEMOS
#⚠️ EXPOSING THIS TO A LIVE NETWORK MAY RESULT IN SYSTEM COMPROMISE

sleep 2
echo "===================================================================="
echo " BEFORE CONTINUING, YOU MUST AGREE TO THE FOLLOWING:"
echo "--------------------------------------------------------------------"
echo " - You understand this script creates insecure, exploitable services"
echo " - You agree to run it in a secure, offline virtual environment only"
echo " - You absolve the creator of any legal or technical responsibility"
echo " - You assume full liability for misuse or consequences of this tool"
echo "===================================================================="
echo ""
read -p "Type 'I UNDERSTAND AND ACCEPT THE RISK' to continue: " USER_ACK
if [[ "$USER_ACK" != "I UNDERSTAND AND ACCEPT THE RISK" ]]; then
    echo "[-] ABORTED: User did not acknowledge risk."
    echo "[-] Exiting..."
    exit 1
fi
echo "[+] Acknowledgment received. Proceeding with system setup..."
sleep 2
clear

# ===== ASCII BANNER =====
echo -e "\033[1;31m"
cat << "EOF"
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⢛⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⠾⠓⠂⠉⠛⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⢟⣡⣄⣤⠤⠀⠤⣈⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣣⡿⠛⠉⠀⠀⠀⣀⣈⣙⣻⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⠉⢁⠀⠀⠀⣀⡴⣿⢻⣿⣿⣿⣷⡝⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡾⠁⠀⢠⠋⠀⣠⣾⣯⡆⠀⣾⡇⠀⢸⣿⣿⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡇⢀⢀⡏⠀⣼⡋⢿⣽⣿⣤⢿⣧⣾⢿⣿⡿⡼⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣎⣾⡇⢸⣿⢷⣤⣭⠉⠿⠿⢯⣁⣸⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣠⡴⠶⠶⠿⣯⡿⡼⣿⡜⠛⣿⣤⣤⣤⣸⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡤⣤⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣠⣾⣡⣾⣆⣸⠀⠬⣿⡄⠹⣿⡆⢿⣙⣋⣩⣿⣿⡿⢿⠇⠀⠀⠀⠀⠀⠀⠀⠀⢸⢋⣴⠛⣧⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢀⣠⠶⠋⠙⠛⠋⠉⠉⠻⡆⡆⠙⢿⣆⠈⠛⢛⣽⣿⣿⢿⣍⣴⣿⣀⠀⠀⠀⠀⠀⠀⠀⠀⢘⣿⣿⣿⠛⢧⡙⣄⠀⠀⠀⠀⠀⠀⠀
⠀⣾⡿⠂⠀⠀⠐⠒⠢⢤⣠⣹⡇⣦⠀⢻⡷⠚⣿⣿⠃⠁⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⠟⢷⡀⠀⠑⠘⢦⠀⠀⠀⠀⠀⠀
⢀⡟⠀⡴⣀⣠⣤⣄⣀⣘⠻⣿⣧⣸⡆⠀⠉⠐⢻⠃⣠⡞⣀⡴⠀⠀⣿⡇⠀⠀⠀⠀⡠⠊⣹⠟⠁⠀⠀⠻⣄⢀⠀⠈⢧⠀⠀⠀⠀⠀
⣼⢠⡎⢀⣵⣾⠟⠋⠁⠀⠦⣼⣿⣿⣧⡾⠀⠀⠀⠘⣿⣿⠋⠀⠀⠀⣟⢻⡀⢀⣠⣾⣿⡿⠃⠀⠀⠀⠀⠀⠙⢿⡿⠁⠈⣧⠀⠀⠀⠀
⢹⡟⠀⠈⡿⠁⢀⡾⠋⠀⠤⣼⣿⣿⠿⠧⠤⠤⠤⢤⣿⣅⠀⠀⢀⣠⣬⣤⠟⠻⣿⡿⠋⣀⣤⣤⣤⣤⡄⠀⠀⠘⢷⡀⢀⠘⣧⠀⠀⠀
⢸⠃⠀⢰⡇⠀⡼⠁⠀⢀⡾⠋⠁⢀⣤⡠⠖⠋⢀⣤⣾⣿⣿⣿⢿⣿⣿⣳⣿⣿⣿⣷⢿⣿⣿⣿⣿⣗⣿⠀⠀⠀⠈⠿⣿⠀⠘⡆⠀⠀
⣼⠀⢀⣼⠀⠀⠁⠀⢠⡟⠁⠀⢠⡿⠉⠀⣠⣴⠿⠟⣛⣭⠿⠛⣻⣿⣿⣿⣿⣿⣿⡇⢸⣧⣽⣿⣿⣬⡇⠀⠀⠀⠀⠀⢧⠀⠀⢹⡄⠀
⠹⣦⣼⡆⠀⠀⠀⢀⠟⠀⠀⡄⣼⠁⠀⣰⣿⣥⣶⠛⠁⠀⢠⡞⣹⡿⠿⣿⣇⢹⣿⣇⠘⣿⣿⣿⠋⠉⠀⠀⠀⠀⠀⠀⠈⢧⠀⠈⣧⠀
⠀⠀⠙⣷⡀⠀⠀⠀⠀⠀⠀⢷⡏⠀⠀⣿⠻⣿⡏⠀⢀⣴⣿⠟⠹⣧⠀⠈⠻⣦⡹⢿⡄⢿⠿⢿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢇⠀⢹⡄
⠀⠀⠀⠈⢷⡀⠀⠀⠀⠀⡀⠈⠻⠤⠀⢿⣿⡇⣧⣴⣿⠟⠁⠀⠀⢿⣆⠀⠀⠈⢳⡄⠁⢸⣶⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡆⢸⡇
⠀⠀⠀⠀⠀⠙⠲⢤⣄⣀⠈⠓⢦⡀⠀⠸⣿⠀⣿⡟⠁⠀⠀⠀⠀⠘⣿⣦⠀⠀⠀⠹⣄⣀⠻⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⠈⣧
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠻⡶⢿⡄⠀⢹⢀⡏⠠⣼⣦⠀⠀⠀⠀⠈⠈⠳⣄⠀⠀⠙⠿⠿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡼⢛⣿⣄⢀⡼⠁⠀⠙⢿⡻⣦⠀⢀⡀⠀⠀⠈⠓⢦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡏
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⣩⡶⠋⠙⠿⣿⡁⠤⣤⣀⣀⡁⠀⠉⠀⠈⠑⠢⢄⣀⡀⠈⠙⠲⢶⣤⣤⠴⠆⠀⠀⠀⠀⠀⠀⠀⠀⠘⡇
⠀⠀⠀⠀⠀⠀⢀⡴⢟⡵⠞⠁⠀⠀⠀⠀⠈⠙⠳⠾⣿⣿⣿⣷⠦⢤⣀⣀⡀⠀⠉⠛⢿⣍⣉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⡴⣋⡴⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢀⣴⣿⠜⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢰⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#########################################################################
# Reaper - Turn any Linux distro into a                                 #
# Metasploitable-like system with vulnerable services.                  #
#                                                                       #
# Supported Distros: Debian/Ubuntu, Fedora, CentOS/RHEL, Rocky, Arch    #
# Created by: Cillia                                                    #
# Licensed under GNU GPL v3.0                                           #
#########################################################################
EOF
echo -e "\033[0m"

# Detect Distro
echo "[+] Detecting Linux Distribution..."
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
elif [ -f /etc/arch-release ]; then
    DISTRO="arch"
elif [ -f /etc/redhat-release ]; then
    DISTRO="rhel"
elif [ -f /etc/debian_version ]; then
    DISTRO="debian"
else
    echo "[-] Could not detect OS. Exiting."
    exit 1
fi
echo "[+] Detected Distro: $DISTRO"

# Function to install via apt (Debian/Ubuntu)
install_apt() {
    sudo add-apt-repository universe -y
    sudo apt update -y && sudo apt upgrade -y

    sudo apt install -y build-essential gcc make perl git curl wget unzip nmap net-tools \
        openssh-server vsftpd apache2 mysql-server samba smbclient \
        libmysqlclient-dev python3-pip \
        nikto wireshark tftpd-hpa tftp-hpa openbsd-inetd distcc || true

    sudo apt install -y exploitdb telnet || echo "[*] Some optional packages may need manual install"

    echo "[+] Installing Python modules..."
    sudo pip3 install --break-system-packages smbus || echo "[!] Failed to install smbus"
}

# Function to install via dnf (Fedora)
install_dnf() {
    sudo dnf install -y git curl wget unzip nmap net-tools \
        openssh-server telnet vsftpd httpd mariadb-server mariadb \
        samba samba-client python3-pip python3-devel \
        gcc make perl expat-devel libxml2-devel \
        libcurl-devel openssl-devel \
        exploitdb nikto wireshark tftp-server tftp xinetd \
        redhat-rpm-config
}

# Function to install via yum (CentOS/RHEL/Rocky)
install_yum() {
    sudo yum groupinstall -y "Development Tools"
    sudo yum install -y git curl wget unzip nmap net-tools \
        openssh-server telnet vsftpd httpd mariadb mariadb-server \
        samba samba-client python3-pip \
        gcc make perl expat-devel libxml2-devel \
        libcurl-devel openssl-devel \
        exploitdb nikto wireshark tftp-server tftp xinetd
}

# Function to install via pacman (Arch Linux)
install_pacman() {
    sudo pacman -Sy --noconfirm
    sudo pacman -S --noconfirm base-devel git curl wget unzip nmap net-tools \
        openssh inetutils vsftpd apache mariadb samba python python-pip \
        exploitdb nikto wireshark tftp-hpa inetutils xinetd distcc
    sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
}

# Install distro-specific packages
case "$DISTRO" in
    ubuntu|debian)
        install_apt
        ;;
    fedora)
        install_dnf
        ;;
    centos|rhel|rocky)
        install_yum
        ;;
    arch)
        install_pacman
        ;;
    *)
        echo "[-] Unsupported distribution: $DISTRO"
        exit 1
        ;;
esac

# Configure SSH with weak settings
echo "[+] Configuring SSH with weak settings..."
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo 'root:passw0rd' | sudo chpasswd
sudo systemctl enable ssh --now || echo "[!] Failed to start SSH"

# Add weak user accounts
echo "[+] Adding weak users..."
sudo useradd -m -s /bin/bash bob && echo 'bob:password' | sudo chpasswd
sudo useradd -m -s /bin/bash john && echo 'john:letmein' | sudo chpasswd

# Enable and start services
echo "[+] Enabling and starting services..."
case "$DISTRO" in
    ubuntu|debian)
        sudo systemctl enable vsftpd --now
        sudo systemctl enable apache2 --now
        sudo systemctl enable mysql --now
        sudo systemctl enable smbd --now
        ;;
    fedora|centos|rhel|rocky)
        sudo systemctl enable vsftpd --now
        sudo systemctl enable httpd --now
        sudo systemctl enable mariadb --now
        sudo systemctl enable smb --now
        sudo systemctl enable xinetd --now
        sudo systemctl start mariadb
        ;;
    arch)
        sudo systemctl enable vsftpd --now
        sudo systemctl enable httpd --now
        sudo systemctl enable mysqld --now
        sudo systemctl enable smb --now
        sudo systemctl enable xinetd --now
        sudo mysql_secure_installation <<EOF
y
password
password
y
y
y
y
EOF
        ;;
esac

# Setup MySQL with weak root password
echo "[+] Setting up MySQL with default credentials..."
if command -v mysql &> /dev/null; then
    mysqladmin -u root -p"password" password 'password' || true
fi

# Configure Samba with known vulnerability
echo "[+] Configuring Samba with vulnerable settings..."
cat <<EOF | sudo tee /etc/samba/smb.conf
[global]
    workgroup = WORKGROUP
    server string = Samba Server %v
    netbios name = kali-samba
    security = user
    map to guest = Bad User
    dns proxy = no
[share]
    comment = Public Share
    path = /srv/samba
    browsable = yes
    writable = yes
    guest ok = yes
EOF
sudo mkdir -p /srv/samba
sudo chmod -R 0777 /srv/samba
sudo systemctl restart smb || echo "[!] Failed to restart Samba"

# Enable Telnet if supported
echo "[+] Setting up Telnet..."
if [ "$DISTRO" == "ubuntu" ] || [ "$DISTRO" == "debian" ]; then
    sudo apt install -y openbsd-inetd telnetd > /dev/null 2>&1 || true
    sudo systemctl restart openbsd-inetd
elif [ "$DISTRO" == "fedora" ] || [ "$DISTRO" == "centos" ] || [ "$DISTRO" == "rhel" ] || [ "$DISTRO" == "rocky" ]; then
    sudo yum install -y xinetd telnet-server > /dev/null 2>&1 || true
    sudo systemctl enable xinetd --now
elif [ "$DISTRO" == "arch" ]; then
    echo "[*] Telnet not installed by default on Arch. Consider installing manually."
fi

# DoctorKisow's backdoored vsftpd 2.3.4
echo "[+] Installing DoctorKisow's backdoored vsftpd 2.3.4..."
cd /tmp
sudo apt install -y git build-essential libpam0g-dev > /dev/null 2>&1 || true

rm -rf vsftpd-2.3.4
git clone https://github.com/DoctorKisow/vsftpd-2.3.4.git  vsftpd-2.3.4
cd vsftpd-2.3.4

chmod +x vsf_findlibs.sh
sudo sed -i 's/LIBS =/LIBS = -lpam/' Makefile

sudo install -v -d -m 0755 /var/ftp/empty
sudo install -v -d -m 0755 /home/ftp
sudo groupadd -g 47 vsftpd > /dev/null 2>&1 || true
sudo groupadd -g 48 ftp > /dev/null 2>&1 || true
sudo useradd -c "vsftpd User" -d /dev/null -g vsftpd -s /bin/false -u 47 vsftpd > /dev/null 2>&1 || true
sudo useradd -c "anonymous FTP User" -d /home/ftp -g ftp -s /bin/false -u 48 FTP > /dev/null 2>&1 || true

make > /dev/null
sudo make install > /dev/null

sudo install -v -m 644 vsftpd.conf /etc/

echo "[+] Starting backdoored vsftpd..."
sudo /usr/sbin/vsftpd /etc/vsftpd.conf &
sudo systemctl stop vsftpd > /dev/null 2>&1 || true

# Setup CGI Scripts
echo "[+] Enabling CGI and deploying vulnerable scripts..."
case "$DISTRO" in
    ubuntu|debian)
        sudo a2enmod cgi
        DIR="/usr/lib/cgi-bin"
        ;;
    fedora|centos|rhel|rocky)
        sudo sed -i 's/ExecCGI off/ExecCGI on/' /etc/httpd/conf/httpd.conf
        sudo systemctl restart httpd
        DIR="/var/www/cgi-bin"
        ;;
    arch)
        sudo sed -i 's/ExecCGI off/ExecCGI on/' /etc/httpd/conf/httpd.conf
        sudo systemctl restart httpd
        DIR="/srv/http/cgi-bin"
        sudo mkdir -p $DIR
        ;;
esac

# Create a vulnerable shell script
echo '#!/bin/bash
echo "Content-type: text/html"
echo ""
echo "<pre>"
/bin/sh
echo "</pre>' | sudo tee $DIR/cmd.cgi > /dev/null
sudo chmod +x $DIR/cmd.cgi
sudo chown www-data:www-data $DIR/cmd.cgi || true

# Setup UnrealIRCD
echo "[+] Installing UnrealIRCD 3.2.8.1..."
cd /tmp
wget https://www.unrealircd.org/downloads/Unreal3.2.8.1.tar.gz  
tar -xzvf Unreal3.2.8.1.tar.gz
cd Unreal3.2.8.1
./Config -silent
make -s
sudo make install
cd /tmp/Unreal3.2.8.1
sudo ./unreal start

# Setup distccd
echo "[+] Installing and enabling distccd..."
case "$DISTRO" in
    ubuntu|debian)
        sudo apt install -y distcc
        sudo systemctl enable distcc --now
        ;;
    fedora|centos|rhel|rocky)
        sudo yum install -y distcc
        sudo systemctl enable distccd --now
        ;;
    arch)
        sudo pacman -S --noconfirm distcc
        sudo systemctl enable distccd --now
        ;;
esac

# Final message
echo ""
echo "#########################################################################"
echo "# Metasploitable-like system configured with advanced exploits!"
echo "#"
echo "# Weak logins:"
echo "#   root:passw0rd"
echo "#   bob:password"
echo "#   john:letmein"
echo "# Services running: SSH, FTP (backdoor), Telnet, Apache (CGI), MySQL,"
echo "#                     Samba, UnrealIRCD (CVE-2010-2075), DistCC"
echo "#"
echo "# 🔒 Remember: DO NOT expose this machine to public networks."
echo "#              Use in isolated VM environments only."
echo "#########################################################################"
