From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 31 Aug 2015 12:48:42 +0000
Subject: [PATCH v5 00/05] Renesas R-Car Gen3 CPG support V5
Message-Id: <20150831124842.31057.54534.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: kuninori.morimoto.gx@renesas.com, gaku.inami.xw@bp.renesas.com, mturquette@baylibre.com, linux-sh@vger.kernel.org, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

Renesas R-Car Gen3 CPG support V5

[PATCH v5 01/05] clk: shmobile: Rework CONFIG_ARCH_SHMOBILE_MULTI
[PATCH v5 02/05] clk: shmobile: Add Renesas R-Car Gen3 CPG support
[PATCH v5 03/05] clk: shmobile: rcar-gen3: Add CPG/MSTP Clock Domain support
[PATCH v5 04/05] clk: shmobile: Add r8a7795 SoC to MSTP bindings
[PATCH v5 05/05] clk: shmobile: Make MSTP clock-output-names optional

This series is my latest attempt to provide R-Car Gen3 clock support
through a single "easy to use" patch series for drivers/clk and DT
documentation bits.

There are no special runtime or build time dependencies. SoC / board
specific integration code (DTS) is provided separately from this series.

This version includes several minor updates for all the patches.
For details please see each individual patch.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written to be picked up independently from other R-Car Gen3 patches.

 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt      |    1 
 Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt |   58 ++
 drivers/clk/Makefile                                                     |    1 
 drivers/clk/shmobile/Makefile                                            |   23 
 drivers/clk/shmobile/clk-mstp.c                                          |   28 -
 drivers/clk/shmobile/clk-rcar-gen3.c                                     |  247 ++++++++++
 6 files changed, 335 insertions(+), 23 deletions(-)
