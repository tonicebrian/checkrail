load(
    "@rules_haskell//haskell:defs.bzl",
    "haskell_toolchain_library",
    "haskell_library",
    "haskell_binary",
    "haskell_test",
    "haskell_repl",
)

GHC_FLAGS = [
      "-threaded",
      "-rtsopts",
      "-with-rtsopts=-N",
      "-XBangPatterns",
      "-XBinaryLiterals",
      "-XConstraintKinds",
      "-XDataKinds",
      "-XDefaultSignatures",
      "-XDeriveDataTypeable",
      "-XDeriveFoldable",
      "-XDeriveFunctor",
      "-XDeriveGeneric",
      "-XDeriveTraversable",
      "-XDoAndIfThenElse",
      "-XEmptyDataDecls",
      "-XExistentialQuantification",
      "-XFlexibleContexts",
      "-XFlexibleInstances",
      "-XFunctionalDependencies",
      "-XGADTs",
      "-XGeneralizedNewtypeDeriving",
      "-XInstanceSigs",
      "-XKindSignatures",
      "-XLambdaCase",
      "-XMultiParamTypeClasses",
      "-XMultiWayIf",
      "-XNamedFieldPuns",
      "-XNoImplicitPrelude",
      "-XNumericUnderscores",
      "-XOverloadedStrings",
      "-XPartialTypeSignatures",
      "-XPatternGuards",
      "-XPolyKinds",
      "-XRankNTypes",
      "-XRecordWildCards",
      "-XScopedTypeVariables",
      "-XStandaloneDeriving",
      "-XStrictData",
      "-XTupleSections",
      "-XTypeFamilies",
      "-XTypeSynonymInstances",
      "-XViewPatterns",
    ]

haskell_test(
    name = "test",
    srcs = glob(["test/**/*.hs"]) ,
    main_file = "test/Spec.hs",
    compiler_flags = GHC_FLAGS + [
        "-DSYDTEST_DISCOVER=$(execpath @stackage-exe//sydtest-discover)"
    ],
    tools = ["@stackage-exe//sydtest-discover"],
    deps = [
        ":checkrail-lib",
        "@stackage//:aeson",
        "@stackage//:base",
        "@stackage//:lens",
        "@stackage//:sydtest",
    ],
)

haskell_library(
    name = "checkrail-lib",
    srcs = glob([
        "src/**/*.hs",
    ]),
    visibility = ["//visibility:public"],
    deps = [
        "@stackage//:aeson",
        "@stackage//:base",
        "@stackage//:filepath",
        "@stackage//:lens",
        "@stackage//:openapi3",
        "@stackage//:pretty-simple",
        "@stackage//:yaml",
    ],
    compiler_flags = GHC_FLAGS,
)

haskell_binary(
    name = "checkrail",
    srcs = [
        "app/Main.hs",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":checkrail-lib",
        "@stackage//:base",
        "@stackage//:optparse-simple",
    ],
    compiler_flags = GHC_FLAGS,
)


haskell_repl(
  name = "hie-bios",
  collect_data = False,
  deps = [
    ":checkrail",
  ],
)
