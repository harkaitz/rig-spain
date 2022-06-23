#!/bin/sh -e
. vcd
. hlog
. hmain
. hcc
. getsrc-git
. getsrc-tar
rig_spain_update() {
    FORCE=1
    marcboquet_download_names
    ine_download_localities
    hlog info "Creating 'street.idx' (empty) ..."
    echo "xxxxxxxxxxxxxxx" > street.idx
}
rig_spain_update_calc_variables() {
    RIG_SPAIN_FNAMES=1000
    RIG_SPAIN_MNAMES=1000
    RIG_SPAIN_LNAMES=1000
    RIG_SPAIN_LOCDATA=61
    CALLEJERO_DATE="${CALLEJERO_DATE:-12022}"
}
## -----------------------------------------------------------------------------
marcboquet_download_names() {
    local url="https://github.com/marcboquet/spanish-names"
    local dir="`getsrc_git "${url}"`" pwd="`pwd`"
    if test -n "${FORCE}" || test ! -e fnames.idx; then
        hlog info "Creating 'fnames.idx' ..."
        sed "1d;$((${RIG_SPAIN_FNAMES}+1))q" "${dir}/mujeres.csv" \
            | cut -d ',' -f 1 \
            | capitalize      \
            | tr ' ' '_'      \
            > fnames.idx
    fi
    if test -n "${FORCE}" || test ! -e mnames.idx; then
        hlog info "Creating 'mnames.idx' ..."
        sed "1d;$((${RIG_SPAIN_MNAMES}+1))q" "${dir}/hombres.csv" \
            | cut -d ',' -f 1 \
            | capitalize      \
            | tr ' ' '_'      \
            > mnames.idx
    fi
    if test -n "${FORCE}" || test ! -e lnames.idx; then
        hlog info "Creating 'lnames.idx' ..."
        sed "1d;$((${RIG_SPAIN_LNAMES}+1))q" "${dir}/apellidos.csv" \
            | cut -d ',' -f 1 \
            | capitalize      \
            | tr ' ' '_'      \
            > lnames.idx
    fi
}
ine_download_localities() {
    local n f t
    ## Download Streets.
    local url="http://www.ine.es/prodyser/callejero/caj_esp/caj_esp_0${CALLEJERO_DATE}.zip"
    local src="`getsrc_tar -c 0 "${url}"`" pwd="`pwd`"
    ## Convert to UTF-8.
    if test -n "${FORCE}" || test ! -e locdata.idx; then
        hlog info "Creating 'locdata.idx' ..."
        < "${src}/Tramero" \
        hcc -include 'stdio.h' -include 'string.h' -main '
        char b[2000] = {0};
        while (fgets(b, sizeof(b)-1, stdin)) {
            b[110+24]=0;
            char *space = strchr(b+110, 0x20);
            if (space) *space = 0x0;
            printf("%.*s,%s\n", 5, b+42, b+110);
        }' \
        | iconv -f windows-1252 -t ascii//TRANSLIT \
        | sed '/,.* /d'            \
        | capitalize               \
        | uniq -s 5 -c             \
        | sort -rn                 \
        | sed "s/^ *[^ ]* *//;${RIG_SPAIN_LOCDATA}q" \
        | awk -F , '{printf "%s xx 000 %s\n",$2,$1}' \
        > locdata.idx
    fi
}
## -----------------------------------------------------------------------------
capitalize() {
    hcc -include 'stdio.h'  \
        -include 'string.h' \
        -include 'stdint.h' \
        -include 'ctype.h'  \
        -main '
    int  space = 1;
    int  character;
    while ((character = fgetc(stdin))!=EOF) {
        if (isspace(character) || strchr("\n,/", character)) {
            fputc(character, stdout);
            space = 1;
        } else if (space) {
            fputc(toupper(character), stdout);
            space = 0;
        } else {
            fputc(tolower(character), stdout);
            space = 0;
        }
    }
    return (ferror(stdin))?1:0;
    '
}
## -----------------------------------------------------------------------------
rig_spain_update_calc_variables
hmain -f "download.sh" -e rig_spain_update "$@"
