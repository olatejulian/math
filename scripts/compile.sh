#!/usr/bin/sh
execute_latexmk() {
    root_dir=$(pwd)

    aux_dir=$root_dir/build
    out_dir=$root_dir/dist
    source_dir=$root_dir/src

    main_file=$source_dir/main.tex

    export TEXINPUTS=$source_dir:$TEXINPUTS

    latexmk -c

    latexmk \
        -auxdir="$aux_dir" \
        -bibtex \
        -cd \
        -f \
        -gg \
        -interaction=nonstopmode \
        -outdir="$out_dir" \
        -pdf \
        -synctex=1 \
        "$main_file"

    pandoc \
        --from latex \
        --to markdown \
        --read "$main_file" \
        --output "README.md"

}

execute_latexmk
