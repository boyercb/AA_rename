AA_rename
==========

`AA_rename` is a framework for the standardization of file names and encodings for audio files exported using the surveyCTO [`client`](http://www.surveycto.com/product/index.html) application. It is primarily intended for use by IPA staff in the field and, therefore, has yet to be adapted to other contexts. It requires STATA and [`ffmpeg`](https://www.ffmpeg.org/)

# Installation

`AA_rename` makes use of the special [`thenrun`](https://ipahq.surveycto.com/main.html#Help_Client_how-do-i-execute-outside-processes) subdirectory in the destination folder for downloads from the surveyCTO client application. Therefore, the user must specify the AA_rename container folder as the destination for the surveyCTO client. Here we provide a full template directory for downloading a surveyCTO form. To install, download the entire `AA_rename` folder and move it to the desired data storage location on your computer.

Then open the `AA_rename.do` file in the `thenrun` directory. This is the STATA script to automate renaming and encoding audio files. You will have to edit the filename and fields local variables to reflect the names of your .csv form and the audio file variables as shown below.

```stata
* set local working directory (CHANGE THIS!)
cd Q:\stata\AA_rename

* define local variables (CHANGE THESE!)
local filename = "example_audio_xlsform.csv"
local fields = "audio_variable1 " ///
             + "audio_variable2 " ///
		      	 + "audio_variable3 " ///
			       + "audio_variable4 " ///
			       + "audio_variable5"
```

If `ffmpeg` is installed, proceed to the next section and use the surveyCTO client application to download your form to the `AA_rename` directory. If `ffmpeg` is not installed, you can install the version included in the folder `ffmpeg` by adding the path to `ffmpeg/bin` to the $PATH environment variable by:

1. Hold <kbd>Win</kbd> and press <kbd>Pause</kbd>.
2. Click Advanced System Settings.
3. Click Environment Variables.
4. Append ";C:[your_directory]\\ffmpeg\\bin" to the Path variable.
5. Restart Command Prompt.

# `AA_rename` in action
Once `ffmpeg` is properly installed, you can set-up the auto-run feature of surveyCTO by:

1. Open the surveyCTO client and go to Tools -> Preferences.
2. Click the "Export options" tab.
3. Check the "Auto-run other processors after export" box.
4. Click "Ok".

Now the `AA_rename.do` file should be executed everytime you download new form data using the client application (Note: make sure the surveyCTO export directory is pointing to the folder containing all the `AA_rename` files and folders)


# Dependencies
`AA_rename` requires STATA and `ffmpeg`. Windows users, please download `ffmpeg` using the following [link](http://ffmpeg.zeranoe.com/builds/).
