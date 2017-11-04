Fuzzy force!

HOW TO RUN:

With the project directory open, simply click and drag the subdirectory "/game" onto the lovec.exe file.
This tells Love2D to import the lua files and assets into the engine and run it.

NOTE: You can also run it with love.exe (instead of lovec.exe) but it won't display a console.

ABOUT:

This project is a demonstration of fuzzy systems and how it can be applied to games.

In it you control a player (center) and move him around the world using the following controls:

w:      move forward relative to the forward vector.
a:      change forward vector left.
s:      move backward relative to the forward vector. 
d:      change forward vector right.
r:      reset entire simulation.
space:  use force powers

The camera always stayed fixed on the player as he moves around the enviornment.

There is also a box in the enviornment. By pressing space you can apply force to the object.
The amount of force is based on your distance to the object, as well as how forward facing it is.

The closer the object is, the more force you can apply, but only if you are facing the object 
(within 45 degrees on either side of the player forward vector.)

the box's position is placed at the most optimal angle/distance relative to the player position and forward 
vector at startup, and everything can be reset with the R button.
