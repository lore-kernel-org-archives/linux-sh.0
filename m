From: Rob Landley <rob@landley.net>
Date: Mon, 11 Jan 2016 20:42:17 +0000
Subject: Re: Bootable sh4 qemu images.
Message-Id: <569413A9.6010301@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <568FFC28.2010409@landley.net>
In-Reply-To: <568FFC28.2010409@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/11/2016 12:02 PM, Peter Zijlstra wrote:
> On Fri, Jan 08, 2016 at 12:12:56PM -0600, Rob Landley wrote:
>> The sh4 images are "qemu-system-sh4.tar.gz", the current release (1.4.4)
>> is based on musl-libc and kernel 4.2
> 
>> P.S. Sorry I've fallen a couple kernel versions behind, I'm trying to
>> catch up
> 
> Ah, so you've not yet found if I broken SH in 4.3 with:
> 
> b31fdac2a921 ("sched, sh: Fold finish_arch_switch() into switch_to()")
> 
> :-)

It's working fine with 4.3, native compiling static binaries under musl
and everything:

(sh4:3) / $ gcc /usr/src/thread-hello2.c -lpthread --static
(sh4:3) / $ ./a.out
Hello world!
(sh4:3) / $ cat /proc/version
Linux version 4.3.0 (landley@halfbrick) (gcc version 4.2.1) #1 Mon Jan
11 13:24:23 CST 2016
(sh4:3) / $ cat /proc/cpuinfo
machine		: RTS7751R2D
processor	: 0
cpu family	: sh4
cpu type	: SH7751R
cut		: unknown
cpu flags	: fpu ptea
cache type	: split (harvard)
icache size	:  4KiB (2-way)
dcache size	:  4KiB (2-way)
address sizes	: 29 bits physical
bogomips	: 120.00
(sh4:3) / $

(Dynamic linked binaries are segfaulting but that's something I did
wrong when switching to musl. My toolchain is the last gplv2 releases of
everything, patched until they work. Something needs a patch, apparently.)

I might cut a release with _just_ the new kernel version to catch up...

Rob
