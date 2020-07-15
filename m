From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 15 Jul 2020 07:37:26 +0000
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-Id: <47673a8f-cda1-4915-df20-068acfc49892@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200714121856.955680-1-hch@lst.de>
 <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
 <20200714155914.GA24404@brightrain.aerifal.cx>
 <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
 <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
 <CAMuHMdUre2-fRgLP8YiwjAKN6J=m1vGhPSMMUdpof7jPJfcWuw@mail.gmail.com>
In-Reply-To: <CAMuHMdUre2-fRgLP8YiwjAKN6J=m1vGhPSMMUdpof7jPJfcWuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Geert!

On 7/15/20 9:27 AM, Geert Uytterhoeven wrote:
> Hi Adrian,
> 
> On Wed, Jul 15, 2020 at 1:14 AM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
>> However, independent of Christoph's series, the kernels throws two backtraces during
>> boot which I think should require a git bisect (unless I missed a configuration option
>> as I trimmed down the kernel a bit to make sure it's not too big).
>>
>> See the traces below and let me know what you think.
> 
>> [    1.560000] sh-sci.1: ttySC1 at MMIO 0xffeb0000 (irq = 44, base_baud = 0) is a scif
>> [    1.560000] BUG: spinlock bad magic on CPU#0, swapper/1
>> [    1.560000]  lock: sci_ports+0x1d8/0xb10, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> 
> [PATCH v1] serial: core: Initialise spin lock before use in
> uart_configure_port()
> https://lore.kernel.org/r/20200706140036.75524-1-andriy.shevchenko@linux.intel.com
Yes, this patch fixes this particular problem.

There is just a typo in the code which causes a build problem but it's fixed by replacing
"uport" with "port":

  CC      kernel/module.o
drivers/tty/serial/serial_core.c: In function ‘uart_configure_port’:
drivers/tty/serial/serial_core.c:2385:33: error: ‘uport’ undeclared (first use in this function); did you mean ‘port’?
 2385 |    uart_any_port_spin_lock_init(uport);
      |                                 ^~~~~
      |                                 port
drivers/tty/serial/serial_core.c:2385:33: note: each undeclared identifier is reported only once for each function it appears in
make[3]: *** [scripts/Makefile.build:280: drivers/tty/serial/serial_core.o] Error 1
make[2]: *** [scripts/Makefile.build:497: drivers/tty/serial] Error 2
make[1]: *** [scripts/Makefile.build:497: drivers/tty] Error 2
make[1]: *** Waiting for unfinished jobs....
  AR      drivers/base/firmware_loader/built-in.a

Will test the other changes in a minute.

Can we include the serial fix?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
