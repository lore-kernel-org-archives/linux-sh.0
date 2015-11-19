From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 19 Nov 2015 18:32:05 +0000
Subject: [PATCH 0/2] drivers: sh: clk: Cleanup clock API
Message-Id: <1447957927-32738-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-clk@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Simon, Magnus,

This patch series cleans up the clock API on legacy SH, to make it more
similar with the Common Clock Framework.  This will avoid different
behavior in drivers shared between legacy and CCF-based platforms (e.g.
SCIF).

Thanks for applying!

Geert Uytterhoeven (2):
  drivers: sh: clk: Avoid crashes when passing NULL clocks
  drivers: sh: clk: Remove obsolete and unused clk_round_parent()

 drivers/sh/clk/core.c  | 100 ++++++-------------------------------------------
 include/linux/sh_clk.h |   4 --
 2 files changed, 12 insertions(+), 92 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
