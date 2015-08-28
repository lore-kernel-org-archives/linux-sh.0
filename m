From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 28 Aug 2015 09:15:50 +0000
Subject: [PATCH v3 00/04] Renesas R-Car Gen3 CPG support V3
Message-Id: <20150828091550.21731.85227.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: kuninori.morimoto.gx@renesas.com, gaku.inami.xw@bp.renesas.com, mturquette@baylibre.com, linux-sh@vger.kernel.org, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

Renesas R-Car Gen3 CPG support V3

[PATCH v3 01/04] clk: shmobile: Get rid of CONFIG_ARCH_SHMOBILE_MULTI
[PATCH v3 02/04] clk: shmobile: Make MSTP clock-output-names optional
[PATCH v3 03/04] clk: shmobile: Add Renesas R-Car Gen3 CPG support
[PATCH v3 04/04] clk: shmobile: rcar-gen3: Add CPG/MSTP Clock Domain support

This series is the first attempt to take the CCF code from the single patch:
"[PATCH 1/9] clk: shmobile: add Renesas R-Car Gen3 CPG support"
to a full series of various CCF related updates related to R-Car Gen3.

In this series patch 1 and 2 get rid of CONFIG_ARCH_SHMOBILE_MULTI kconfig
bits and converts the MSTP CCF driver to not rely on clock-output-names. The
latter may need a bit more work.

Patch 3 and 4 introduce an updated R-Car Gen3 CPG driver where I have reworked
the code to not depend on clock-output-names instead of using strings simply
rely on RCAR_GEN3_CLK_xxx. Those must match the ABI defined in SoC specific
indicies such as the ones included in r8a7795-clock.h.

Patch 3 most likely needs to be reworked further to incorporate earlier
feedback from CCF maintainers.

Comments are very welcome!

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written to be picked up independently from other R-Car Gen3 patches.

 Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt |   31 +
 drivers/clk/Makefile                                                     |    2 
 drivers/clk/shmobile/Makefile                                            |   23 
 drivers/clk/shmobile/clk-mstp.c                                          |   15 
 drivers/clk/shmobile/clk-rcar-gen3.c                                     |  254 ++++++++++
 5 files changed, 304 insertions(+), 21 deletions(-)
