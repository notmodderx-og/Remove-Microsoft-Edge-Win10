# 🚀 Remove Microsoft Edge  
**Created by [notmodderx](https://github.com/notmodderx-og)**  

This PowerShell script **completely removes Microsoft Edge** from your Windows system and **prevents it from reinstalling** through Windows Updates.

## ⚡ Features  
✔️ **Uninstalls Microsoft Edge** from the system  
✔️ **Blocks Edge updates** via Windows Registry  
✔️ **Prevents Edge from reinstalling**  

## 🛠️ How to Use  
1. **Download the script**:  
   [Click here](https://github.com/notmodderx-og/Remove-Microsoft-Edge-Win10/releases) to download `Remove_Edge.ps1`.

2. **Run as Administrator**:  
   - Right-click `Remove_Edge.ps1` → **Run with PowerShell**  
   - OR open **PowerShell as Admin** and run:
     ```powershell
     Set-ExecutionPolicy Bypass -Scope Process -Force
     .\Remove_Edge.ps1
     ```

3. **Wait for completion**: Edge will be removed and updates blocked.

## ⚠️ Warning  
- This **permanently removes** Edge.  
- Ensure you have an alternative browser installed (Chrome, Firefox, Brave, etc.).

## 📜 License  
This project is licensed under the [MIT License](LICENSE).
