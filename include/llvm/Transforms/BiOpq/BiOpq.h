//===- BogusControlFlow.h - BogusControlFlow Obfuscation pass-------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===--------------------------------------------------------------------------------===//
//
// This file contains includes and defines for the bogusControlFlow pass
//
//===--------------------------------------------------------------------------------===//

#ifndef _BIOPQ_H_
#define _BIOPQ_H_


// LLVM include
#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Type.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/CodeGen/ISDOpcodes.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Transforms/IPO.h"
//#include "llvm/CryptoUtils.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Mangler.h"
#include <list>
#include <vector>

using namespace std;
using namespace llvm;

// Namespace
namespace llvm {
	Pass *createBogus ();
	Pass *createBogus (bool flag);
}
#endif

