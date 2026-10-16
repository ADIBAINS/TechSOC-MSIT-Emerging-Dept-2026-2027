
This is a ToDo webapp made using flutter and flask for backend. It uses mongoDB for storing the data.
The app provides with features to add tasks, mark them as done and remove them. Allowing the user to keep track of remaining tasks. 
The app supports both dark and light theme depending on what the default theme of the user's machine is.
The app utilizes an overall blue theme, an animated text display on the banner, and a svg illustration.

The User can add tasks in the textfield and hit enter to register a task entry. On loading the tasks, the user is presented with a column containing the list of all the tasks, with a cancel and a done button; the former is used for the deletion of the task, and the latter for marking the task as complete. The user can either keep the completed task in the list or delete it as well.


each task is tracked using its id, along with that they are either saved as 'task' or 'comptask', signifying a task, and a completed task respectively.
the flask app provides api calls as the following: '/add, /todos, /comptodos, /delete, /addcomp'


in the flutter app, the communicator.dart handles the communication with the flask app, the main.dart file deals with the interface. Both files can be found inside the lib folder.

Libraries used: urllib, bson, pymongo, flask, flask_cors


flutter dependencies: cupertino_icons: ^1.0.8, animated_text_kit: ^4.3.0, google_fonts: ^8.2.1, flutter_randomcolor: ^1.0.16

Light Mode
<img width="1865" height="1007" alt="Screenshot 2026-10-16 200622" src="https://github.com/user-attachments/assets/2a7bcc66-f615-44c5-8edd-37bb4dee0038" />

<img width="1847" height="760" alt="Screenshot 2026-10-16 200728" src="https://github.com/user-attachments/assets/69e6409b-061d-4230-98e5-29194cb5a13a" />


Dark Mode

<img width="1871" height="1012" alt="Screenshot 2026-10-16 200824" src="https://github.com/user-attachments/assets/53dc0cdb-10f8-4c9a-bfb6-8442f8a5c212" />

<img width="1863" height="755" alt="Screenshot 2026-10-16 200954" src="https://github.com/user-attachments/assets/09eb413d-922f-455b-8c34-06d45080009b" />

MongoDB entries:

<img width="1385" height="435" alt="Screenshot 2026-10-16 200938" src="https://github.com/user-attachments/assets/c129f05f-f8ec-4296-be59-0320947c4d73" />


