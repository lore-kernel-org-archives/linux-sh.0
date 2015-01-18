From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 18 Jan 2015 11:15:34 +0000
Subject: Re: Bug#775611: [sh]: FTBFS due to unknown compiler option '-m32'
Message-Id: <CAMuHMdXe=hRZ_i=9-JPgmyKFhnn4GTOkhEam+LaA5qn0YWFOoQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1421575095.31046.99.camel@decadent.org.uk>
In-Reply-To: <1421575095.31046.99.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Sun, Jan 18, 2015 at 10:58 AM, Ben Hutchings <ben@decadent.org.uk> wrote:
> On Sun, 2015-01-18 at 00:35 +0100, John Paul Adrian Glaubitz wrote:
>> Package: linux
>> Version: 3.16.7-ckt4-1
>> Severity: normal
>> Tags: patch
>>
>> Hi!
>>
>> The kernel package currently fails to build from source on sh4 since
>> the build scripts try to pass the '-m32' compiler option on gcc which
>> is not available with gcc on sh4 (also according to the manpage).
>>
>> Selecting HAVE_C_RECORDMCOUNT in arch/sh/Kconfig (see attached patch
>> by Ben Hutchings) fixes the issues. However, I also suggest removing
>> the line "$cc .= " -m32";" for sh compiler options in scripts/
>> recordmcount.pl.
>
> Steven and SH experts, what do you think of this?

It seems most compilers don't support -m32, unless they're biarch.
On an Ubuntu 14.04 LTS box with lots of cross-compilers from korg/crosstool:

/usr/bin/c89-gcc OK
/usr/bin/c99-gcc OK
/usr/bin/x86_64-linux-gnu-gcc OK
/opt/cross/gcc-4.2.4-nolibc/avr32-linux/bin/avr32-linux-gcc cc1:
error: unrecognized command line option "-m32"
/opt/cross/gcc-4.8.0-nolibc/microblaze-linux/bin/microblaze-linux-gcc
microblaze-linux-gcc: error: unrecognized command line option '-m32'
/opt/cross/gcc-4.8.0-nolibc/powerpc64-linux/bin/powerpc64-linux-gcc OK
/opt/cross/gcc-4.5.1-nolibc/or32-linux/bin/or32-linux-gcc cc1: error:
unrecognized command line option "-m32"
/opt/cross/gcc-4.6.3-nolibc/crisv32-linux/bin/crisv32-linux-gcc cc1:
error: unrecognized command line option '-m32'
/opt/cross/gcc-4.6.3-nolibc/frv-linux/bin/frv-linux-gcc cc1: error:
unrecognized command line option '-m32'
/opt/cross/gcc-4.6.3-nolibc/bfin-uclinux/bin/bfin-uclinux-gcc cc1:
error: unrecognized command line option '-m32'
/opt/cross/gcc-4.6.3-nolibc/sparc64-linux/bin/sparc64-linux-gcc OK
/opt/cross/gcc-4.6.3-nolibc/m68k-linux/bin/m68k-linux-gcc cc1: error:
unrecognized command line option '-m32'
/opt/cross/gcc-4.6.3-nolibc/alpha-linux/bin/alpha-linux-gcc cc1:
error: unrecognized command line option '-m32'
/opt/cross/gcc-4.6.3-nolibc/sh4-linux/bin/sh4-linux-gcc cc1: error:
unrecognized command line option '-m32'
/opt/cross/gcc-4.6.3-nolibc/m32r-linux/bin/m32r-linux-gcc cc1: error:
unrecognized command line option '-m32'
/opt/cross/gcc-4.6.3-nolibc/ia64-linux/bin/ia64-linux-gcc cc1: error:
unrecognized command line option '-m32'
/opt/cross/gcc-4.6.3-nolibc/xtensa-linux/bin/xtensa-linux-gcc cc1:
error: unrecognized command line option '-m32'
/opt/cross/gcc-4.6.3-nolibc/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-gcc
cc1: error: unrecognized command line option '-m32'
/opt/cross/gcc-4.6.3-nolibc/am33_2.0-linux/bin/am33_2.0-linux-gcc cc1:
error: unrecognized command line option '-m32'
/opt/cross/gcc-4.6.3-nolibc/mips64-linux/bin/mips64-linux-gcc cc1:
error: unrecognized command line option '-m32'
/opt/cross/gcc-4.6.3-nolibc/s390x-linux/bin/s390x-linux-gcc cc1:
error: unrecognized command line option '-m32'
/opt/cross/gcc-4.6.3-nolibc/hppa64-linux/bin/hppa64-linux-gcc cc1:
error: unrecognized command line option '-m32'
/opt/cross/gcc-linaro-aarch64-none-elf-4.8-2013.08_linux/bin/aarch64-none-elf-gcc
aarch64-none-elf-gcc: error: unrecognized command line option ‘-m32’

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
