From: kuninori.morimoto.gx@renesas.com
Date: Tue, 06 Dec 2011 06:25:17 +0000
Subject: Re: [PATCH v2 0/4] sh: div6 clock update for paul/common/clkfwk
Message-Id: <87hb1emd2u.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul, Magnus

These are v2 div6 clock update patch set for paul/common/clkfwk

Kuninori Morimoto (3):
       sh: clock-sh7723: add CLKDEV_ICK_ID for cleanup
       sh: clock-sh7724: all div6_clks use SH_CLK_DIV6_EXT()
       sh: clock-sh73a0: all div6_clks use SH_CLK_DIV6_EXT()
 
v1 -> v2

drop "sh: modify SH_CLK_DIV6_EXT macro parameter" patch.
