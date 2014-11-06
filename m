From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 06 Nov 2014 19:33:19 +0000
Subject: Re: [PATCH v4 5/6] ARM: shmobile: sh73a0: add MSTP clock assignments to DT
Message-Id: <CAMuHMdUaZQ3A0VsbYrz+cRu3nRruN2wg3E+xmXZ+khTAOxqjFQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415292641-30331-6-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1415292641-30331-6-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 6, 2014 at 5:50 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> @@ -202,6 +209,7 @@
>                 interrupts = <0 140 IRQ_TYPE_LEVEL_HIGH
>                               0 141 IRQ_TYPE_LEVEL_HIGH>;
>                 reg-io-width = <4>;
> +               clocks = <&mstp3_clks SH73A0_CLK_MMCIF0>;

For consistency, I think it would be best to always add "clocks" just
below "interrupts".

So I can add "power-domains" just below clocks later ;-)

>                 status = "disabled";
>         };
>
> @@ -212,6 +220,7 @@
>                               0 84 IRQ_TYPE_LEVEL_HIGH
>                               0 85 IRQ_TYPE_LEVEL_HIGH>;
>                 cap-sd-highspeed;
> +               clocks = <&mstp3_clks SH73A0_CLK_SDHI0>;

Likewise.

>                 status = "disabled";
>         };
>
> @@ -223,6 +232,7 @@
>                               0 89 IRQ_TYPE_LEVEL_HIGH>;
>                 toshiba,mmc-wrprotect-disable;
>                 cap-sd-highspeed;
> +               clocks = <&mstp3_clks SH73A0_CLK_SDHI1>;

Likewise.

>                 status = "disabled";
>         };
>
> @@ -233,6 +243,7 @@
>                               0 105 IRQ_TYPE_LEVEL_HIGH>;
>                 toshiba,mmc-wrprotect-disable;
>                 cap-sd-highspeed;
> +               clocks = <&mstp3_clks SH73A0_CLK_SDHI2>;

Likewise.

>                 status = "disabled";
>         };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
