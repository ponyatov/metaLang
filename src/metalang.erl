%  powered by metaL: https://github.com/ponyatov/metaL/wiki/metaL-manifest
-module(metalang).

-export([hello/0, none/0]).

hello() ->
  world.
none() -> nil.
