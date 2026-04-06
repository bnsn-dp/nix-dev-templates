{
  description = "Language env templates";

  outputs = { self }: {
    templates = {
      rust = {
        path = ./rust;
        description = "Rust dev env w/ rust-overlay";
      };
      python = {
        path = ./python;
        descripttion = "Python 3.12 dev env";
      };
      typescript = {
        path = ./ts;
        description = "Typescript/Node.js dev env";
      };
      javascript = {
        path = ./js;
        description = "Javascript/Node.js dev env";
      };
      java = {
        path = ./java;
        description = "Java 21 dev env";
      };
      cpp = {
        path = ./cpp;
        description = "C++ with CMake and Clang";
      };
      c = {
        path = ./c;
        description = "C with CMake and Clang";
      };
    };
  };
}
