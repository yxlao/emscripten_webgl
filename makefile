CC=emcc
TSC=tsc
LDFLAGS=-O2 --llvm-opts 2

all: glcore.js triangle.js

triangle.js: triangle.ts
	$(TSC) triangle.ts --out triangle.js

glcore.js: visualizer.cpp shaders.cpp
	$(CC) $? --bind \
		  -s FULL_ES2=1 \
		  -s EXPORTED_FUNCTIONS="['_initGL','_drawTriangle']" \
		  -s EXTRA_EXPORTED_RUNTIME_METHODS='["ccall", "cwrap", "setValue"]' \
		  $(LDFLAGS) -o glcore.js
clean:
	rm -rf triangle.js
	rm -rf glcore.js
	rm -rf glcore.wasm
	rm -rf glcore.js.map
