# PSConfiguration

## Introdution
>This is the Powershell configuration file. It has some command to help developer can manage some utilities conveniently and config some apps such as oh-my-posh,  PSReadLine module

## Features
**It has some command:**

1. The first command is cutomizable windows package manager (aka wpm). It help the developer manages some essential packages easily
2. In the future, Some commands will be released

**Set Alias**
1. Measure-Object
2. WindowsPackageManager
3. Get-Size

## Prerequisite
* Install the windows terminal theme in [this website][windows terminal theme] (Current theme is Catppuccin Macchiato)
* Install JetBrains Nerd Font in [this link][jetbrains nerd font] (Current font is JetBrainsMonoNL Nerd Font)
* Configure Windows Terminal:
    * In Appearance area, change the Application Theme into Dark theme
    * Turn on the "Use acrylic material in the tab now" option 
    ![][windows terminal appearance]
    * Go to the default tab in left sidebar, choose Appearance: choose the appropriate dark color scheme, JetBrainsMonoNL Nerd Font
    * In transparency, adjust the background opacity to 85%
    ![][windows terminal default tab]

## Requirements
* Operating System:
    * Windows
    * Linux
    * MacOS
* Shell:
    * Windows Powershell
    * Powershell Core (Recommended)

## Installation

Download the repo or clone it to your computer:

`cd ~`

`git clone https://github.com/huutamcbt/PSConfiguration.git`

Add this line to your powershell profile file:

If you use Powershell Core:
`. ~/PSConfiguration/PowerShell_profile.ps1`

Or If you use Windows Powershell:
`. ~/PSConfiguration/Microsoft.PowerShell_profile.ps1`

Reload the profile file or quit terminal and open again:
Reload the profile file with the following command:
`. $PROFILE`

## Suggestions
Thanks for your interest in my project. If you have any questions, please feel free to contact me at any time

[//]:<> (-----------------------------------------------------------)
[//]:<> (This is a variable definition area)


[windows terminal appearance]: ./Assets/windows_terminal_apperance.png
[windows terminal default tab]: ./Assets/wterminal_default_tab.png
[windows terminal theme]: https://windowsterminalthemes.dev/
[jetbrains nerd font]: https://www.nerdfonts.com/font-downloads