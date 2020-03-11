# How to use this dir ?

## Behavior

When the profile is loaded, the (non-hidden) files in this directory will be listed (this `README.md` is ignored). For each file found, the corresponding `.sh` in `common/modules` will be sourced inside the `profile`.

Using `touch` is enough, the file in `options` has absolutely no requirement on its content. Directories, files ending in `.md` and files starting with a dot (`.`) will be ignored. Sub-directories and their contents are ignored (no recursive search).

The modules will be loaded after the file `common/basic.sh` but before the shell specific file. As such, modules are not suited for themes or shell-dependent configuration. See the appropriate shell directory for more informations on how to customize it for your needs.

## Example

```
$DIRCONFIG/sh/
├── options
│   ├── README.md
│   └── rust
└── common/modules/
    ├── abc.sh
    └── rust.sh
```

In this situation, `rust` will be loaded, `abc` will **not** be loaded.
