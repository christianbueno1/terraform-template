#!/bin/bash

# Starting setup process
echo "Starting setup process..."
echo "Installing HTTPD server"

# Update the system and install necessary packages
sudo dnf update -y
sudo dnf install bash-completion vim-enhanced httpd wget unzip -y

echo "Enabling and starting HTTPD service"
sudo systemctl enable httpd
sudo systemctl start httpd

echo "HTTPD installed successfully!"

# Download and prepare the website content
WEBSITE_URL="https://www.tooplate.com/download/2135_mini_finance"
DOWNLOAD_DIR="/tmp"
WEBSITE_DIR="/var/www/sample.com/public_html"

# Create directories
sudo mkdir -p "$WEBSITE_DIR"

# Download and unzip website files
echo "Downloading and extracting website files"
wget -c "$WEBSITE_URL"
sudo unzip -o 2135_mini_finance -d "$DOWNLOAD_DIR"
sudo mv "$DOWNLOAD_DIR/2135_mini_finance"/* "$WEBSITE_DIR"

# Set permissions
echo "Setting file permissions"
sudo chown -R apache:apache "$WEBSITE_DIR"
sudo chmod -R 755 "$WEBSITE_DIR"

# Configure VirtualHost
VHOST_CONF="/etc/httpd/conf.d/web.conf"

sudo bash -c "cat > $VHOST_CONF" <<EOL
<VirtualHost *:80>
    ServerName web.example.com
    DocumentRoot $WEBSITE_DIR
    DirectoryIndex index.html
    ErrorLog /var/log/httpd/example.com_error.log
    CustomLog /var/log/httpd/example.com_requests.log combined
</VirtualHost>
EOL

# Restart HTTPD to apply changes
echo "Restarting HTTPD service"
sudo systemctl restart httpd

# Completion message
echo "Setup completed successfully. The website is available at web.example.com"
