# boats

Turn based multi player Age of Sail combat simulation game with synchronous action,
constrained communications and cannon fire.

This implementation uses google's cross platform UI framework: https://flutter.dev/

A lot of code was shamelessly stolen from here: https://pub.dev/packages/hexagonal_grid which
implements this wonderful article on cube hex coordinates: https://www.redblobgames.com/grids/hexagons/

A web demo is available at https://thetrav.github.io/boats-example
however last I checked the performance was pretty rubbish.
It does much better on mobile devices and tablets, honest.

While, It could be used for fully remote play,
the intention is for this to be a support tool to aid in-person play,
which I have found to be fairly easy to accidentally cheat in
and somewhat time consuming for new players.