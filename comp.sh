# Script to compile and run pass on $1(LLVM IR file $1.ll) argument.
cmake -G=Ninja -B ./build .
ninja -C ./build
opt -S -passes=toDot -load-pass-plugin=./build/libtoDot.so $1 -o $1.ll
dot -Tpdf main.dot -o main.pdf
echo "main.pdf DONE!"

