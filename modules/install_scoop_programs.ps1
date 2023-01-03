$programs =
    "cmake",
    "gcc",
    "maven",
    "vcpkg",
    "conan",
    "ninja"

scoop update --all
foreach ($item in $programs) {
    scoop install $item
}