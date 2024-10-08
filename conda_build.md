# Installing `conda-build` on an Offline Machine Using Local Packages

When working in isolated or secure environments without internet access, installing packages can be challenging. This guide provides step-by-step instructions to install `conda-build` on an offline machine by leveraging local package files. This allows you to use `conda index` to generate `repodata.json` files for your local Conda packages.

## Overview

The process involves:

1. **On an internet-connected machine**:
   - Create a Conda environment with `conda-build`.
   - Generate a `spec.txt` file listing all required packages.
   - Download all necessary packages to a local directory.
   - Modify the `spec.txt` file to point to local package files.
   - Transfer the local packages and modified `spec.txt` file to the offline machine.

2. **On the offline machine**:
   - Use the modified `spec.txt` file to install `conda-build` from local packages.

---

## Steps on the Internet-Connected Machine

### 1. Create a Conda Environment with `conda-build`

```bash
conda create -n conda-build-env conda-build -y
```

This command creates a new environment named `conda-build-env` and installs `conda-build` along with all its dependencies.

### 2. Activate the Environment

```bash
conda activate conda-build-env
```

### 3. Generate an Explicit Spec File

```bash
conda list --explicit > conda_build_spec.txt
```

This file, `conda_build_spec.txt`, lists all packages in the environment with URLs pointing to online repositories.

### 4. Download Packages to a Local Directory

#### Option A: Set a Custom Package Cache

**Create a Custom Package Directory**

```bash
mkdir -p /path/to/conda_packages
```

**Set the Package Cache Directory**

```bash
export CONDA_PKGS_DIRS=/path/to/conda_packages
```

**Reinstall Packages to Download into the New Cache**

```bash
conda install --force-reinstall --name conda-build-env --yes
```

This forces Conda to reinstall packages into `/path/to/conda_packages`.

### 5. Modify the Spec File to Point to Local Files

Create a script named `generate_local_spec.sh`:

```bash
#!/bin/bash

# Path to your local packages directory
PACKAGES_DIR="/path/to/conda_packages"

# Original spec file
SPEC_FILE="conda_build_spec.txt"

# Output spec file
LOCAL_SPEC_FILE="conda_build_spec_local.txt"

# Start the new spec file
echo "@EXPLICIT" > "$LOCAL_SPEC_FILE"

# Read the original spec file
while read -r line; do
    if [[ "$line" == "#"* ]] || [[ "$line" == "" ]]; then
        # Skip comments and empty lines
        continue
    elif [[ "$line" == "@EXPLICIT" ]]; then
        # Skip @EXPLICIT line (already added)
        continue
    else
        # Extract the package filename
        FILENAME=$(basename "$line")
        # Construct the local file URL
        LOCAL_URL="file://$PACKAGES_DIR/$FILENAME"
        # Append to the local spec file
        echo "$LOCAL_URL" >> "$LOCAL_SPEC_FILE"
    fi
done < "$SPEC_FILE"
```

**Make the Script Executable**

```bash
chmod +x generate_local_spec.sh
```

**Run the Script**

```bash
./generate_local_spec.sh
```

This generates `conda_build_spec_local.txt` with local file paths pointing to your downloaded packages.

### 6. Transfer the Packages and Modified Spec File

Copy the `/path/to/conda_packages` directory and `conda_build_spec_local.txt` to your offline machine using a USB drive or other secure methods.

---

## Steps on the Offline Machine

### 1. Place the Spec File and Packages in the Appropriate Directories

- **Packages directory**: `/offline/path/conda_packages`
- **Spec file**: `/offline/path/conda_build_spec_local.txt`

Ensure that the paths match those specified in your modified spec file.

### 2. Install `conda-build` Using the Local Spec File

```bash
conda install --offline --file /offline/path/conda_build_spec_local.txt
```

The `--offline` flag tells Conda to use local files without accessing the internet.

### 3. Verify the Installation

```bash
conda list conda-build
```

You should see `conda-build` listed with its installed version.

---

## Using `conda index` to Generate `repodata.json`

Now that `conda-build` is installed, you can generate `repodata.json` files for your local packages:

```bash
conda index /path/to/your/local_packages
```

This command scans the directory `/path/to/your/local_packages` and creates `repodata.json` and `repodata.json.bz2` files necessary for Conda to recognize and install packages from that directory.

---

## Notes and Tips

- **Ensure Correct Paths**: Verify that the `PACKAGES_DIR` in your script matches the actual path where the packages are located on the offline machine.
  
- **Automate for Future Use**: You can reuse the `generate_local_spec.sh` script for other packages, making offline installations more manageable.
  
- **Environment Consistency**: It's recommended to use the same version of Conda on both the internet-connected and offline machines to prevent compatibility issues.

- **Platform Compatibility**: Ensure that the downloaded packages are compatible with the operating system and architecture of the offline machine.

---

## Summary

By following this guide, you can:

- **Automatically generate a spec file** that points to local package files.
- **Install `conda-build`** on an offline machine without manual editing or internet access.
- **Use `conda index`** to prepare your local package directories for offline Conda operations.

This method streamlines the process of setting up Conda environments in secure or isolated environments where internet access is restricted.

---

## Example Commands Summary

### On the Internet-Connected Machine

```bash
# Create environment with conda-build
conda create -n conda-build-env conda-build -y

# Activate the environment
conda activate conda-build-env

# Generate explicit spec file
conda list --explicit > conda_build_spec.txt

# Set custom package cache and download packages
mkdir -p /path/to/conda_packages
export CONDA_PKGS_DIRS=/path/to/conda_packages
conda install --force-reinstall --name conda-build-env --yes

# Modify spec file to use local paths
./generate_local_spec.sh

# Transfer '/path/to/conda_packages' and 'conda_build_spec_local.txt' to the offline machine
```

### On the Offline Machine

```bash
# Install conda-build using the local spec file
conda install --offline --file /offline/path/conda_build_spec_local.txt

# Verify installation
conda list conda-build

# Generate repodata.json for your local packages
conda index /path/to/your/local_packages
```

---

By automating the modification of the spec file to use local paths, you can install any package, including `conda-build`, on your offline machine without the need for internet access or manual intervention.