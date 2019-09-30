# Buggy EEPROM code

## What is it?

It is the actual code mentioned in [the article about STM8 hardware bug](https://github.com/midnight-wonderer/stm8-eeprom-bug/wiki/STM8-EEPROM-unlocking-bug) that cause EEPROM writing instability issue. Read the article for more info and workaround of the issue.

## The hardware

I found the bug on one of these [STM8S development board](https://web.archive.org/web/20160623002534/https://www.cnx-software.com/2015/01/18/one-dollar-development-board/). To test the code on an actual hardware, you also need a tact switch connecting between pin C3 and ground and a device to read the content of EEPROM.  
Board specific code is in `firmware.c` you can effortlessly port the software to different boards if you want.

## List of software prerequisites to compile the code

* [Git](https://git-scm.com/) version >= 2.0
* [Small Device C Compiler](http://sdcc.sourceforge.net/) version >= 3.9.0
* [GNU Make](https://www.gnu.org/software/make/)
* [GNU Bash](https://www.gnu.org/software/bash/)

## Build instructions

Clone this repository with submodules and just `make`
```
$ git clone --recurse-submodules -b st-recommended-method https://github.com/midnight-wonderer/stm8-eeprom-bug.git
$ cd stm8-eeprom-bug
$ make
```

## License

The code has been released under the [MIT License](https://opensource.org/licenses/MIT).   
[The article](https://github.com/midnight-wonderer/stm8-eeprom-bug/wiki/STM8-EEPROM-unlocking-bug) was published under [Creative Commons BY-SA 4.0]( https://creativecommons.org/licenses/by-sa/4.0/)
