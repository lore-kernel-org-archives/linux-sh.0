From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 08 Sep 2015 07:41:07 +0000
Subject: Re: [PATCH v7 05/05] clk: shmobile: rcar-gen3: Add CPG/MSTP Clock Domain support
Message-Id: <CAMuHMdVQkWcftaYR+vd-LGQTTsj8waFms4aOMvZY_DF51kn0Vg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150907163252.475.18281.sendpatchset@little-apple>
	<20150907163346.475.69916.sendpatchset@little-apple>
In-Reply-To: <20150907163346.475.69916.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Magnus,

On Mon, Sep 7, 2015 at 6:33 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> --- 0009/drivers/clk/shmobile/clk-rcar-gen3.c
> +++ work/drivers/clk/shmobile/clk-rcar-gen3.c   2015-09-02 14:39:35.912366518 +0900
> @@ -236,6 +236,8 @@ static void __init rcar_gen3_cpg_clocks_
>         }

The above line causes fuzz when applying it.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
