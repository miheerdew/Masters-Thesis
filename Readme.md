This is my master's thesis on Infinite duration games (in preparation).

## Presentation
These are my thesis defence slides.

Some of the overlays are crated using [Lua](http://www.luatex.org). Copy the contents of `lib` folder into the place where luatex [searches for libraries](http://tex.stackexchange.com/questions/30438/lua-tree-analogue-of-texmf-tree/31904#31904) (eg. `~/Library/texmf/scripts/lua/` for MacTex on osx).

To compile - change to the `presentation` directory and run -

```
./doit.sh
```

It might take a while to compile because of lot of overlays and requires multiple compilations because of biblatex. The final output will be stored in `presentation.pdf`

## Report
This is the thesis report (in preparation)

To compile - change to the `report` directory and run

```
./doit.sh
```
The final ouput will be stored in `thesis.pdf`.

### Dependencies
If things do not work properly, check if you have the following installed -

* [Latexmk](http://users.phys.psu.edu/~collins/software/latexmk-jcc/)

