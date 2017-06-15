From: Rob Landley <rob@landley.net>
Date: Thu, 15 Jun 2017 18:00:02 +0000
Subject: Re: QEMU serial still broken in -rc1.
Message-Id: <115593de-e961-af5b-3647-ca6a3cdfda7a@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <cdec4797-afe1-11f8-f926-fb5d356da625@landley.net>
In-Reply-To: <cdec4797-afe1-11f8-f926-fb5d356da625@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 06/15/2017 01:26 AM, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Thu, Jun 15, 2017 at 3:07 AM, Rob Landley <rob@landley.net> wrote:
>> On 06/14/2017 08:48 AM, John Paul Adrian Glaubitz wrote:
>>> On Sun, May 14, 2017 at 09:46:07PM -0500, Rob Landley wrote:
>>>> I refer to the previous thread, which is still the case:
>>>>
>>>> http://www.spinics.net/lists/linux-sh/msg51190.html
>>>>
>>>> I poked at QEMU's internals to see if there was an easy way to fiddle
>>>> with stuff, but A) ttySC1 appears to be the only serial type the board
>>>> emulates, B) the ttySC0 instance is broken, dunno why.
>>>
>>> I gave it a try myself now and I can't get the emulated machine to
>>> boot or show any output over the serial console.
>>>
>>> It hangs here:
>>>
>>> root@nofan:~/sh4-system> qemu-system-sh4 -M r2d -m 1000M -drive file=sh4-system.img,format=qcow2 -nographic -append "root=/dev/sda1 rw console=ttySC0 earlyprintk=sh-sci.1" -kernel vmlinux-3.18.0-trunk-sh7751r
>>> long read to SH7750_WCR1_A7 (0x000000001f800008) ignored
>>> long read to SH7750_WCR2_A7 (0x000000001f80000c) ignored
>>> long read to SH7750_WCR3_A7 (0x000000001f800010) ignored
>>> long read to SH7750_MCR_A7 (0x000000001f800014) ignored
>>> long read to SH7750_MCR_A7 (0x000000001f800014) ignored
>>>
>>> Any ideas?
>>
>> By default qemu-system-sh4 outputs to the broken first serial port
>> (which Linux apparently has no driver for) instead of the second serial
>> port that Linux does have a driver for. I have no idea why it does that,
>> but you have to add extra command line options to work around it:
> 
> The first serial port is a SCI, which should be supported by the sh-sci
> driver, too.
> 
> Perhaps the issue is that using the first port as a serial console depends
> on the bootloader initializing it?
> Does it work as a normal serial port from userspace?

I've never gotten any output from it (despite trying every couple years
since
https://lists.nongnu.org/archive/html/qemu-devel/2009-02/msg00825.html
). The most recent interaction I had with them was
https://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg04425.html
where they doubled down on it.

The very first submission of qemu-system-sh4 said "Use these options to
get the serial ports right":

https://lists.nongnu.org/archive/html/qemu-devel/2007-09/msg00530.html

Here's one of my periodic attempts at trying the other one:

http://lists.gnu.org/archive/html/qemu-devel/2010-03/msg00976.html
http://lists.gnu.org/archive/html/qemu-devel/2010-03/msg01005.html

If you can get it to work, I'd love to drop that strangeness. It's never
worked with Linux in the history of qemu, that I'm aware of.

The relevant serial init plumbing in qemu/hw/sh4/sh7750.c is:

    sh_serial_init(sysmem, 0x1fe00000,
                   0, s->periph_freq, serial_hds[0],
                   s->intc.irqs[SCI1_ERI],
                   s->intc.irqs[SCI1_RXI],
                   s->intc.irqs[SCI1_TXI],
                   s->intc.irqs[SCI1_TEI],
                   NULL);
    sh_serial_init(sysmem, 0x1fe80000,
                   SH_SERIAL_FEAT_SCIF,
                   s->periph_freq, serial_hds[1],
                   s->intc.irqs[SCIF_ERI],
                   s->intc.irqs[SCIF_RXI],
                   s->intc.irqs[SCIF_TXI],
                   NULL,
                   s->intc.irqs[SCIF_BRI]);

Although there's also this bit in r2d.c:

    qdev_prop_set_ptr(dev, "chr-state", serial_hds[2]);

Which is just confusing because I didn't think there was a third serial
port? (MAX_SERIAL_PORTS is 4 in include/sysemu/sysemu.h so it's not
overflowing anything, it's just... weird. I found much of the qemu code
impenetrable even before they decided libglib was a good idea...)

At the moment what I'd _really_ like is for -M virt to work on the sh
arch instead of being arm-only. But I haven't even figured out how to
get the Linux kernel ELF loader to apply generically. (Half the
architectures can boot from vmlinux. The other half can't. There is no
obvious reason for this, but after about 6 hours down the rathole of
trying to make it work, it went back on the todo list. Let's see, that
would have been back around
https://lists.nongnu.org/archive/html/qemu-devel/2011-05/msg00678.html)

Rob
