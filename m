From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Aug 2015 07:12:03 +0000
Subject: Re: renesas-drivers-2015-08-11-v4.2-rc6
Message-Id: <CAMuHMdXwnYFcAT2t-uQ2YWW1OQhNKu=wK+jiFgTYYz3CNfh_oQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1439282896-30594-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1439282896-30594-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Tue, Aug 18, 2015 at 2:59 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> BTW, I checked boot message. below happens randomly.
> (but, this didn't depend on sound issue)
>
> * happen randomly
>
> ----------------
>    ...
>    DMA: preallocated 256 KiB pool for atomic coherent allocations
>    renesas_irqc e61c0000.interrupt-controller: driving 10 irqs
>    sh-pfc e6060000.pfc: r8a77910_pfc support registered
>    No ATAGs?
>    hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
>    hw-breakpoint: maximum watchpoint size is 8 bytes.
> *  IRQ2 is asserted, installing da9063/da9210 regulator quirk
>    gpio-regulator regulator@1: Could not obtain regulator setting GPIOs: -517
>    gpio-regulator regulator@3: Could not obtain regulator setting GPIOs: -517
>    gpio-regulator regulator@5: Could not obtain regulator setting GPIOs: -517
>    vgaarb: loaded
>    SCSI subsystem initialized
>    libata version 3.00 loaded.
>    usbcore: registered new interface driver usbfs
>    usbcore: registered new interface driver hub
>    usbcore: registered new device driver usb
> *  i2c 6-0058: Masking da9063 interrupt sources
> *  i2c 6-0068: Masking da9210 interrupt sources
> *  i2c 6-0068: IRQ2 is not asserted, removing quirk
>    i2c-sh_mobile e60b0000.i2c: I2C adapter 6, bus speed 100000 Hz
>    media: Linux media interface: v0.10
>    Linux video capture interface: v2.00

The lines marked with "*" only happen after a full hardware reset (cold boot
or press of the reset button), not after soft-reset ("reboot" command).
Perfectly normal, cfr.
commit 663fbb52159cca6ffb049cb15b9f9d1cd7ad7d8a
Author: Geert Uytterhoeven <geert+renesas@glider.be>
Date:   Mon Mar 9 20:50:40 2015 +0100

    ARM: shmobile: R-Car Gen2: Add da9063/da9210 regulator quirk

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
