# AI_Dev_Helpers
Some tools that I find useful when using AI for development

## Change Monitor Tool
To help when using Cursor.AI in Visual Studio Code I have created this batch file method. 

### The Problem:
When using Cursor AI to edit code, there's a risk of unintended changes or errors being introduced across multiple files. This is due to a number of factors including, but not limited to,
cloud model limitations, server load, context size, local cursor models not interpreting instructions correctly, or failing to apply changes properly.  Sneaky code errors creep in along the way
even when one is meticulously attempting to compare the Apply results in the Cursor UI.  Not easy.  And Git as a solution is plausible, but klunky and tedious to use by comparison.  
Here is my quick and dirty solution that is saving me time and keeping me sane.

### The Solution:

You use the keybindings in VS Code to execute the Run.bat, which calls the CreateSnapShot.bat.  

1. The script starts by checking if the required parameters (ProjectName, FileExtensions, and SourcePath) are provided. If any of them are missing, it displays the usage instructions and exits.

2. It assigns the provided parameters to variables: PROJECT_NAME, FILE_TYPES, and SOURCE_DIR.

3. If the FILE_TYPES parameter is enclosed in quotes, the script removes the quotes.

4. It creates a "Projects" folder in the same directory as the script if it doesn't already exist.

5. It creates a project folder within the "Projects" folder using the PROJECT_NAME if it doesn't already exist.

6. The script then determines the next available "CM"  ("ChangeMonitor") number for the project. It does this by iterating through the existing folders in the project directory that start with "CM_" and finding the highest number. It increments that number by 1 to get the next available CM number.

7. It pads the CM number with leading zeros to ensure a consistent 5-digit format (e.g., CM_00001).

It creates a new folder within the project directory using the formatted CM number (e.g., "CM_00001").

For each file extension specified in the FILE_TYPES parameter, the script copies all matching files from the SOURCE_DIR to the newly created CM folder, preserving the directory structure.

10. Finally, it displays a message indicating the location of the created snapshot and pauses for user input before exiting.

In summary, this batch file automates the process of creating a snapshot of specific file types from a source directory and organizing them into a numbered folder structure within a project directory. It helps in managing and versioning the files for a given project.
us amount of debugging/head-banging time.

The CreateSnapshot.bat is called by the Run.bat.  Visual Studio keybindings are used to call the Run.bat while coding using ctrl+shift+m  ... you do have to click the combination twice to kick off the batch file in the terminal, but that's a small price to pay for this convenience.

Then use Beyond Compare (or equivalent file comparison software, like WinDiff) to look at the current working folder and compare the files with any of the CM_0000<n> files.   
That way you can see a constant iteration of changes in a quick and easy view to see what cursor is actually doing along the way, and compare any version with any version easily 
across all of my code files.  Works great.  Saving me an enormous amount of time and effort dealing with bugs introduced inadvertently by Cursor.

## Claude's Endorsement of Change Monitor

I asked Claude to provide feedback on our experience with Cursor and Change Monitor.  This is what Claude had to say:

"Cursor's autonomous editing can be dangerous. It:
- Made unrequested changes to working code
- Reversed critical logic flow
- Modified functionality beyond the scope of the fix
- Introduced bugs in previously working features

Your Change Monitor system is a crucial safeguard against this kind of AI-induced regression. This incident demonstrates why we should:
- Always be explicit about which functions we're modifying
- Review changes before accepting them
- Keep modifications focused and minimal
- Have systems in place to detect and revert unwanted changes"
