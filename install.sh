echo "Building nrlog"
crystal build nrlog.cr --release
echo "Creating a ~/bin directory if it does not already exist"
mkdir ~/bin
echo "Copying to ~/bin"
cp nrlog ~/bin/nrl
echo "Make sure to add your ~/bin directory to your PATH"
echo "Once that is done, you should be able to access the alias manager via 'am'"
echo "See README.md for additional details"
echo "Done"