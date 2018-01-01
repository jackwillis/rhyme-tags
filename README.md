# rhyme-tags

rhyme-tags is a web-based rhyme visualization tool.

[![GitHub tag](https://img.shields.io/github/tag/jackwillis/rhyme-tags.svg?style=flat-square)]()

See the online demo: https://www.attac.us/rhyme-tags

## Usage

rhyme-tags uses a custom poetry markup language.

Here is an excerpt of "Fat Cats, Bigga Fish" by The Coup,
marked up for rhyme-tags:

> It's almost 10 o'clock, see, I got a ball of lint for **{ property: }**  
> So I slip my beanie on **{ sloppily: property }**  
> And promenade out to take up a **{ collection: }**  
> I got game like I read the **{ directions: collection }**  
> I'm wishing that I had an auto **{ mobile: }**  
> As I feel the cold wind **{ rush past: }**  
> But let me state that I'm a hustler **{ for real: mobile }**  
> So you know I got the stolen **{ bus pass: rush past }**
    
Rhyming sections of a poem are enclosed by brackets in a
**{ text: tag }** format.

Notice that some rhymes have blank "tags."
This is a shorthand notation for rhymes whose "text" and "tag" fields are the same.
For example, the rhyme **{ rush past: rush past }** is the same as **{ rush past: }**.

Colors are chosen automatically.
Currently, there are no configuration options.

## Roadmap

* Share/load options (using query string)
* Comprehensive test suite using [elm-community/elm-test](https://github.com/elm-community/elm-test/)
* Use a continuous integration service
* [WAI-ARIA](https://www.w3.org/WAI/intro/aria) compliance

## Compiling from source

### Prerequisites

* [Node.js](https://nodejs.org)
* [npm](https://www.npmjs.com)

### Instructions

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

Alternatively, to start the development server at `http://localhost:8080`, run:

    $ npm start

## License

Copyright © 2017 Jackson Willis.

rhyme-tags is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.