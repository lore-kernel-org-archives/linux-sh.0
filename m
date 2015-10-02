From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 02 Oct 2015 07:43:06 +0000
Subject: Re: [PATCH v8 00/05] Renesas R-Car Gen3 CPG support V8
Message-Id: <CAMuHMdWxViP-f5hWEVoBY5ZSWtjSfoZ5zmqF0phq+VbFQ3PL7Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20151001143717.20618.26365.sendpatchset@little-apple>
In-Reply-To: <20151001143717.20618.26365.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Michael Turquette <mturquette@baylibre.com>, Linux-sh list <linux-sh@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Magnus,

On Thu, Oct 1, 2015 at 4:37 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Renesas R-Car Gen3 CPG support V8
>
> [PATCH v8 01/05] clk: shmobile: Rework CONFIG_ARCH_SHMOBILE_MULTI
> [PATCH v8 02/05] clk: shmobile: Add Renesas R-Car Gen3 CPG support
> [PATCH v8 03/05] clk: shmobile: Add Renesas Module Standby and Reset driver
> [PATCH v8 04/05] clk: shmobile: Add r8a7795 MSSR support
> [PATCH v8 05/05] drivers: sh: Handle PM_GENERIC_DOMAINS_OF=n with r8a7795 MSSR

I have pushed this series (incl. "[PATCH] clk: shmobile: Fix r8a7795 MSSR
support") to a new topic/gen3-cpg-v8+fix branch, which is based on v4.3-rc3.

I would have preferred to base it on v4.3-rc1, but the drivers/sh patch depends
on an important change that went into v4.3-rc3. Still, it didn't apply cleanly
as we have more cleanups queued.

Hence for next submission I suggest to split it in two (clk/shmobile and
drivers/sh) parts, so the clk/shmobile part can be applied to v4.3-rc1 by
the clk maintainer.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
