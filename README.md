# 🚀 PowerShell Scripts

[![Language: PowerShell](https://img.shields.io/badge/Language-PowerShell-5391FE?logo=powershell&logoColor=white)](https://docs.microsoft.com/en-us/powershell/)
[![GitHub last commit](https://img.shields.io/github/last-commit/thenextbutton/powershell)](https://github.com/thenextbutton/powershell/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/thenextbutton/powershell)](https://github.com/thenextbutton/powershell/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/thenextbutton/powershell)](https://github.com/thenextbutton/powershell/pulls)
[![GitHub Stars](https://img.shields.io/github/stars/thenextbutton/powershell?style=social)](https://github.com/thenextbutton/powershell/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/thenextbutton/powershell/blob/main/LICENSE)

---

Welcome to my repository of PowerShell scripts! These are some of the scripts I commonly use for various administrative tasks.

---

## 📜 Script Descriptions

* **`active_computers_and_os.ps1`**
    This script scans **Active Directory** to report on the **operating system** installed on active servers and workstations.

* **`lastlogon.ps1`**
    This script queries **Active Directory** to retrieve the **last logon date** for active user accounts. Since the `lastLogon` attribute is not replicated efficiently across domain controllers, the script queries **every DC** in the domain to ensure the most accurate and up-to-date value is returned.

* **`no_sounds.ps1`**
    This script modifies the **Windows Registry** to **disable all system sounds** during a user session, ensuring no "pings" or "dings" occur.

* **`notification_icons.ps1`**
    This script modifies the **Windows Registry** to **display all notification icosns** in the notification area, rather than being in the overflow.
<br>



## 💡 Usage

* To use any of these scripts, download the `.ps1` file to your local machine.
* Open **PowerShell** and navigate to the directory where you saved the script.
* Run the script by typing its name (e.g., `./active_computers_and_os.ps1`).
* **Note**: You may need to adjust your PowerShell execution policy to run unsigned scripts. You can do this temporarily by running `Set-ExecutionPolicy RemoteSigned -Scope Process` in your PowerShell session.
<br>



## 🤝 Contributing

Feel free to open an issue or submit a pull request if you have suggestions for improvements or encounter any bugs.
<br>


## 📄 License

This project is licensed under the MIT License.




## 🙏 Acknowledgments

* Thanks for checking out my scripts!
