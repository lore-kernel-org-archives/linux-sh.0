From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 28 Oct 2008 09:11:36 +0000
Subject: Re: [PATCH] gdrom: Fix compile error
Message-Id: <20081028091136.GB24850@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <29ab51dc0810261932n7580e87aua85103f8b1dcc5a5@mail.gmail.com> <20081027040814.GQ28946@ZenIV.linux.org.uk>
In-Reply-To: <20081027040814.GQ28946@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-kernel@vger.kernel.org, Linux-sh <linux-sh@vger.kernel.org>

On Mon, Oct 27, 2008 at 04:08:15AM +0000, Al Viro wrote:
> On Mon, Oct 27, 2008 at 11:32:27AM +0900, Nobuhiro Iwamatsu wrote:
> > Return value and argument of block_device_operations.release of gdrom
> > was changed.
> > This patch fix this problem.
> 
> Serves me right for snide comments about the benefits of compile-testing ;-)
> ACKed-by: Al Viro <viro@zeniv.linux.org.uk>
> 
Thanks, applied.

> FWIW, sh/sh64 is the only cross-toolchain needed for the kernel I hadn't
> managed to build - 4.3.0 gcc manages to trigger internal error in sh64 as(1)
> (2.18.50.0.6) and AFAICS the same should happen with any binutils up to
> -HEAD (the minimal testcase is
>         .text
> .LFB2:
>         .section        .eh_frame,"a",@progbits
>         .quad   .LFB2-.
> and sh64 gcc4.3 routinely produces such things in its output).  gcc trunk
> seems to have arseloads of changes in gcc/config/sh and I hadn't got around
> to attempting a backport ;-/
> 
The sh64 gcc is very volatile, finding a combination that works reliably
tends to take a fair bit of effort and random guesswork. The most recent
working one that has been tested is a combination of GCC 4.1.2 and
binutils 2.17. Gentoo's crossdev is capable of building this combination
out of the box.

> Are there any public sh/sh64 toolchains based on not too heavily hacked
> gcc/binutils, ideally for more or less recent variants of both?

I've placed a couple of binary toolchains on userweb:

	http://userweb.kernel.org/~lethal/toolchains/

http://userweb.kernel.org/~lethal/toolchains/gnush4_linux_v0801-test-1-1.i386.tar.gz
in particular is what is most widely used for sh at present, and is a gcc
4.2.1 and binutils 2.17.50 combination. There are not too many deviations
from mainline there however, so most recent combinations should be
buildable. I don't believe anyone has looked at gcc 4.3.0 yet though.
