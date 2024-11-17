#!/usr/bin/sh
execute_latexmk() {
    root_dir=$(pwd)

    aux_dir=$root_dir/build
    out_dir=$root_dir/dist
    source_dir=$root_dir/src

    main_file=$source_dir/main.tex

    export TEXINPUTS=$source_dir:$TEXINPUTS

    echo "#01: Cleaning up old files..."
    latexmk -c

    echo "#02: Compiling..."
    latexmk \
        -auxdir="$aux_dir" \
        -bibtex \
        -cd \
        -pdf \
        -f \
        -gg \
        -interaction=nonstopmode \
        -outdir="$out_dir" \
        -synctex=1 \
        "$main_file"

    echo "#03: Copying and renaming main file output..."
    cp "$out_dir/main.pdf" "$root_dir/estudos_matematicos.pdf"

    echo "#04: Done."
}

execute_latexmk
