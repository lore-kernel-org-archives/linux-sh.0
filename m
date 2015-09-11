From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 11 Sep 2015 07:25:54 +0000
Subject: Re: [PATCH/RFC v2 3/5] arm64: dts: r8a7795: enable EthernetAVB on Salvator-X
Message-Id: <CAMuHMdWYLR4KnJ06oH2h9orZhn+XURWu7LwqESsCFY8pYG1mWg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441936996-18437-4-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1441936996-18437-4-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Fri, Sep 11, 2015 at 4:03 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> --- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> @@ -41,6 +41,11 @@
>                 renesas,groups = "scif2_data_a";
>                 renesas,function = "scif2";
>         };
> +
> +       avb_pins: avb {
> +               renesas,groups = "avb_mdc";
> +               renesas,function = "avb";
> +       };

This is not in pfc-r8a7795.c. I believe you using CONFIG_PINCTRL=n with
the bootloader settings?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
