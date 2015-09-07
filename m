From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 07 Sep 2015 16:32:52 +0000
Subject: [PATCH v7 00/05] Renesas R-Car Gen3 CPG support V7
Message-Id: <20150907163252.475.18281.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: kuninori.morimoto.gx@renesas.com, gaku.inami.xw@bp.renesas.com, mturquette@baylibre.com, linux-sh@vger.kernel.org, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

Renesas R-Car Gen3 CPG support V7

[PATCH v7 01/05] clk: shmobile: Rework CONFIG_ARCH_SHMOBILE_MULTI
[PATCH v7 02/05] clk: shmobile: Add r8a7795 SoC to MSTP bindings
[PATCH v7 03/05] clk: shmobile: Make MSTP clock-output-names optional
[PATCH v7 04/05] clk: shmobile: Add Renesas R-Car Gen3 CPG support
[PATCH v7 05/05] clk: shmobile: rcar-gen3: Add CPG/MSTP Clock Domain support

Here's the latest R-Car Gen3 clock support patch collection through
a single "easy to use" patch series for drivers/clk and DT documentation
bits. This version of the series only updates patch 4 with PLL1 divider
removal changes as well as some clock registration rework.

For details please see each individual patch.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Developed against e2a147e in renesas-drivers with reverted V6 series

 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt      |    1 
 Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt |   58 ++
 drivers/clk/Makefile                                                     |    1 
 drivers/clk/shmobile/Makefile                                            |   23 
 drivers/clk/shmobile/clk-mstp.c                                          |   24 
 drivers/clk/shmobile/clk-rcar-gen3.c                                     |  244 ++++++++++
 6 files changed, 328 insertions(+), 23 deletions(-)
