From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 02 Sep 2015 07:16:57 +0000
Subject: [PATCH v6 00/05] Renesas R-Car Gen3 CPG support V6
Message-Id: <20150902071657.10870.37652.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: kuninori.morimoto.gx@renesas.com, gaku.inami.xw@bp.renesas.com, mturquette@baylibre.com, linux-sh@vger.kernel.org, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

Renesas R-Car Gen3 CPG support V6

[PATCH v6 01/05] clk: shmobile: Rework CONFIG_ARCH_SHMOBILE_MULTI
[PATCH v6 02/05] clk: shmobile: Add r8a7795 SoC to MSTP bindings
[PATCH v6 03/05] clk: shmobile: Make MSTP clock-output-names optional
[PATCH v6 04/05] clk: shmobile: Add Renesas R-Car Gen3 CPG support
[PATCH v6 05/05] clk: shmobile: rcar-gen3: Add CPG/MSTP Clock Domain support

This series is my latest attempt to provide R-Car Gen3 clock support
through a single "easy to use" patch series for drivers/clk and DT
documentation bits. New in this version is that the patches have been
reordered to put the most stable (and acked) patches first. 

This version includes several minor updates for all the patches.
For details please see each individual patch.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Developed against renesas-drivers-2015-09-01-v4.2 with v5 series reverted.

 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt      |    1 
 Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt |   58 ++
 drivers/clk/Makefile                                                     |    1 
 drivers/clk/shmobile/Makefile                                            |   23 
 drivers/clk/shmobile/clk-mstp.c                                          |   24 
 drivers/clk/shmobile/clk-rcar-gen3.c                                     |  243 ++++++++++
 6 files changed, 327 insertions(+), 23 deletions(-)
