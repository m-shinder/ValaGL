# ValaGL

Fork of [Maia-Everett/valagl](https://github.com/Maia-Everett/valagl)

* Refactored & Rewriten to meson build system
* Fixed warnings
* Loading shaders with [GLib.Resource](https://valadoc.org/gio-2.0/GLib.Resource.html)

![Screenshot](./result.png)

## Installation

#### Dependencies
* libsdl2
* libepoxy
* glib

#### Build manualy

    $ meson setup --prefix=/usr build
    $ cd build
    $ ninja install