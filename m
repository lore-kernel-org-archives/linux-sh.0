From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Oct 2015 08:27:49 +0000
Subject: Re: [PATCH v5 5/5] clk: shmobile: r8a7795: Add new CPG/MSSR driver
Message-Id: <CAMuHMdVDb-7AbCLJJAPGPY-dEVPbcevL3K8eA4eQpHL8_3pAOQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1446117664-6037-1-git-send-email-geert+renesas@glider.be>
	<1446117664-6037-6-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1446117664-6037-6-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-clk <linux-clk@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Oct 29, 2015 at 12:21 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Add a new R-Car H3 Clock Pulse Generator / Module Standby and Software
> Reset driver, using the new CPG/MSSR driver core.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v5:

>   - Enter shmobile subdir if CONFIG_ARCH_RENESAS=y,

BTW, I kept wondering how I had forgotten that in v4.

Found it: "[PATCH v3 01/04] clk: shmobile: Get rid of
CONFIG_ARCH_SHMOBILE_MULTI" did ...

> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_COMMON_CLK_QCOM)         += qcom/
>  obj-$(CONFIG_ARCH_ROCKCHIP)            += rockchip/
>  obj-$(CONFIG_COMMON_CLK_SAMSUNG)       += samsung/
>  obj-$(CONFIG_ARCH_SHMOBILE_MULTI)      += shmobile/

... s/CONFIG_ARCH_SHMOBILE_MULTI/CONFIG_ARCH_SHMOBILE/,
which is IMHO a better solution, but that disappeared in v4 and later.

> +obj-$(CONFIG_ARCH_RENESAS)             += shmobile/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
