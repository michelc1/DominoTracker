An iOS App to help you keep score of the game. 

FEATURES

Help you keep the track of the score of each team
Use camera to count the points for you.

TO-DOs:
  -When CameraButton is pressed the camera is shown. Create function in OpenCVWrapper to detect objects, and then break it down to only the dots in the dominos pieces.
  -After counting the dots, ask to which team the score is going to be added.
  -Finish the clear function, and make it clear the table.
  
MAIN FUNCTIONS:
  *FirstViewController:
    -setUpWindow()
        Creates the window that is displayed by adding object programmatically.
    -showTeamSelectionPopUp()
        Creates and shows the alert popup to select which team to add the points.
    -showAddValueOfRound()
        Popup that has a textbox and user enters the amount of points to be added to the selected before.
    -The 3 tableView() functions
        Requierements by the TableView interface. One sets the number of rows in the table, one the height, and the other one are the two columns of where the score is added
    -accessCamera()
        It access the camera for when the CameraButton is clicked.
    -clear()
        Clears the data in the table
