CC=emcc
TSC=tsc
LDFLAGS=-std=c++11 -O2 --llvm-opts 2

all: glcore.js triangle.js main

triangle.js: triangle.ts
	$(TSC) triangle.ts --out triangle.js

glcore.js: visualizer.cpp shaders.cpp shaders.h triangle.js
	$(CC) visualizer.cpp shaders.cpp --bind \
		  -s FULL_ES2=1 \
		  -s EXPORTED_FUNCTIONS="['_initGL','_drawTriangle']" \
		  -s EXTRA_EXPORTED_RUNTIME_METHODS='["ccall", "cwrap", "setValue"]' \
		  $(LDFLAGS) -o glcore.js

main: visualizer.cpp visualizer.h shaders.cpp shaders.h
	clang visualizer.cpp shaders.cpp -std=c++11 -O2 -o main_app

clean:
	rm -rf triangle.js
	rm -rf glcore.js
	rm -rf glcore.wasm
	rm -rf glcore.js.map
