From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 10 Sep 2015 09:25:13 +0000
Subject: Re: [PATCH 06/14][RFC] arm64: renesas: r8a7795: add SSI DMA support
Message-Id: <CAMuHMdWj-Zra7NSMAbDT7zuzJqfi0es-jipfkU1NdCWZXB_0UA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87io7in3xo.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87io7in3xo.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Thu, Sep 10, 2015 at 9:16 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index 4586690..aaafd3a 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -761,33 +761,53 @@
>                         rcar_sound,ssi {
>                                 ssi0: ssi@0 {
>                                         interrupts = <0 370 IRQ_TYPE_LEVEL_HIGH>;
> +                                       dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
> +                                       dma-names = "rx", "tx", "rxu", "txu";
>                                 };

According to the R-Car Gen3 datasheet, you exchanged the RX and TX MID/RIDs\
for all channels?

Interestingly, the values seem to be the same in the R-Car Gen2 datasheet,
and thus they are also wrong in e.g. r8a7791.dtsi?

(for SYS-DMAC, MIDs/RIDs differ between Gen2 and Gen3, and RX = TX +1 on Gen2,
but TX = RX + 1 on Gen3).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
