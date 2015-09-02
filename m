From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 02 Sep 2015 09:28:40 +0000
Subject: Re: [PATCH v6 00/05] Renesas R-Car Gen3 CPG support V6
Message-Id: <CAMuHMdVeZx=Q1QAHTTMsxZoD25S8gFzz-qu1i-+cKrjtT4Mx1A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150902071657.10870.37652.sendpatchset@little-apple>
In-Reply-To: <20150902071657.10870.37652.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Michael Turquette <mturquette@baylibre.com>, Linux-sh list <linux-sh@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Wed, Sep 2, 2015 at 9:16 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Renesas R-Car Gen3 CPG support V6
>
> [PATCH v6 01/05] clk: shmobile: Rework CONFIG_ARCH_SHMOBILE_MULTI
> [PATCH v6 02/05] clk: shmobile: Add r8a7795 SoC to MSTP bindings
> [PATCH v6 03/05] clk: shmobile: Make MSTP clock-output-names optional
> [PATCH v6 04/05] clk: shmobile: Add Renesas R-Car Gen3 CPG support
> [PATCH v6 05/05] clk: shmobile: rcar-gen3: Add CPG/MSTP Clock Domain support
>
> This series is my latest attempt to provide R-Car Gen3 clock support
> through a single "easy to use" patch series for drivers/clk and DT
> documentation bits. New in this version is that the patches have been
> reordered to put the most stable (and acked) patches first.
>
> This version includes several minor updates for all the patches.
> For details please see each individual patch.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Thank you, imported into topic/gen3-cpg-v6

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
