From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 19 Mar 2010 08:08:32 +0000
Subject: Re: building sh-2.6 git kernel with gcc 4.1.1 Sourgery G++ Lite 4.4-45
Message-Id: <20100319080832.GB10003@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201003190856.31112.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003190856.31112.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 19, 2010 at 08:56:30AM +0100, Fabio Giovagnini wrote:
> sh-linux-gnu-ld: arch/sh/kernel/module.o: uses instructions which are 
> incompatible with instructions used in previous modules
> sh-linux-gnu-ld: failed to merge target specific data of file 
> arch/sh/kernel/module.o
> make[2]: *** [arch/sh/kernel/built-in.o] Errore 1
> make[1]: *** [arch/sh/kernel] Errore 2
> make[1]: uscita dalla directory ?/home/fgiovagnini/sh7203/sh7203-uclinux-
> arn/sh-2.6?
> 
[snip]

> What cound be my problem?
> 
The problem is precisely what the error says, you are mixing and matching
sh2a and sh4a objects which just isn't going to work. The compiler you
are using only targets sh4a, which will not handle sh2a (evident by the
fact all of the sh2a tuning flags aren't part of your CFLAGS but do show
up in the LDFLAGS).

If you are using sh2a you will need a compiler that will deal with sh2a,
which you will most likely have to build yourself. The FDPIC compiler
from codesourcery isn't quite ready for general consumption yet, and the
few vendors that have binary sh2/sh2a toolchains are so laughably out of
date it's not even worth bothering with.
