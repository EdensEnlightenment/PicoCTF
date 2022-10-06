# General Skills:

## Obedient Cat:
### Provided input(s): file named `flag` with no extension

Hint 3 suggests to try `$ man cat`
This opens the manual page for the `cat` command, short for "concatenate and print files", which outputs the contents of a file to std out.

Inspired by the hint, the intended solution is probably to use `$ cat flag` and grab the flag from that output.

I personally just opened the file with Nano, which displays the same information as if you were to try `$ cat flag`

## Python Wrangling:
### Provided input(s): files named `ende.py`, `pw.txt`, `flag.txt.en`

After opening `ende.py` in an editor, we can see the following interesting lines of code - 

```python	
usage_msg = "Usage: "+ sys.argv[0] +" (-e/-d) [file]"
help_msg = usage_msg + "\n" +\
	"Examples:\n" +\
	"  To decrypt a file named 'pole.txt', do: " +\	
        "'$ python "+ sys.argv[0] +" -d pole.txt'\n"
```

Reading over these, it looks like the program accepts two arguments, `-e` or `-d`, as well as a target file.

We can infer from the next line where we're told we can decrypt a file with the `-d` flag that `-e` probably encrypts.

In any case, the goal here is to find a flag - so, let's try decrypting the `flag.txt.en` (en for encrypted?) file that we've been provided.

First, we'll check what pw.txt contains - this can be done with any text editor or `$ cat pw.txt`.

In my case the pw appears to be `aa821c16aa821c16aa821c16aa821c16`, so we copy that, then run ende.py (**en**crypt, **de**crypt?) with the `-d` argument and pass it the `flag.txt.en` file.

```
> python3.10 ende.py -d flag.txt.en
Please enter the password:
> aa821c16aa821c16aa821c16aa821c16
picoCTF{4p0110_1n_7h3_h0us3_aa821c16}
```

Voila! There we have our flag.

## Wave a flag:

### Provided input(s): a file called "warm" with no extension, which the prompt describes as a program.

One of the hints suggests that this file/program is only usable on Linux, and provides information on making it executable using `cmhod +x warm`.

Due to the fact that both my laptop and my Raspberry Pi use an ARM CPU, I'm unable to run the provided warm file, so to the PicoCTF-provided web terminal we go.

wget the `warm` file, then in the same directory run `$ chmod +x warm` to make it executable. Now, you can run it by typing `$ ./warm` in the directory it is located in.

Upon first run, it outputs "Hello user! Pass me a -h to learn what I can do!" - simple enough! Try running it again but this time as `$ ./warm -h` to pass the `-h` (usually short for --help) argument.
			
`Oh, help? I actually don't do much, but I do have this flag here: picoCTF{b1scu1ts_4nd_gr4vy_755f3544}`

And just like that, we have another flag!

## Nice netcat...

### Provided input(s): `$ nc mercury.picoctf.net 43239`

Running the provided command writes a series of 2-3 digit numbers to std out. Hint 2 helpfully references reading/writing ASCII, so let's start there.

Using [this](https://codebeautify.org/ascii-to-text) ASCII to text converter, we're able to translate the output of the command to `picoCTF{g00d_k1tty!_n1c3_k1tty!_7c0821f5}`. 

One thing I did notice with this and similar flags, is that not all translation sites are created equal. Some don't handle newlines well, some don't like not having a leading 0 on the 2 digit numbers, etc., so if one site gives you gibberish or something that seems adjacent to what you want, don't hesitate to try using another site!

## Static ain't always noise

### Provided input(s): Binary file named `static`, BASH script named `ltdis.sh`

The easy option here is of course to try running the provided script - opening the script shows that running with no arguments will suggest using it as `ltdis.sh <program-file>` - easy enough.

Using `$ sh ltdis.sh static` tells us that `static` was successfully disassembled, and that the result is available at `static.ltdis.x86_64.txt`, and any strings found in the file have been written to `static.ltdis.strings.txt`.

A simple `$ cat static.ltdis.strings.txt` outputs quite a lot of strings found in the binary, so let's try filtering it, shall we?

Using grep, we can filter the output of a given command by executing it and 'piping' it into grep, like so. `$ cat static.ltdis.strings.txt | grep 'pico'` - this searches the output for any strings which match the case sensitive input, and returns only those rather than the full output.

`picoCTF{d15a5m_t34s3r_1e6a7731}` - another flag found!
