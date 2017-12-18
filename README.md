# rhyme-tags

[![GitHub tag](https://img.shields.io/github/tag/jackwillis/rhyme-tags.svg?style=flat-square)]()

## Installation

rhyme-tags is intended to be built on Linux.
If you are using Windows 10, you should install the
_Windows Subsystem for Linux_
([WSL](https://docs.microsoft.com/en-us/windows/wsl/about))
for compatibility.

Make sure [Node.js](https://nodejs.org)
and [npm](https://www.npmjs.com)
are installed on your system.
Then, navigate to the project folder and
install the project's Javascript dependencies:

    $ cd rhyme-tags/
    $ npm install

rhyme-tags uses [Elm](http://elm-lang.org),
a language that compiles to Javascript.
Install the Elm binaries and the project's Elm dependencies:

    $ npm install -g elm
    $ elm-package install

rhyme-tags compiles to one HTML file.
To build the project into `dist/index.html`, run:

    $ npm run build

To start the development server on `http://localhost:8080`, run:

    $ npm start