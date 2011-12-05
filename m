From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 05 Dec 2011 06:25:03 +0000
Subject: [PATCH 0/4] sh: div6 clock update for paul/common/clkfwk
Message-Id: <877h2b8rie.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul, Magnus

These are div6 clock update patch set for paul/common/clkfwk

Kuninori Morimoto (4):
      sh: clock-sh7723: add CLKDEV_ICK_ID for cleanup
      sh: modify SH_CLK_DIV6_EXT macro parameter
      sh: clock-sh7724: all div6_clks use SH_CLK_DIV6_EXT()
      sh: clock-sh73a0: all div6_clks use SH_CLK_DIV6_EXT()

#1 patch is not div6, but clean up patch.
#3, #4 try to use sh_clk_div6_reparent_register() for all div6 clock

Best regards
---
Kuninori Morimoto
