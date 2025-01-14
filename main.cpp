#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/Casting.h"
#include <llvm/Support/Debug.h>
#include "llvm/Support/raw_ostream.h"

#include <fstream>
#include <random>

using namespace llvm;

void genDot(Function &F) {
    if (F.empty())
        return;

    // Filename
    const std::string funcName = F.getName().str();
    const std::string fileName = funcName + ".dot";
    dbgs() << "Dumping dot file on: " << fileName << '\n';
    std::ofstream myfile;
    myfile.open(fileName);
    if (!myfile.is_open()) {
        errs() << "File cant be open!\n";
        return;
    }

    // Header
    myfile << "digraph \"CFG for 'main' function\" {" << '\n';
    myfile << "\tlabel=\"CFG for " << funcName << " function\";" << "\n\n";

    /// Generate a name for each BasicBlock.
    DenseMap<BasicBlock *, std::string> BBtoName;
    for (BasicBlock &BB : F) {
        std::random_device rd;
        std::mt19937 mt(rd());
        std::uniform_int_distribution<int64_t> dist(1, 1e9);
        uint64_t random_num = dist(mt);
        std::string nodeName = "Node" + std::to_string(random_num);
        BBtoName[&BB] = nodeName;
    }

    for (BasicBlock &BB : F) {
        std::string nodeName = BBtoName[&BB];

        std::string byNodeStr =
            "\t"; // Fill this string with full value of this node

        byNodeStr += nodeName + ' ';

        std::string label = "\"{" + BB.getName().str() + ":\\l";
        for (Instruction &I : BB) {
            std::string instAsStr;
            raw_string_ostream stream(instAsStr);
            I.print(stream);
            label += ' ' + stream.str() + "\\l";
        }

        std::string pipeString = "";
        std::string nodeJump = "\t";

        Instruction *term = BB.getTerminator();
        if (isa<BranchInst>(term)) {
            if (term->getNumOperands() > 1) {
                pipeString += "|{<s0>T|<s1>F}";
                BasicBlock *right = dyn_cast<BasicBlock>(term->getOperand(1)),
                           *left = dyn_cast<BasicBlock>(term->getOperand(2));
                nodeJump += nodeName + ":s0 -> " + BBtoName[left] + ";\n\t";
                nodeJump += nodeName + ":s1 -> " + BBtoName[right] + ";\n";
            } else {
                BasicBlock *jump = dyn_cast<BasicBlock>(term->getOperand(0));
                nodeJump += nodeName + " -> " + BBtoName[jump] + ";\n";
            }
        }
        byNodeStr += "[shape=record, color=\"#000000\", style=filled, "
                     "fillcolor=\"#cbddfb\", label=" +
                     label + pipeString + "}\"];\n" + nodeJump;

        myfile << byNodeStr;
    }

    myfile << "}";
    myfile.close();
}

namespace toDot {
struct toDotPass : public PassInfoMixin<toDotPass> {
    PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM) {
        for (Function &F : M.getFunctionList()) genDot(F);
        return PreservedAnalyses::all();
    }
};
}

bool registerPipeline(StringRef Name, ModulePassManager &MPM,
                      ArrayRef<PassBuilder::PipelineElement>) {
    if (Name == "toDot") {
        MPM.addPass(toDot::toDotPass());
        return true;
    }
    return false;
}

PassPluginLibraryInfo toDotlib() {
    return {LLVM_PLUGIN_API_VERSION, "toDot", LLVM_VERSION_STRING,
            [](PassBuilder &PB) {
                return PB.registerPipelineParsingCallback(registerPipeline);
            }};
}

extern "C" LLVM_ATTRIBUTE_WEAK PassPluginLibraryInfo llvmGetPassPluginInfo() {
    return toDotlib();
}
