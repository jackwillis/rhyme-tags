# rhyme-tags

rhyme-tags is a web-based rhyme visualization tool.

[![GitHub tag](https://img.shields.io/github/tag/jackwillis/rhyme-tags.svg?style=flat-square)]()

## Usage

rhyme-tags uses a small tag-based markup language
to represent poems with rhyme data.

Here is an excerpt of "Fat Cats / Bigga Fish" by The Coup
marked up using this language:

    It's almost 10 o'clock, see, I got a ball of lint for { property: }
    So I slip my beanie on { sloppily: property }
    And promenade out to take up a { collection: }
    I got game like I read the { directions: collection }
    I'm wishing that I had an auto{ mobile: }
    As I feel the cold wind { rush past: }
    But let me state that I'm a hustler { for real: mobile }
    So you know I got the stolen { bus pass: rush past }

## Installation

rhyme-tags is intended to be built on Linux.
If you are using Windows 10, you should use
_Windows Subsystem for Linux_
([WSL](https://docs.microsoft.com/en-us/windows/wsl/about))
for compatibility.

Make sure [Node.js](https://nodejs.org)
and [npm](https://www.npmjs.com)
are installed on your system.

First, navigate to the project's directory and
install its Javascript dependencies:

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