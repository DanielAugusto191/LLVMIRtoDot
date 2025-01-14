# To compare with dot-cfg pass.

#Generate LLVM IR, dotFiles using dot-cfg pass, and main function PDF.
clang -S -emit-llvm $1 -o $1.ll
opt -passes=dot-cfg $1.ll
mv .main.dot $1.dot
dot -Tpdf $1.dot -o $1.pdf
