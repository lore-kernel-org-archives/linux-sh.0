From: Rich Felker <dalias@libc.org>
Date: Thu, 22 Mar 2018 01:36:59 +0000
Subject: Moving forward with gdb sh native support?
Message-Id: <20180322013659.GA8118@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I've recently gotten a chance to get back into gdb support for the sh
architecture, and have a series of related patches I'm going to be
submitting upstream soon. The ones that aren't specific to
SH2/J2/nommu stuff are adding support for software single-step (the
hardware single-step assumed in the current linux-sh-low does not seem
to be supported, as least not by Linux, on the vast majority of real
and emulated hardware) and some minor bugfix prerequisites for that.
Currently my changes here only cover gdbserver since there's no
upstream sh-native support in gdb.

In conjunction with this I began looking again at the old sh native
patches, which Adrian Glaubitz has been maintaining for the Debian
side here:

https://github.com/glaubitz/binutils-gdb/commits/linux-sh

Having just looked at the gdbserver-side code for linux-sh, it looks
like there's a nontrivial amount of code duplication, and like there
will be even more if I copy my branch decoding (sh_get_next_pcs) code
for single-step over.

Is this how it's supposed to be, or is there a recommended way to
refactor it to share code between gdb and gdbserver? If so, does it
make sense to go forward with the existing patches for sh native and
then tweak to share some things, or would it make more sense to redo
the native support along with a heavier refactoring?

I know lack of sh native support has been a longstanding issue and
Adrian has been doing a likely-painful job of keeping the patches
up-to-date for a long time now, so whatever we do I hope we can work
out a solution that gets it upstream soon.

Rich
