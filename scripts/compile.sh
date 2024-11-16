#!/usr/bin/sh
execute_latexmk() {
    root_dir=$(pwd)

    aux_dir=$root_dir/build
    out_dir=$root_dir/dist
    source_dir=$root_dir/src

    main_file=$source_dir/main.tex
    bib_file=$source_dir/bibliography.bib

    export TEXINPUTS=$source_dir:$TEXINPUTS

    echo "Cleaning up old files..." && latexmk -c

    echo "Compiling..." && latexmk \
        -auxdir="$aux_dir" \
        -bibtex \
        -cd \
        -dvi \
        -f \
        -gg \
        -interaction=nonstopmode \
        -outdir="$out_dir" \
        -synctex=1 \
        "$main_file"

    echo "Creating README..." && pandoc \
        --from latex \
        --to rst \
        --bibliography "$bib_file" \
        --biblatex \
        --citeproc \
        --output "README.rst" \
        "$main_file"

    echo "Done."
}

execute_latexmk
