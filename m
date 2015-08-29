From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 29 Aug 2015 09:13:23 +0000
Subject: [PATCH v4 00/05] Renesas R-Car Gen3 CPG support V4
Message-Id: <20150829091323.28546.28287.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: kuninori.morimoto.gx@renesas.com, gaku.inami.xw@bp.renesas.com, mturquette@baylibre.com, linux-sh@vger.kernel.org, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

Renesas R-Car Gen3 CPG support V4

[PATCH v4 01/05] clk: shmobile: Rework CONFIG_ARCH_SHMOBILE_MULTI
[PATCH v4 02/05] clk: shmobile: Add Renesas R-Car Gen3 CPG support
[PATCH v4 03/05] clk: shmobile: rcar-gen3: Add CPG/MSTP Clock Domain support
[PATCH v4 04/05] clk: shmobile: Add r8a7795 SoC to MSTP bindings
[PATCH v4 05/05] clk: shmobile: Make MSTP clock-output-names optional

This series is my second attempt to provide R-Car Gen3 clock support
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
 Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt |   57 ++
 drivers/clk/Makefile                                                     |    1 
 drivers/clk/shmobile/Makefile                                            |   23 
 drivers/clk/shmobile/clk-mstp.c                                          |   28 -
 drivers/clk/shmobile/clk-rcar-gen3.c                                     |  251 ++++++++++
 6 files changed, 338 insertions(+), 23 deletions(-)
damm@little-apple ~/patches/20150829/gen3-clk-v4 $ 
