# Conway's Game of Life #

## Backbone.JS Implementation


This folder contains the Backbone.JS implementation of Conway's Game of Life. If your editor supports the [editorconfig.org](http://editorconfig.org) standard, take a look ar the .editorconfig file. It's configured to use tabs as indent characters, and to set them two spaces long. Because I fancy that.

The application just needs a server for demonstration purposes. Any server capable of serving status files should do. For development purposes, a simple node.js server is provided.

### Why Backbone.JS?

Why not?

### Setup

Once you have the repository cloned in your computer, you should browse to this folder (dojo/Conways-Game-of-Life/JavaScript/BackboneJS)

To run the samples, you need to use [bower](http://twitter.github.com/bower/) to download the components. For that, you need [Node Package Manager](https://npmjs.org/). Run these commands on the root folder:

	$ npm install
	$ bower install
	$ npm start

That will load all the node dependencies for the mocha test runner, and all the bower dependencies for the web application.
To run the tests, simply run

	$ npm test

on the root folder. That will run the mocha command line runner using the mocha.opts file on the test folder.

You should see something like this:

![image](https://raw.github.com/rodrigoi/dojo/master/Conways-Game-of-Life/JavaScript/BackboneJS/docs/mocha.png)
	
In case you have trouble, try to install mocha, and bower as global packages. To do that, just run

	$ npm install -g bower mocha

### User Interface

The user interface was implemented using Twitter's Bootstrap library, and it comprises thee windows

#### Main Window

The main window allows you to interact with the game. The main window has two toolbars, a generation counter, a form to set the lifespan of each generation and the game "world" itself.

The toolbar at the top allow the user to start and stop the game. The user can also step thru each generation manually using the "next generation" button. The "Randomize World" creates a random pattern.

Once the game is started, all the controls are disabled, except for the lifespan form and the game world itself. You can create new cells while the game is running to alter the patterns while they run.

The "Load Gosper's Glider Gun" and "Load Gosper's Bi-Gun" button will load two famous game patterns created in the 70's by famous mathematician and programmer [Bill Gosper](http://en.wikipedia.org/wiki/Bill_Gosper). Give them a try, both patterns shoot away the hacker logo…

![image](https://raw.github.com/rodrigoi/dojo/master/Conways-Game-of-Life/JavaScript/BackboneJS/docs/main.png)

The form bellow the game's world allows the user to set the lifespan of each generations. The value should be in milliseconds and can be set while the game is running. Once you click start, the game will use the value present on the field. The default is 50 milliseconds.

The toolbar bellow the game world clears the game, and enables the save and load dialog. There's not much else to tell about "clear", right?

#### Save Dialog

If the user clicks the "Save" button below the game world, it's presented with the save dialog. If the button is disabled, it means that the game is running. To enable it, just click "Stop".

![image](https://raw.github.com/rodrigoi/dojo/master/Conways-Game-of-Life/JavaScript/BackboneJS/docs/save.png)

It is divided in three sections. The fist section is just a text area with a representation of the current pattern. The user can then select the text and copy it somewhere else…

The second section, is a download button, that will trigger a file download of a json text file with the current game pattern.

The third section contains a form that allows the user to save the current game pattern to the browser's local storage. The user just needs to provide a pattern name. This button closes the window if everything went fine.

#### Load Dialog

If the user clicks the "Load" button below the game world, it's presented with the load dialog. If the burton is disabled, it means that the game is running. Stop the game to enable the button by clicking "Stop"

![image](https://raw.github.com/rodrigoi/dojo/master/Conways-Game-of-Life/JavaScript/BackboneJS/docs/load.png)

Like the save dialog, it's divided in three sections. The first section allows the user to use drag and drop operations of json files previously downloaded. You should see a green dotted border in the drop target if you can drop a json file there.

The second sections allows the user to paste the json representation of the grid.

The third section lists all the patterns stored into the browsers local storage, and allows some basic management operations. The user can either load the pattern or delete it from the local storage.

An important point is that all the load operations close the window if they succeed

### Implementation Details

#### Goals

As any other exercise, you have to set goals to accomplish. Here are mine:

- Use a command line test runner for the public scripts.
- Do not use PhantomJS, Jasmine or Zombie (I already know those).
- Use as little jQuery as possible to manipulate the dom.
- Do not use graphics.
- Use bower to manage the vendor scripts.
- Write 100% coffeescript tests.
- Rely on events to manage the grid state.

#### The Configuration
#### The Dependencies
#### BackboneJS

As we said earlier, this is a BackboneJS application, but since it's a really simple user interface, the solution is implemented without using controllers or routes.

The solution is implemented around an "Application" namespace.

##### The Base Classes

There are two base class that are implemented into the Backbone namespace, "component" and "dialog".

The component class is there to provide other classes the ability to extend themselves and use an initialization method, following the Backbone class pattern. The components use this base class, "localStorage" and "ticker".

The dialog class is an extension of Backbone.View that holds some boilerplate code shared by both the save and load dialogs. Objects that extend this class should call the base class initialize method to make those defaults effective.

##### The Application
##### The Components

The solution has two components that extend the Backbone.Component class. "localStorage" and "ticker". The local storage component is the one in charge of keeping track of changes in the browser's local storage. Objects are added, removed or retrieved using this object. It's also responsible of creating a json string representation of the games grid, and to update the grid from saved data.

At first, I've used the backbone.localstorage module, but it proved to be inneficient with the volume of data the application manages. Also, when saving a collection, an entry for every cell was created, making impossible to have more than one pattern stored. A custom implementation saving **only** the living cells. That reduced the size of the grid payload from 66kb to 500bytes for the representation of Gosper's Glider Gun.

##### The Models and Collections
##### The Views
##### The Tests

### Retrospective

Being this my first attempt to use mocha as the test runner for javascript applications intended to run n the browser, there are some…

#### Lessons Learned

- Running scripts intended to run in the browser on node.js requires a more careful planning of the application's namespaces. Using a browser runner you can be less strict with the application structure.
- You have to be extremely careful with the global scope, since it behaves differently on node.js.
- You have to treat the scripts as node modules. Or better, as a node module split across different files, but also implement careful measures to avoid breaking the browser functionality.
- It you have to require to many files to make it run in the node.js runner, that's a good sign that the module may be doing more than it should be doing. The shorter the list, the better.
- Backbone sucks at dependency injection.

#### Things to improve

- Implement the solution using an AMD. BackboneJS + RequireJS maybe? Testing will be interesting.
- Clean up the module requires for the public scripts.
- The grid is held in place by css, modify the world view to create proper rows.
- Split the localStorage component into two. Local Storage and World utilities.
- Implement ZombieJS tests in mocha.

## Extras

If you remember the Konami Code, there's something special behind one of the controls...

![image](https://raw.github.com/rodrigoi/dojo/master/Conways-Game-of-Life/JavaScript/BackboneJS/docs/grid.PNG)

----

Have fun, and enjoy your burrito ;)