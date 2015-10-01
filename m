From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 01 Oct 2015 14:37:17 +0000
Subject: [PATCH v8 00/05] Renesas R-Car Gen3 CPG support V8
Message-Id: <20151001143717.20618.26365.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: kuninori.morimoto.gx@renesas.com, gaku.inami.xw@bp.renesas.com, mturquette@baylibre.com, linux-sh@vger.kernel.org, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

Renesas R-Car Gen3 CPG support V8

[PATCH v8 01/05] clk: shmobile: Rework CONFIG_ARCH_SHMOBILE_MULTI
[PATCH v8 02/05] clk: shmobile: Add Renesas R-Car Gen3 CPG support
[PATCH v8 03/05] clk: shmobile: Add Renesas Module Standby and Reset driver
[PATCH v8 04/05] clk: shmobile: Add r8a7795 MSSR support
[PATCH v8 05/05] drivers: sh: Handle PM_GENERIC_DOMAINS_OF=n with r8a7795 MSSR

Here's an updated R-Car Gen3 clock support patch collection through
a single "easy to use" patch series for drivers/clk and DT documentation
bits. This version of the series moves over from MSTP to MSSR so the
patches below are replaced with patch 3-5 above:

[PATCH v7 02/05] clk: shmobile: Add r8a7795 SoC to MSTP bindings
[PATCH v7 03/05] clk: shmobile: Make MSTP clock-output-names optional
[PATCH v7 05/05] clk: shmobile: rcar-gen3: Add CPG/MSTP Clock Domain support

With this V8 series the integration DT bits for MSTP need to be converted
into MSSR format, an updated integration series will be posted sometime soon.

Apart from MSSR conversion this series requires "clock-output-names" however
patch 2/5 still needs to be updated. Patch 3/5 and/or patch 4/5 also need
to be extended to include DT binding information. Apart from lacking DT
binding documentation I would say that the DT interface is becoming more
and more stable, so soon it should be possible to fix the integration bits.

For more details please see each individual patch.

Thanks to Geert for doing the heavy lifting with the MSSR driver.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Developed against 61a7cf8 in renesas-drivers:

Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt |   58 +
 drivers/clk/Makefile                                                     |    1 
 drivers/clk/shmobile/Makefile                                            |   25 
 drivers/clk/shmobile/clk-mssr.c                                          |  393 ++++++++++
 drivers/clk/shmobile/clk-rcar-gen3.c                                     |  244 ++++++
 drivers/sh/pm_runtime.c                                                  |    5 
 include/linux/clk/shmobile.h                                             |    2 
 7 files changed, 712 insertions(+), 16 deletions(-)
