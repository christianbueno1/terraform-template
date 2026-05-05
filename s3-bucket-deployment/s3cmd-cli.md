# S3cmd command-line tool on fedora 43

```bash
sudo dnf install s3cmd

s3cmd --configure
#
nyc3.digitaloceanspaces.com

# conf file
ll ~/.s3cfg
cat ~/.s3cfg

# bucket name: fedora-spaces
s3cmd ls s3://fedora-spaces/

# upload
echo "hola" > test.txt
s3cmd put test.txt s3://fedora-spaces/

# download
s3cmd get s3://fedora-spaces/test.txt

