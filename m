From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 May 2014 19:50:30 +0000
Subject: Re: [PATCH/RFC 5/7] ARM: shmobile: r8a7791 dtsi: Enable DMA for QSPI
Message-Id: <CAMuHMdWWg1Py_sJOk9h-PO-33b0QuBhka-gX1-jXpZ0sji2zZw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1400254015-29539-6-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1400254015-29539-6-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 16, 2014 at 5:26 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -917,6 +917,9 @@
>                 reg = <0 0xe6b10000 0 0x2c>;
>                 interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
>                 clocks = <&mstp9_clks R8A7791_CLK_QSPI_MOD>;
> +               dmas = <&dma0 R8A7791_DMA_QSPI_RX CHCR_RX_32BIT>,
> +                      <&dma0 R8A7791_DMA_QSPI_TX CHCR_TX_32BIT>;
> +               dma-names = "rx", "tx";

This one is not correct: it should use 8BIT instead of 32BIT.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
