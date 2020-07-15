From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Jul 2020 08:06:56 +0000
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-Id: <CAMuHMdWP6h+6uTq--wpP7xtSRRMScqM617a9w=p_bV=w90yVtw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200714121856.955680-1-hch@lst.de> <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
 <20200714155914.GA24404@brightrain.aerifal.cx> <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
 <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
 <CAMuHMdUre2-fRgLP8YiwjAKN6J=m1vGhPSMMUdpof7jPJfcWuw@mail.gmail.com> <47673a8f-cda1-4915-df20-068acfc49892@physik.fu-berlin.de>
In-Reply-To: <47673a8f-cda1-4915-df20-068acfc49892@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Adrian,

On Wed, Jul 15, 2020 at 9:37 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 7/15/20 9:27 AM, Geert Uytterhoeven wrote:
> > On Wed, Jul 15, 2020 at 1:14 AM John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> >> However, independent of Christoph's series, the kernels throws two backtraces during
> >> boot which I think should require a git bisect (unless I missed a configuration option
> >> as I trimmed down the kernel a bit to make sure it's not too big).
> >>
> >> See the traces below and let me know what you think.
> >
> >> [    1.560000] sh-sci.1: ttySC1 at MMIO 0xffeb0000 (irq = 44, base_baud = 0) is a scif
> >> [    1.560000] BUG: spinlock bad magic on CPU#0, swapper/1
> >> [    1.560000]  lock: sci_ports+0x1d8/0xb10, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> >
> > [PATCH v1] serial: core: Initialise spin lock before use in
> > uart_configure_port()
> > https://lore.kernel.org/r/20200706140036.75524-1-andriy.shevchenko@linux.intel.com
> Yes, this patch fixes this particular problem.
>
> There is just a typo in the code which causes a build problem but it's fixed by replacing
> "uport" with "port":

Oops, there's a v2 fixing that:
https://lore.kernel.org/linux-serial/20200706143548.63985-1-andriy.shevchenko@linux.intel.com/

>   CC      kernel/module.o
> drivers/tty/serial/serial_core.c: In function ‘uart_configure_port’:
> drivers/tty/serial/serial_core.c:2385:33: error: ‘uport’ undeclared (first use in this function); did you mean ‘port’?
>  2385 |    uart_any_port_spin_lock_init(uport);
>       |                                 ^~~~~
>       |                                 port
> drivers/tty/serial/serial_core.c:2385:33: note: each undeclared identifier is reported only once for each function it appears in
> make[3]: *** [scripts/Makefile.build:280: drivers/tty/serial/serial_core.o] Error 1
> make[2]: *** [scripts/Makefile.build:497: drivers/tty/serial] Error 2
> make[1]: *** [scripts/Makefile.build:497: drivers/tty] Error 2
> make[1]: *** Waiting for unfinished jobs....
>   AR      drivers/base/firmware_loader/built-in.a
>
> Will test the other changes in a minute.
>
> Can we include the serial fix?

Please be patient. I expect this to be fixed soon through the tty tree.

Note that linux-next already has an alternative fix (f38278e9b810b06a
("serial: sh-sci: Initialize spinlock for uart console")), which is
planned to be reverted once the real fix has been applied.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
