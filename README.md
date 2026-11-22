# BASIC 2 BASIC

An encyclopedia of the BASIC dialects of the 8-bit era.

In the late 1970s and the 1980s almost every home computer and pocket computer
came with its own BASIC. They all looked alike, yet hardly any two were truly
compatible: a `PRINT` that behaves a little differently, a graphics statement
that exists on one machine and not on another, keywords typed with a single key
on one keyboard and letter by letter on the next. BASIC 2 BASIC collects these
dialects in one place, so you can read each of them like a reference manual and
compare them with one another.

**Browse the site: <https://jojo-1973.github.io/BASIC_2_BASIC/site/>**

## What you will find

Start from a machine, pick one of its dialects and open its entries: statements,
commands, functions and operators, each with its syntax, parameters and allowed
values, keywords and tokens, examples and sources. Every dialect also has its
tables: error messages, operator precedence, character codes and glyphs, how the
program and the variables are laid out in memory, and more.

Two pages look across dialects. The **actions** table shows which dialects can
do what, and the **translator** looks for the equivalent of an entry in another
dialect. Equivalents are almost never one to one, and the translator says so
when there is none.

So far the encyclopedia covers the early Dartmouth BASIC editions, Sinclair
ZX80 BASIC and Casio FX-700P BASIC, with more to come. Examples marked
"to verify" have not been tried on real hardware or an emulator yet.

## How it is made

Everything lives in a single SQLite database, `basic2basic.db`, whose structure
is described in `schema.sql`. The data of each dialect is written as a small
Python source in `data/`, which generates the SQL that fills the database. The
site is static: `build_site.py` reads the database and writes plain HTML pages
into `site/`, so no server is needed. You can also download the repository and
simply open `site/index.html` in a browser.

To rebuild everything from scratch you need Python 3 with Jinja2 and Markdown:

```
python -m pip install jinja2 markdown
python rebuild_all.py
```

The design decisions and the current state of the work are described in
detail in [PROJECT.md](PROJECT.md).
