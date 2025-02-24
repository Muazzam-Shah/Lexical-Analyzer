# Automata Theory Semester Project: Lexical Analyzer

This repository contains the source code for a semester project in Automata Theory. It implements a lexical analyzer using Flex (a fast lexical analyzer generator) that tokenizes source code written in a C/C++-like language.

---

## Overview

The project demonstrates key concepts from Automata Theory by constructing a lexical analyzer that:
- **Tokenizes Input:** Recognizes identifiers, numeric constants, keywords, operators, punctuation, and comments.
- **Handles Comments:** Supports both single-line (`//`) and multi-line (`/* ... */`) comments.
- **Tracks Line Numbers:** Maintains line count information to facilitate error reporting and debugging.
- **Outputs Tokens:** Writes each recognized token along with its type and corresponding line number to an output file (`output.txt`).

---

## Files in the Repository

- **LA.i:**  
  The primary Flex source file containing the token definitions and rules. This file defines the regular expressions used to match tokens such as variables, constants, operators, and keywords.

- **radius & sum.cpp:**  
  Sample test files provided to demonstrate and verify the lexical analyzer's functionality.

- **output.txt:**  
  The file where tokenized output is written after the scanner processes an input file. (Generated upon running the analyzer)

- **README.md:**  
  This file, which provides an overview of the project, setup instructions, and usage guidelines.

---

## Prerequisites

Before compiling and running the project, ensure you have the following installed:
- **Flex:**  
  A tool for generating scanners (lexical analyzers). [Flex on GitHub](https://github.com/westes/flex)
  
- **GCC:**  
  A C compiler to compile the generated C code from Flex.

- **Basic Command Line Knowledge:**  
  Familiarity with terminal commands for compiling and running programs.

---

## How to Compile and Run

Follow these steps to build and execute the lexical analyzer:

1. **Generate the Scanner:**

   Use Flex to process the `LA.i` file:
   ```bash
   flex LA.i
   ```
   This command generates a file named `lex.yy.c`.

2. **Compile the Generated Code:**

   Compile the C source code with GCC:
   ```bash
   gcc lex.yy.c -o scanner -lfl
   ```
   The `-lfl` flag links the Flex library to the executable.

3. **Run the Scanner:**

   Execute the compiled scanner by providing an input file:
   ```bash
   ./scanner <input_file>
   ```
   For example, to test with the provided sample files:
   ```bash
   ./scanner radius
   ./scanner sum.cpp
   ```
   The tokenized output, including token types and line numbers, will be saved to `output.txt`.

---

## Project Structure

Below is an outline of the repository structure:

```
Automata-Theory-Semester-Project/
├── LA.i              # Flex source file with token definitions and rules
├── radius            # Sample test file for lexical analysis
├── sum.cpp           # Sample test file for lexical analysis
├── output.txt        # File generated after running the scanner
└── README.md         # Project overview and instructions
```

---

Happy tokenizing!
