DEBPATH=".travis/kide50/2015/dists/trusty/main/binary-amd64"

mv *amd64.deb $DEBPATH 2> /dev/null
cd $DEBPATH
rm Release InRelease Release.gpg Packages Packages.gz
dpkg-scanpackages . .travis/override.trusty.main > Packages
sed -i 's/\.\///g' Packages
gzip -9c Packages > Packages.gz
apt-ftparchive release . > Release
gpg --passphrase $GPG_PASSPHRASE --yes --clearsign -o InRelease Release
gpg --passphrase $GPG_PASSPHRASE --yes -abs -o Release.gpg Release
