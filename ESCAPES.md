TERMINAL ESCAPES
================

Introduction
------------

The prompt includes some compact code which colors and otherwise alters the prompt. This document explains a little bit about the possible options.

Screen Color Escapes for BASH
-----------------------------

This was originally written for bash, so the color escapes for bash are still in here. Kinda useful if you want that stuff.

<table>
    <tr>
        <th>Colors</th>
        <th>Foreground</th>
        <th>Background</th>
    </tr>
    <tr><td>Black</td><td>30</td><td>40</td></tr>
    <tr><td>Red</td><td>31</td><td>41</td></tr>
    <tr><td>Green</td><td>32</td><td>42</td></tr>
    <tr><td>Yellow</td><td>33</td><td>43</td></tr>
    <tr><td>Blue</td><td>34</td><td>44</td></tr>
    <tr><td>Purple</td><td>35</td><td>45</td></tr>
    <tr><td>Cyan</td><td>36</td><td>46</td></tr>
    <tr><td>White</td><td>37</td><td>47</td></tr>
    <tr><td>Remove color</td><td>0</td><td>0</td></tr>
</table>

Colors are declared with:
> \e[<number>m

Colors should not add to the prompt width - surround them with:
> \[ \]


ZSH Trinary Construct
---------------------

%(<condition>.<true>.<false>)
? = status of last command

Screen Color Escapes for ZSH
----------------------------

Provided by the colors command, which can be loaded with:
> autoload colors zsh/terminfo
> if [[ "$terminfo[colors]" -ge 8 ]]; then
>         colors
> fi

Once this has been done the colors are available in the arrays:

* $fg[]
* $bg[]

The entries in the arrays are:

* red
* green
* yellow
* blue
* magenta
* cyan
* white

Colors should not add to the prompt width - surround them with:
> %{ %}

Information Escapes for ZSH Prompt
----------------------------------

<table>
    <tr>
        <th>Escape</th>
        <th>Description</th>
    </tr>
    <tr><td>%#</td><td># if superuser, else %</td></tr>
    <tr><td>%n</td><td>username</td></tr>
    <tr><td>%m</td><td>hostname</td></tr>
    <tr><td>%.</td><td>last part of current directory</td></tr>
    <tr><td>%~</td><td>full path of current directory</td></tr>
    <tr><td>%T</td><td>time in 24h format 18:20</td></tr>
    <tr><td>%@ or %t</td><td>time in 12h format 06:20</td></tr>
    <tr><td>%*</td><td>time in 24h format with seconds 18:20:00</td></tr>
    <tr><td>%D{%l:%M:%S}</td><td>time in 12h format with seconds 06:20:00</td></tr>
    <tr><td>%D{%a %b %d}</td><td>date as Mon Jul 19</td></tr>
    <tr><td>%w</td><td>date as Mon 19</td></tr>
    <tr><td>%W</td><td>date as 07/19/2004</td></tr>
    <tr><td>%!</td><td>line number in shell history (for history substitution)</td></tr>
    <tr><td>%j</td><td>the number of background jobs</td></tr>
</table>

Prompt Escapes for Screen
-------------------------

# Escape-K Escape-\	-	Set the title of the screen
# (for zsh this is %{\ek\e\\%})

