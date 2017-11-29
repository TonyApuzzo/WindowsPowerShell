# Windows PowerShell Profile Folder

This folder contains Tony's PowerShell configuration.  Features:
* Posh Git command-line completion
* Kubernetes Minikube helper functions
* "Solarized" coloration for PowerShell Windows
* Set environment variables for Flatirons/Jouve Vagrant virtual machine configuration
* More coming over time...

Things specific to me are isolated into the example file at:
    .\WindowsPowerShell\Profile.d\setVagrantEnv.example

## Installation

1. Fork this repository into your own repo (if you don't want to use my files as-is.)
2. Clone the git repository into your PowerShell Profile folder, for example:
    ```
    PS> git clone https://bitbucket.flatironssolutions.com/scm/~tapuzzo/windowspowershell.git "$Profile\.."
    ```
3. Copy the example files to specific files
    ```
    PS> cd "$Profile\..\Profile.d"
    PS> cp setVagrantEnv.example setVagrantEnv.ps1
    ```
4. Edit the file(s) for your specific situation:
    ```
    gvim setVagrantEnv.ps1
    ```
5. Run a new PowerShell window to verify that everything works and you don't have errors.

## Usage

Put any PowerShell scripts or modules you want to have automatically sourced into $Profile\..\Profile.d
named *.ps1 or *.psm1, respectively.

## Warning

Remember to never check any files into the repository that contain private or sensitive data like SSH keys,
SSL certificates or passwords.
