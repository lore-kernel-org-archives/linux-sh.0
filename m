From: peterz@infradead.org
Date: Thu, 16 Jul 2020 12:04:40 +0000
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-Id: <20200716120440.GD43129@hirez.programming.kicks-ass.net>
List-Id: <linux-sh.vger.kernel.org>
References: <b5cd845f-7b5e-af8e-a15d-3ede7e61ced4@physik.fu-berlin.de>
 <0322def7-fc16-c805-8f2b-c88fffce2f1e@physik.fu-berlin.de>
 <2df7ca7f-7e26-c916-b6ac-4ec1913fb8d7@physik.fu-berlin.de>
 <CAMuHMdXjfq=RjJ2doR7XyQMnZUA8ccxKc7_tyUzTX29tpyZojw@mail.gmail.com>
 <20200716094039.GQ10769@hirez.programming.kicks-ass.net>
 <20200716102934.GC43129@hirez.programming.kicks-ass.net>
 <f4fcb2e7-eca3-9a70-8e32-e3bf341b62eb@physik.fu-berlin.de>
 <20200716110146.GB119549@hirez.programming.kicks-ass.net>
 <008b06d4-1edd-1610-2ee1-6ea402d06114@physik.fu-berlin.de>
 <20200716113720.GC119549@hirez.programming.kicks-ass.net>
In-Reply-To: <20200716113720.GC119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Jul 16, 2020 at 01:37:20PM +0200, peterz@infradead.org wrote:
> $ /opt/cross/bin/sh4-linux-gcc --version
> sh4-linux-gcc (GCC) 10.1.0

$ git checkout origin/master # linus' tree
$ mkdir sh-defconfig
$ make O=sh-defconfig/ ARCH=sh CROSS_COMPILE=/opt/cross/bin/sh4-linux- defconfig # shx3_defconfig
$ make O=sh-defconfig/ ARCH=sh CROSS_COMPILE=/opt/cross/bin/sh4-linux- -j80

insane stream of errors


Help?
