#!/usr/bin/env nu

# Open a dated markdown note in ~/repos/notes/
def main [] {
    let now = (date now)
    let year = ($now | date to-record).year
    let note_dir = $"($env.HOME)/repos/notes/($year)"
    mkdir $note_dir
    cd $note_dir
    hx ($now | format date "%Y-%m-%d.md")
}
