# wpautovalet Instructions

To use **wpautovalet**, make sure you have both Valet and MySQL installed on your machine. Additionally, ensure you have a `~/sites` directory set up for proper functioning.

Before running the script, don't forget to update the `DB_USER` and `DB_PASS` fields in your database configuration.

Here are the steps to create and manage your WordPress project:

1. To create the project:

	Open a terminal and navigate to your project directory, then run:

	```path-to-your-directory/wpmake.sh```


2. To create the project and open it in Visual Studio Code (VSCode):

	Run the following command in your terminal:

	```path-to-your-directory/wpmake.sh -v```


3. To create the project and open the WordPress admin page in your browser:

	Run the following command in your terminal:

	```path-to-your-directory/wpmake.sh -a```

4. To combine steps 2 and 3 (create project, open in VSCode, and open admin page):

	Execute the following additional command:
	```path-to-your-directory/wpmake.sh -v -a```

Make sure to replace `path-to-your-directory` with the actual path to your project directory.

Happy WordPress development with wpautovalet!
