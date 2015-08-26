From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Aug 2015 12:34:15 +0000
Subject: Re: [PATCH v2 3/3] ARM: shmobile: bockw dts: enable SMSC interrupt
Message-Id: <CAMuHMdXH0WTfF2cLxH2gG+zHG1H7oLmVVYo4Fg6n470N1ynY5g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1437751317-12235-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1437751317-12235-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Uli,

On Thu, Aug 20, 2015 at 5:45 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Clears bit 4 in IRQMR0 in the FPGA to enable the SMSC interrupt.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/boot/dts/r8a7778-bockw.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
> index 8a54076..73ba7de 100644
> --- a/arch/arm/boot/dts/r8a7778-bockw.dts
> +++ b/arch/arm/boot/dts/r8a7778-bockw.dts
> @@ -65,6 +65,23 @@
>  };
>
>  &bsc {
> +       fpga@18200000 {
> +               /* Simplified description that only serves to enable the
> +                * ethernet controller.
> +                */
> +               compatible = "pinctrl-single";

This needs CONFIG_PINCTRL_SINGLE=y in shmobile_defconfig and
multi_v7_defconfig, right?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
