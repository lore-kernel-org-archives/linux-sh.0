From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Jan 2016 16:48:42 +0000
Subject: Re: [RFC v4 2/4] arm64: dts: r8a7795: Add RWDT node
Message-Id: <CAMuHMdUkFKsyn-7rrQq_RrgmqXkFiiBe25-iemn+ySdoKS9Dxw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452287553-18895-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452287553-18895-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 8, 2016 at 10:12 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -135,6 +135,13 @@
>                                         (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>                 };
>
> +               wdt0: wdt@e6020000 {
> +                       compatible = "renesas,rwdt-r8a7795";
> +                       reg = <0 0xe6020000 0 0x0c>;
> +                       clocks = <&cpg CPG_MOD 402>;

Missing "power-domains = <&cpg>;"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
