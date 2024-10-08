# 1. Download the installer
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# 2. Verify the installer (optional but recommended)
# Get the SHA256 checksum from the Miniconda website
# Then run:
# sha256sum Miniconda3-latest-Linux-x86_64.sh

# 3. Run the installer with `bash`
bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda3

# 4. Remove the installer
# rm Miniconda3-latest-Linux-x86_64.sh

# 5. Update your shell configuration to include conda
# For bash:
echo "export PATH=\"$HOME/miniconda3/bin:\$PATH\"" >> ~/.bashrc
# For zsh:
echo "export PATH=\"$HOME/miniconda3/bin:\$PATH\"" >> ~/.zshrc

# 6. Reload your shell configuration
source ~/.bashrc  # or source ~/.zshrc for zsh

# 7. Test the installation
conda list
