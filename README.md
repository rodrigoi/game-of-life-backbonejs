# Conway's Game of Life #

## Backbone.JS Implementation


This folder contains the Backbone.JS implementation of Conway's Game of Life. You can check an online version [here](http://rodrigoi.github.com/dojo/Conways-Game-of-Life/BackboneJS/).

The application just needs a server for demonstration purposes. Any server capable of serving status files should do. For development purposes, a simple node.js server is provided.

### Disclaimer

This code has been tested on modern browsers only. Chrome only… really. Local Storage may not work on Firefox. Other stuff may not work on Internet Explorer older than 9. To be safe, use Chrome :P

Oh, and the test runner won't watch files on Windows. Run on Linux/Mac to be safe.

### Setup

Once you have the repository cloned in your computer, you should browse to this folder (dojo/Conways-Game-of-Life/JavaScript/BackboneJS). It should look like this (plus some hidden files):

![image](https://raw.github.com/rodrigoi/dojo/master/Conways-Game-of-Life/JavaScript/BackboneJS/docs/root.png)

Or like this, if you like the terminal:

![image](https://raw.github.com/rodrigoi/dojo/master/Conways-Game-of-Life/JavaScript/BackboneJS/docs/root-cli.png)

That's the root folder for this project. **All scripts should be run from that location**.

To run the samples, you need to use [bower](http://twitter.github.com/bower/) to download the components. For that, you need [Node Package Manager](https://npmjs.org/). Run these commands on the root folder:

	$ npm install
	$ bower install
	$ npm start
	
	Now you can open your browser on http://localhost:1701

That will load all the node dependencies for the mocha test runner, and all the bower dependencies for the web application. You can point your browser to [http://localhost:1701/](http://localhost:1701/)

To run the tests, simply run:

	$ npm test

That will run the mocha command line runner using the mocha.opts file on the test folder and the binary on the local node_modules folder.

You should see something like this:

![image](https://raw.github.com/rodrigoi/dojo/master/Conways-Game-of-Life/JavaScript/BackboneJS/docs/mocha.png)

Isn't that [cute](https://www.youtube.com/watch?v=QH2-TGUlwu4)?

In case you have trouble, try to install mocha, and bower as global packages. To do that, just run

	$ npm install -g bower mocha
	
**Do not sudo npm**. Follow [this guide](http://howtonode.org/introduction-to-npm) if you need to su/sudo to install npm packages.

### User Interface

The user interface was implemented using Twitter's Bootstrap library, and it comprises three windows

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

If the user clicks the "Load" button below the game world, it's presented with the load dialog. If the button is disabled, it means that the game is running. Stop the game to enable the button by clicking "Stop"

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
- Use just Backbone.Events. Implementing a custom event dispatcher is out of the scope of the exercise.

#### The Configuration

The configuration of the development environment is really simple. The package.json contains all the dev dependencies to make the src/app scripts run inside mocha's node.js test runner. It also contains the start and test scripts that can be used to run the development server and the test runner.

component.json is the file that bower will use to download all the vendor scripts and place them into src/vendor. That location is specified inside the .bowerrc file.

The .editorconfig file contains the editor configurations, for editors that supports the [editorconfig.org](http://editorconfig.org) standard.

server.js is a really simple express server to serve the src folder.

The docs folder contains some images of the application, src the source code and test the tests. Inside the test folder, theres a mocha.opts file with the parameters for the mocha test runner.

And this file you're reading is README.md ;)

The .gitignore file is located two levels down, on the dojo folder. Be careful with that :)


#### The Dependencies

The front end uses [Backbone.js](http://backbonejs.org/), [Bootstrap](http://twitter.github.com/bootstrap/), [Modernizr](http://modernizr.com/) and [Underscore.JS](http://underscorejs.org/). It also uses the [FileServer.js](https://github.com/eligrey/FileSaver.js) dependency to manipulate blobs for file download.

To run the tests and the code on node, we need [CoffeeScript](http://coffeescript.org/), [Mocha](http://visionmedia.github.com/mocha/) as the test runner, [Chai](http://chaijs.com/) for assertions, [Sinon.JS](http://sinonjs.org/) for stubs, spies and mock objects. Also, the [Sinon-Chai](http://chaijs.com/plugins/sinon-chai) assertion library will come handy. [Node Inspector](https://github.com/dannycoates/node-inspector) for debugging, [Node LocalStorage](https://github.com/lmaccherone/node-localstorage) as a drop in replacement for the browser's local storage. Also, we need the node packages for jQuery, Backbone and Underscore. Oh, and [express](http://expressjs.com/) to run the demo server.

#### The Backbone.JS Application

As we said earlier, this is a BackboneJS application, but since it's a really simple user interface, the solution is implemented without using controllers or routes.

The solution is implemented around an "Application" namespace.

##### The Base Classes

There are two base class that are implemented into the Backbone namespace, "component" and "dialog".

###### The Base Component

The component class is there to provide other classes the ability to extend themselves and use an initialization method, following the Backbone class pattern. The components use this base class, "localStorage" and "ticker".

###### The Base Dialog

The dialog class is an extension of Backbone.View that holds some boilerplate code shared by both the save and load dialogs. Objects that extend this class should call the base class initialize method to make those defaults effective.

##### The Application

##### The Global Events

The applications works thanks to two global events. The "tick" event dispatched by the Ticker Component and the "Next Generation" button, and the "regenerate" event dispatched by the world view.

When the Ticker dispatches a "tick" event, a handler in the world view scans the grid asking all the cells if they should be alive by the time the next tick arrives. Once the grid has been scanned, the view triggers the "regenerate" event. The cell model listens to this event, and resets itself to the next state. That triggers the change event on the view, that repaints the cell.

That's how it's done.

##### The Components

The solution has two components that extend the Backbone.Component class. "localStorage" and "ticker". 

###### Local Storage Component

The local storage component is the one in charge of keeping track of changes in the browser's local storage. Objects are added, removed or retrieved using this object. It's also responsible of creating a json string representation of the games grid, and to update the grid from saved data.

At first, I've used the backbone.localstorage module, but it proved to be inneficient with the volume of data the application manages. Also, when saving a collection, an entry for every cell was created, making impossible to have more than one pattern stored. A custom implementation saving **only** the living cells. That reduced the size of the grid payload from 66kb to 500bytes for the representation of Gosper's Glider Gun.

###### Ticker Component

The ticker component only purpose in life is to "tick". It's the one responsible for all the time management of the application. Starting, Stoping and changing speed. This component dispatches the global "tick" event that makes the world move.

##### The Models and Collections

The solution has two models, and two corresponding collections. One for cells and another for items stored into the browsers local storage.

###### The Cell Model

This is the model that represents one cell. It's a standard backbone model with the exception that it listens to a global "regenerate" event. It has four properties. Location using X and Y coordinates, current living state and future state calculated by the shouldBeAlive method.
When the application broadcast the "regenerate" event (after a "tick" event), all the cells change their living state to the new value, triggering the "change" model event.
The core business rules are implemented here. The "shouldBeAlive" method receives a parameter with the count of the neighboring living cells, and sets the future state of the cell according to the rules of the game.

###### The World Collection

The world collections contains a representation of all the cells in the grid. This is the other class responsible for the games rules, because it needs to accurately calculate the number of neighboring living cell for any model it holds.
When this collection is created, it initializes itself using the width and height provided by the application view. This is important, because there's only one instance of this class across the application, and several views (load, save, world) hold a reference to it to.
It can randomize the state of the models, and also kill them all using the "clear" method.

But the important part is the "liveNeighbours" method. It uses an array representing the grid surrounding the cell in question, and returns the count of living cells. Here, like this:

![image](https://raw.github.com/rodrigoi/dojo/master/Conways-Game-of-Life/JavaScript/BackboneJS/docs/grid.PNG)

Using that model, you can request a cell by it's index or by it's location on the grid.

Width and Height of the grid are really important for those calculations ;)

###### The Storage Item Model

The storage item model is just a plain Backbone.Model with a key and value properties. There's really nothing special about this model.

###### The Storage Items Collection

The storage collection is a boring Backbone.Collection. There's nothing special about this collection.

##### The Views and Dialogs

The views in the solution make use of Backbone.View's "el" property to manipulate DOM elements already present on the page. With the exception of the cell view and the storage item view, none of the views uses a dynamic template. They just take advantage of the DOM. For the views that use a template, Underscore.JS template engine is used.

###### The Application View

The application view is responsible for the creation of all other views, and for subscribing to the lifespan form. It creates the generation counter view, the world view, the save and load dialogs and bubbles the events for the main task bar.
It also loads the demo patterns from a global object into the world view by means of the storage component.

It is responsible for keeping references to the sub views and the storage component.

###### Cell View

The cell view is extremely simple, but without it the application just won't work. It renders a div that represents the cell and bind to the change:alive event of the model. When the model changes for any reason, the cell repaints itself.
The repaint is really fast because it just changes a style of the default div created using the Views tagName property (not set because the default is ok).
It also accepts a click event that toggles the related model state, forcing another repaint.

###### World View

The world view is responsible for holding all the cell views in the grid. Besides the standard Backbone.View properties, it needs the width and height properties to be set, preferably using the constructor. If no collection is specified, it initializes an empty collection. That's mostly to make it easier to test.

It listens to the global "tick" event. If that event is dispatched, the view tells every cell to calculate their future state and, when done, triggers the "regenerate" event. That makes all the models to update their status.
Event handlers are in place in the Application View to trigger the randomize and clear methods upon user interaction.

###### Generation Counter and Controls

The Generations Counter and the Controls view are the most simplest things possible. They are just standard Backbone.View objects. In the case of the generations counter, it's listening to the "tick" event to update the counter it's keeping track of. It can receive a clear message to reset the counter to zero.

The Controls view dispatches the UI events of both toolbars. Those events are used by the Application view to load information into the world, or bubbled to the application class can manipulate the ticker component.

###### Storage Items, Save and Load Dialogs

The storage item view is used by the load dialog to show the user all the patterns stored on the browser local storage. It has a very simple template for a table row, with dynamic value for the patter name. It binds to the click event of two buttons, one that loads the items and another one that removes them. The view dispatches two events, because the processing of those actions takes place on the load view.

The save dialog window is created by the application view, and has a reference to the world collection and the storage object. It has two event handlers for the click events of the download and save button. The download button uses html5 file api to trigger a download, while the save pattern button uses the local storage component to save the pattern under the specified name.

The load dialog is created by the application view and has a bit more code than the save dialog. For starters, it has a more complex render method that keeps track of the changes in the localStorage items of the local storage component.
It also has to bind itself to the event of the storage item view. It uses the html5 file api to load dropped files, and binds to the special drag events.

Both dialogs use the Bootstrap "Modal" jQuery plugin.

##### The Tests

### Retrospective

Being this my first attempt to use mocha as the test runner for javascript applications intended to run in the browser, there are some…

#### Lessons Learned

- Running scripts intended to run in the browser on node.js requires a more careful planning of the application's namespaces. Using a browser runner you can be less strict with the application structure.
- You have to be extremely careful with the global scope, since it behaves differently on node.js.
- You have to treat the scripts as node modules. Or better, as a node module split across different files, but also implement careful measures to avoid breaking the browser functionality.
- Running all your scrips on the server is cool, but you have to dance a dangerous ballet with node's global scope.
- It you have to require to many files to make it run in the node.js runner, that's a good sign that the module may be doing more than it should be doing. The shorter the list, the better.
- Backbone sucks at dependency injection.

and...

#### Things to improve

- Implement the solution using an AMD. BackboneJS + RequireJS maybe? Testing will be interesting.
- ~~Clean up the module requires for the public scripts.~~
- The grid is held in place by css, modify the world view to create proper rows.
- Split the localStorage component into two. Local Storage and World utilities.
- Implement ZombieJS tests in mocha.
- Form Validation/Model Binding?
- Implement a Grunt lint/minify file.
- Remove the FOUC like behavior when the application starts.

## Extras

If you remember the Konami Code, there's something special behind one of the controls...

----

Have fun, and enjoy your burrito ;)

----

![image](https://raw.github.com/rodrigoi/dojo/master/Conways-Game-of-Life/JavaScript/BackboneJS/docs/sublime.png)