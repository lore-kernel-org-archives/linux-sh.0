From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Aug 2015 07:25:20 +0000
Subject: Re: [PATCH] clk: shmobile: Get rid of CONFIG_SHMOBILE_MULTI
Message-Id: <CAMuHMdVEaJ_HXfXj182EpO+iT2E7-hbA+OqM17QnGPWHZC7Fug@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150826063325.5381.76761.sendpatchset@little-apple>
In-Reply-To: <20150826063325.5381.76761.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-clk@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Magnus,

On Wed, Aug 26, 2015 at 8:33 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Shmobile is all multiplatform these days, so get rid of the
> reference to CONFIG_ARCH_SHMOBILE_MULTI. Also instead of always
> enabling DIV6 and MSTP adjust the Makefile to enable DIV6 and
> MSTP depending on if they are included in the SoC or not.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

> --- 0001/drivers/clk/shmobile/Makefile
> +++ work/drivers/clk/shmobile/Makefile  2015-08-26 15:16:57.742366518 +0900
> @@ -1,13 +1,11 @@
>  obj-$(CONFIG_ARCH_EMEV2)               += clk-emev2.o
> -obj-$(CONFIG_ARCH_R7S72100)            += clk-rz.o
> -obj-$(CONFIG_ARCH_R8A73A4)             += clk-r8a73a4.o
> -obj-$(CONFIG_ARCH_R8A7740)             += clk-r8a7740.o
> -obj-$(CONFIG_ARCH_R8A7778)             += clk-r8a7778.o
> -obj-$(CONFIG_ARCH_R8A7779)             += clk-r8a7779.o
> -obj-$(CONFIG_ARCH_R8A7790)             += clk-rcar-gen2.o
> -obj-$(CONFIG_ARCH_R8A7791)             += clk-rcar-gen2.o
> -obj-$(CONFIG_ARCH_R8A7793)             += clk-rcar-gen2.o
> -obj-$(CONFIG_ARCH_R8A7794)             += clk-rcar-gen2.o
> -obj-$(CONFIG_ARCH_SH73A0)              += clk-sh73a0.o
> -obj-$(CONFIG_ARCH_SHMOBILE_MULTI)      += clk-div6.o
> -obj-$(CONFIG_ARCH_SHMOBILE_MULTI)      += clk-mstp.o
> +obj-$(CONFIG_ARCH_R7S72100)            += clk-rz.o clk-mstp.o
> +obj-$(CONFIG_ARCH_R8A73A4)             += clk-r8a73a4.o clk-mstp.o clk-div6.o
> +obj-$(CONFIG_ARCH_R8A7740)             += clk-r8a7740.o clk-mstp.o clk-div6.o
> +obj-$(CONFIG_ARCH_R8A7778)             += clk-r8a7778.o clk-mstp.o clk-div6.o
> +obj-$(CONFIG_ARCH_R8A7779)             += clk-r8a7779.o clk-mstp.o clk-div6.o

R-Car Gen1 doesn't have div6 clocks.

If you fix that,
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> +obj-$(CONFIG_ARCH_R8A7790)             += clk-rcar-gen2.o clk-mstp.o clk-div6.o
> +obj-$(CONFIG_ARCH_R8A7791)             += clk-rcar-gen2.o clk-mstp.o clk-div6.o
> +obj-$(CONFIG_ARCH_R8A7793)             += clk-rcar-gen2.o clk-mstp.o clk-div6.o
> +obj-$(CONFIG_ARCH_R8A7794)             += clk-rcar-gen2.o clk-mstp.o clk-div6.o
> +obj-$(CONFIG_ARCH_SH73A0)              += clk-sh73a0.o clk-mstp.o clk-div6.o

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
