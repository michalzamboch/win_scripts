$programs =
    "cmake",
    "gcc",
    "maven"

foreach ($item in $programs) {
    scoop install $item
}