# Give your project a name. :)
workspace(name = "wargames-arena")

# Load the repository rule to download an http archive.
load(
    "@bazel_tools//tools/build_defs/repo:http.bzl",
    "http_archive"
)

load("@bazel_tools//tools/build_defs/repo:git.bzl"
     , "git_repository")

# Download rules_haskell and make it accessible as "@rules_haskell".
http_archive(
    name = "rules_haskell",
    strip_prefix = "rules_haskell-0.15",
    urls = ["https://github.com/tweag/rules_haskell/archive/v0.15.tar.gz"],
    sha256 = "aba3c16015a2363b16e2f867bdc5c792fa71c68cb97d8fe95fddc41e409d6ba8",
)

load(
    "@rules_haskell//haskell:repositories.bzl",
    "rules_haskell_dependencies",
)

# Setup all Bazel dependencies required by rules_haskell.
rules_haskell_dependencies()

load(
    "@rules_haskell//haskell:toolchain.bzl",
    "rules_haskell_toolchains",
)

load(
    "@rules_haskell//haskell:cabal.bzl",
    "stack_snapshot"
)

stack_snapshot(
    name = "stackage",
    components = {
        "sydtest-discover": [
            "exe",
            "lib",
        ],
    },
    extra_deps = {"zlib": ["@zlib.dev//:zlib"]},
    packages = [
        "aeson",
        "autodocodec-0.2.0.1",  # Required by sydtest
        "autodocodec-schema-0.1.0.2",  # Required by sydtest
        "autodocodec-yaml-0.2.0.2",  # Required by sydtest
        "base",
        "filepath",
        "lens",
        "optparse-simple",
        "openapi3",
        "pretty-simple",
        "safe-coloured-text-0.2.0.1", # Required by sydtest
        "sydtest-0.12.0.1",           # Out of LTS, so we add version
        "sydtest-discover-0.0.0.2",   # Out of LTS, so we add version
        "validity-0.12.0.1",             # Required by sydtest
        "validity-aeson-0.2.0.5",        # Required by sydtest
        "yaml",
        "zlib",
    ],

    # LTS snapshot published for ghc-8.10.7 (default version used by rules_haskell)
    snapshot = "lts-18.28",

    # This uses an unpinned version of stack_snapshot, meaning that stack is invoked on every build.
    # To switch to pinned stackage dependencies, run `bazel run @stackage-unpinned//:pin` and
    # uncomment the following line.
    # stack_snapshot_json = "//:stackage_snapshot.json",
)

# Download a GHC binary distribution from haskell.org and register it as a toolchain.
rules_haskell_toolchains(
    version = "8.10.7",
)

http_archive(
    name = "zlib.dev",
    build_file = "//:zlib.BUILD.bazel",
    sha256 = "c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1",
    strip_prefix = "zlib-1.2.11",
    urls = [
        "https://mirror.bazel.build/zlib.net/zlib-1.2.11.tar.gz",
        "http://zlib.net/zlib-1.2.11.tar.gz",
    ],
)
