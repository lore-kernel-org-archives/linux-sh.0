From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 26 Aug 2015 06:33:25 +0000
Subject: [PATCH] clk: shmobile: Get rid of CONFIG_SHMOBILE_MULTI
Message-Id: <20150826063325.5381.76761.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: kuninori.morimoto.gx@renesas.com, linux-sh@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Shmobile is all multiplatform these days, so get rid of the
reference to CONFIG_ARCH_SHMOBILE_MULTI. Also instead of always
enabling DIV6 and MSTP adjust the Makefile to enable DIV6 and
MSTP depending on if they are included in the SoC or not.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/clk/Makefile          |    2 +-
 drivers/clk/shmobile/Makefile |   22 ++++++++++------------
 2 files changed, 11 insertions(+), 13 deletions(-)

--- 0001/drivers/clk/Makefile
+++ work/drivers/clk/Makefile	2015-08-26 15:18:22.852366518 +0900
@@ -66,7 +66,7 @@ obj-$(CONFIG_COMMON_CLK_PXA)		+= pxa/
 obj-$(CONFIG_COMMON_CLK_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
-obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= shmobile/
+obj-$(CONFIG_ARCH_SHMOBILE)		+= shmobile/
 obj-$(CONFIG_ARCH_SIRF)			+= sirf/
 obj-$(CONFIG_ARCH_SOCFPGA)		+= socfpga/
 obj-$(CONFIG_PLAT_SPEAR)		+= spear/
--- 0001/drivers/clk/shmobile/Makefile
+++ work/drivers/clk/shmobile/Makefile	2015-08-26 15:16:57.742366518 +0900
@@ -1,13 +1,11 @@
 obj-$(CONFIG_ARCH_EMEV2)		+= clk-emev2.o
-obj-$(CONFIG_ARCH_R7S72100)		+= clk-rz.o
-obj-$(CONFIG_ARCH_R8A73A4)		+= clk-r8a73a4.o
-obj-$(CONFIG_ARCH_R8A7740)		+= clk-r8a7740.o
-obj-$(CONFIG_ARCH_R8A7778)		+= clk-r8a7778.o
-obj-$(CONFIG_ARCH_R8A7779)		+= clk-r8a7779.o
-obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-gen2.o
-obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o
-obj-$(CONFIG_ARCH_R8A7793)		+= clk-rcar-gen2.o
-obj-$(CONFIG_ARCH_R8A7794)		+= clk-rcar-gen2.o
-obj-$(CONFIG_ARCH_SH73A0)		+= clk-sh73a0.o
-obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-div6.o
-obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-mstp.o
+obj-$(CONFIG_ARCH_R7S72100)		+= clk-rz.o clk-mstp.o
+obj-$(CONFIG_ARCH_R8A73A4)		+= clk-r8a73a4.o clk-mstp.o clk-div6.o
+obj-$(CONFIG_ARCH_R8A7740)		+= clk-r8a7740.o clk-mstp.o clk-div6.o
+obj-$(CONFIG_ARCH_R8A7778)		+= clk-r8a7778.o clk-mstp.o clk-div6.o
+obj-$(CONFIG_ARCH_R8A7779)		+= clk-r8a7779.o clk-mstp.o clk-div6.o
+obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
+obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
+obj-$(CONFIG_ARCH_R8A7793)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
+obj-$(CONFIG_ARCH_R8A7794)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
+obj-$(CONFIG_ARCH_SH73A0)		+= clk-sh73a0.o clk-mstp.o clk-div6.o
