From: Rob Landley <rob@landley.net>
Date: Thu, 18 Jun 2015 17:19:09 +0000
Subject: [PATCH 0/2] 0pf-j2 (sh2-compatible open hardware) FPGA board support.
Message-Id: <1434647946.861556@landley.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, ysato@users.sourceforge.jp

Basic board support for the open processor foundation j2, an sh2-compatible
open processor (built from BSD licesed VHDL) described in our Linuxcon Japan
presentation a couple weeks back, which was covered by Linux Weekly News at
https://lwn.net/Articles/647636/ and our slides are at
http://events.linuxfoundation.org/sites/events/files/slides/Turtles%20all%20the%20way.pdf

The first patch adds the new files, the second touches existing files.
This is just enough to boot to a serial prompt out of initramfs.

I'm aware there is... room for improvement. Yes I need to convert it to device
tree. Yes I need to clean up whatever the interrupt controller is doing.
Yes I need to fix the SPARSE_IRQ and GETTIMEOFFSET stuff. But it boots
initramfs to a shell prompt, and I want to get that out there.

This is the smallest chunk I could chip out that boots to a shell prompt via
initramfs and serial console. There are more drivers to come in future, but
at the moment they're all too ugly for words.

If you want to try this yourself, you can get a Numato Mimas v2 board at
https://numato.com/fpga-boards/xilinx/spartan6/mimas-v2-spartan-6-fpga-development-board-with-ddr-sdram.html
download a bitstream and vmlinux image from the "developer" tab of 0pf.org,
(yes, that's a zero, the Organgutan Protection Foundation predates the Open
Processor Foundation, but our marketing guys are running with it and saying
the zero stands for no licensing fees), and then presumably install them
with the (sadly python 3) bitstream flasher tool at
https://numato.com/community/threads/mimas-v2-programming-in-linux.15/
(then stick the kernel on a fat formatted sdcard in a file called "vmlinux"
and the bootloader should know what to do. These kernel patches haven't got
an mmc driver (it was too ugly for words, so was ethernet, we'll get there)
but the bootloader knows how to use it.

(We also have instructions for the spartan s6 avnet microboard if you
have one of those lying around or order one from
http://www.em.avnet.com/en-us/design/drc/Pages/Xilinx-Spartan-6-FPGA-LX9-MicroBoard.aspx
but adding an sdcard to that requires a soldering iron. There are external
4-pin sdcard readers for like $4 but the power/ground/data pins in the header
don't match up to the order mmc card readers want them, so you have to solder
on extension wires to the reader so you can reorder them. The numato is cheaper
_and_ has built-in sdcard. The avnet has built-in ethernet instead. The
same kernel runs on both, only the bitstreams differ.)

There's a VHDL build on 0pf.org too, which _can_ build bitstreams if you
can figure out how to install the Xilinx Webthing bitstream compiler. (Which
is a free download but immensely ugly. I'm working on proper documentation
for that, but the install process is outright eldrich. I'm also looking at
people trying to make open source bitstream compilers that work, but at the
moment that's "build a full linux distro with llvm or pcc" territory.
Oh, and the VHDL build needs an sh2-elf compiler, not sh2-unknown-linux,
because the symbol prefixes are different and the bootloader code is written
for the elf ones, not the linux ones. I'm told the ELF spec was translated
into japanese and the translation codepage switch changed punctation,
which is why the _ vs . thing happened in superh. The has underscore vs
does not have underscore is just ELF's fault.)

Toolchain to build kernel and userspace: the last code sourcery superh release
worked with elf2flt, aboriginal linux's sh2eb target builds a working
simple-cross-compiler also elf2flt, and the musl-libc.org have a working
fdpic setup. (With a horrible hack in the specfile to _not_ build the kernel
as pic code. In his defense, he got the horrible hack from gentoo.) I should
have prebuilt binaries in my next aboriginal linux release, I'll post about
them on the nommu.org list.

We're working on it. We want this all smoothed out by ELC Europe in october
because we're giving our talk there again _and_ we're doing a tutorial where we
give away a coupld dozen numato boards and walk everybody through building and
installing bitstreams on their own linux laptop, and we'd really like that not
to be the _first_ time somebody other than us makes it all work. (We _want_
to focus on teaching people VHDL programming, but there's so much surrounding
material that all has to work for that to be useful...)

Oh, linux laptop is good because the Numato boards only wired up 2 pins for
their serial port (no data terminal ready, no hardware flow control),
so you have to do something like "stty clocal -crtscts -cdtrdsr /dev/ttyUSB0"
to see terminal output, and for some reason it's impossible to do this on
macosx? Their stty man page says you can do it, but it doesn't work. Possibly
something to do with the way numato implemented their USB serial packatization
is tickling macosx the wrong way? Works on windows, works on linux, not on mac.
We've got a bug report in with numato and I'm told there's progress on that
front...

Sorry. Working on it. Have some kernel patches.

Rob
