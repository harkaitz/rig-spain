# RIG (Random Identity Generator) data for Spain

## Sources

The names and surnames data has been taken from Marc Boquet's
"spanish-names" project [here](https://github.com/marcboquet/spanish-names).

The town and street data has been taken from the INE (National Institute of
statistics). I got some inspiration [here](https://github.com/inigoflores/ds-codigos-postales-ine-es/blob/master/scripts/lib/ProcessCommand.php).

## Prerequisites for the download.sh script.

- sh-hutil
- sh-hcc
- sh-getsrc
- bsdtar
- wget
- gcc compiler

## Installation (Only needs make)

As always.

    make install PREFIX=/usr/local DESTDIR=/

## Example output

```
$ rig -c 5 -d /usr/local/share/rig/spain
Maria_Mar Heras
949 xxxxxxxxxxxxxxx
Chiclana, xx  11130
(000) xxx-xxxx

Rogelio Florido
453 xxxxxxxxxxxxxxx
Lleida, xx  25001
(000) xxx-xxxx

Rayan Feijoo
615 xxxxxxxxxxxxxxx
Lleida, xx  25001
(000) xxx-xxxx

Antonio_Jose Haro
992 xxxxxxxxxxxxxxx
Elche/Elx, xx  03202
(000) xxx-xxxx

Zohra Alemany
708 xxxxxxxxxxxxxxx
Mataro, xx  08301
(000) xxx-xxxx
```

## Collaborating

For making bug reports, feature requests and donations visit
one of the following links:

1. [gemini://harkadev.com/oss/](gemini://harkadev.com/oss/)
2. [https://harkadev.com/oss/](https://harkadev.com/oss/)

