From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Aug 2015 09:19:06 +0000
Subject: Re: [PATCH v3 04/04] clk: shmobile: rcar-gen3: Add CPG/MSTP Clock Domain support
Message-Id: <CAMuHMdWdmbHyv5YnFKh=ixMjPJGGyhSFyo5GqBs3S9L1H+iERQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150828091550.21731.85227.sendpatchset@little-apple>
	<20150828091636.21731.26416.sendpatchset@little-apple>
In-Reply-To: <20150828091636.21731.26416.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-clk@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Michael Turquette <mturquette@baylibre.com>, Linux-sh list <linux-sh@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Fri, Aug 28, 2015 at 11:16 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Shmobile is all multiplatform these days, so get rid of the
> reference to CONFIG_ARCH_SHMOBILE_MULTI. Also instead of always
> enabling DIV6 and MSTP adjust the Makefile to enable DIV6 and
> MSTP depending on if they are included in the SoC or not.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>
>  Changes since V2:
>  - Fixed patch subject typo CONFIG_SHMOBILE_MULTI -> CONFIG_ARCH_SHMOBILE_MULTI

The subject doesn't seem to match the patch at all?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
