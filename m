From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 25 Aug 2015 06:40:42 +0000
Subject: [PATCH 0/2] clk: shmobile: add Renesas R-Car Gen3 CPG support
Message-Id: <87lhcz7u2i.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-clk@vger.kernel.org


Hi Stephen, Michael
Cc: Simon, Magnus, Geert

These are Renesas R-Car Gen3 clock support patches.
We need incremental update for it, but it is good enough for initial booting.
Renesas R-Car Gen3 initial SoC/board support patch-set depends on these patches.

Renesas SoC series maintainer is Simon and Magnus.
Simon can accept (?) these patches as part of Renesas SoC if Stephen / Michael
can give it Ack. Or Simon can merge Stephen or Michael's branch.
I'm not sure which one is good choice

Gaku Inami (1):
      clk: shmobile: add Renesas R-Car Gen3 CPG support

Kuninori Morimoto (1):
      clk: shmobile: Add r8a7795 SoC to MSTP bindings

 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt      |   1 +
 Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt |  31 ++++++++++++
 drivers/clk/shmobile/Makefile                                            |   1 +
 drivers/clk/shmobile/clk-rcar-gen3.c                                     | 232 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 265 insertions(+)


