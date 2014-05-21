From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 May 2014 19:53:48 +0000
Subject: Re: [PATCH/RFC 0/7] ARM: shmobile: r8a7791: Add preliminary DMA support
Message-Id: <CAMuHMdVx2jvdKmnkX=ByxDacZCub_Fhf-VTWZAUXEnsxcZHoSA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1400254015-29539-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1400254015-29539-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 16, 2014 at 5:26 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> This patch series adds preliminary DMA support for r8a7791, based on the
> work for r8a7790 by Ben Dooks (cfr. "[PATCH v2 0/9] Updates Renesas OF-DMA
> code").
>
>   - [1/7] DMA: shdma: Add r8a7791 support
>   - [2/7] ARM: shmobile: r8a7791 dtsi: add SYS-DMAC clocks
>   - [3/7] ARM: shmobile: r8a7791: Add SYS-DMAC channel definitions for
>           bindings
>   - [4/7] ARM: shmobile: r8a7791 dtsi: Add SYS-DMAC0 and SYS-DMAC1 nodes
>   - [5/7] ARM: shmobile: r8a7791 dtsi: Enable DMA for QSPI
>   - [6/7] ARM: shmobile: r8a7791 dtsi: Enable DMA for MSIOF
>   - [7/7] ARM: shmobile: koelsch dts: Enable sysdma0 and sysdma1
>
> This is NOT meant to be applied yet, hence the RFC status, as so far I
> couldn't get it to actually work.

The SYS-DMAC changes do work for QSPI. This does need changes to the QSPI
driver (spi-rspi), though, as the driver supported DMA only for RSPI modules
on SH.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
