#!/usr/bin/env python3

import yaml
import subprocess

def install_packages():
    # Load package list from YAML
    with open("/install.yml") as f:
        data = yaml.safe_load(f)
        packages = data.get("packages", [])

    print(f"Installing packages: {packages}")
    failed_packages = []

    subprocess.run(["apt-get", "update"], check=True)

    for package in packages:
        try:
            print(f"Installing {package}...")
            subprocess.run(
                ["apt-get", "install", "-y", "--no-install-recommends", package],
                check=True,
            )
        except subprocess.CalledProcessError:
            print(f"Failed to install {package}. Skipping...")
            failed_packages.append(package)

    subprocess.run(["apt-get", "clean"], check=True)
    subprocess.run(["rm", "-rf", "/var/lib/apt/lists/*"], check=True)

    if failed_packages:
        print(f"The following packages failed to install: {failed_packages}")

if __name__ == "__main__":
    install_packages()
