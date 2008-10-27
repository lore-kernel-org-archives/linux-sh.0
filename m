From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Mon, 27 Oct 2008 04:08:15 +0000
Subject: Re: [PATCH] gdrom: Fix compile error
Message-Id: <20081027040814.GQ28946@ZenIV.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <29ab51dc0810261932n7580e87aua85103f8b1dcc5a5@mail.gmail.com>
In-Reply-To: <29ab51dc0810261932n7580e87aua85103f8b1dcc5a5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: linux-kernel@vger.kernel.org, Linux-sh <linux-sh@vger.kernel.org>

On Mon, Oct 27, 2008 at 11:32:27AM +0900, Nobuhiro Iwamatsu wrote:
> Return value and argument of block_device_operations.release of gdrom
> was changed.
> This patch fix this problem.

Serves me right for snide comments about the benefits of compile-testing ;-)
ACKed-by: Al Viro <viro@zeniv.linux.org.uk>

FWIW, sh/sh64 is the only cross-toolchain needed for the kernel I hadn't
managed to build - 4.3.0 gcc manages to trigger internal error in sh64 as(1)
(2.18.50.0.6) and AFAICS the same should happen with any binutils up to
-HEAD (the minimal testcase is
        .text
.LFB2:
        .section        .eh_frame,"a",@progbits
        .quad   .LFB2-.
and sh64 gcc4.3 routinely produces such things in its output).  gcc trunk
seems to have arseloads of changes in gcc/config/sh and I hadn't got around
to attempting a backport ;-/

Are there any public sh/sh64 toolchains based on not too heavily hacked
gcc/binutils, ideally for more or less recent variants of both?
