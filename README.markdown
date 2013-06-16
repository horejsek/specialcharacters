Special Characters
==================

Warning: This was my first app using little bit more JavaScript, CoffeeScript & Closure Compiler. Code looks like that, so do not copy & paste it. This was just my sandbox. :)

Chrome extension
----------------

Helper for insert of special characters. You can copy characters into clipboard in popup window or insert it in each form element by context menu.

There are several default collection of characters after installation:
 * Czech,
 * English,
 * Smiles,
 * Cards,
 * and Arrows.
And you can set own collection in options page.

How to install
==============

Chrome extension
----------------

You can install it from Chrome web store here:
http://chrome.google.com/webstore/detail/nipbfgjelgfmhomikiffppkdpmienjnp/

How to develop
==============

Chrome extension
----------------

Extract it (if source is in archive), then run `make localdev` for preparing
development environment.

By command `make compile` you compile CoffeeScript and Closure library into
JavaScript. Then you can in Chrome (or Chromium) go to Extension and check
checkbox on top right corner 'Developer mode' and load it with clicking
on the button 'Load unpacked extension'.

Command `make test` is running before every commit. If tests not pass, commit
will not be finished.

