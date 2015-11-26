# style.vim

Code/text style switcher

## Commands

1. `:LooseStyle`
    * tab width = 4
    * use tabs for indention
1. `:StrictStyle`
    * tab width = 4
    * use spaces instead tabs for indention
    * strip trailing whitespaces on save
1. `:NodeStyle` see [Node.js Style Guide](https://github.com/felixge/node-style-guide)
    * tab width = 2
    * use spaces instead tabs for indention
    * strip trailing whitespaces on save


## Configuration

### `g:style_type`

Available values:

* `loose`
* `strict`, the default
* `node`


