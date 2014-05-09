From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 09 May 2014 08:46:01 +0000
Subject: Re: [PATCH 00/03] pinctrl: sh-pfc: Extend Multiplatform Support
Message-Id: <CAMuHMdWoascFLbHYJV0cRzpuPXr75QwoEk1xM04ncb3hC2GPNw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140507231748.29661.46207.sendpatchset@w520>
In-Reply-To: <20140507231748.29661.46207.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Thu, May 8, 2014 at 1:17 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> pinctrl: sh-pfc: Extend Multiplatform Support
>
> [PATCH 01/03] pinctrl: sh-pfc: r8a7740: Allow Multiplatform Build
> [PATCH 02/03] pinctrl: sh-pfc: sh73a0: Allow Multiplatform Build
> [PATCH 03/03] pinctrl: sh-pfc: r8a73a4: Allow Multiplatform Build
>
> These patches enable Multiplatform support for r8a7740, sh73a0 and r8a73a4.

Thanks  for your patches!

> The legacy case is still kept around, so the mach-header is still needed
> to allow static GPIO-IRQ assignment. In case of DT the GPIO IRQs are already
> provided via DT properties, so we can simply #ifdef out the static IRQ tables
> in case of Multiplatform build. Not pretty but it works.

I think it's worthwhile to add the above paragraph to the individual patches,
as the cover letter is not committed.

Speaking about the DT properties: this is handled through the "intc*" and
"irqc*" pinmux groups on r8a7740 resp. r8a73a4, right?

r8a7740-armadillo800eva-reference.dts does have a reference to pinmux
group intc_irq10, but arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
doesn't have any. Perhaps the feature is unused on ape6evm?

How is it handled on sh73a0? I didn't find any irq pinmux group definitions
in drivers/pinctrl/sh-pfc/pfc-sh73a0.c. Am I missing something?

Thanks again!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
