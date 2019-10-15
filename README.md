# File Download for RPGM Server

This repository is literally a hack for allowing RPGM Server to download files without using `rpgm.addToEndScreen()` and
waiting for the final step. Typically, the user will press a button for initiating the download. In desktop RPGM, it will
simply open the file with `shell.exec`.

**In future RPGM versions, downloading a file in RPGM Server will be a native feature with new R functions. This is just a temporary fix.**

*Please also note that executing custom Javascript is an upcoming feature in RPGM, so injecting Javascript code is not considered as a security issue. You are supposed to execute PGM files the same way you execute binary or exe files: by trusting the developper.*

## Usage

Add this CSS code in your project settings, "CSS" tab:
```css
.downloaderURL {
    display: none;
}
```
This will hide the widget which will make the download working.

Then include in your sequence the `file-utils.R` file in the beginning of the project. Before entering the GUI which will trigger
the download, call `download.init(rpgm.step(...))` with the correct step. Lastly, in the callback of your button, call
`download.go(rpgm.outputFile(...))` or `download.go(rpgm.pgmFilePath(...))`.

## How it works

- `download.init()` adds two widgets: a hidden text field and a hidden label with a fake image which will load a javascript code. This JS code will put the current URL address in the hidden text field.
- The user will click on a button or another R callback which will populate the variable `downloaderURL` in R with the current URL address.
- `download.go` will execute `shell.exec` if no URL is found, or will craft the final URL of the file for the browser.
- With the final file URL, the invisible label is updated again with a fake image with a JS payload for opening the URL in another window or tab.