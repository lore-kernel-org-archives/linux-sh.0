From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 31 Aug 2015 12:48:53 +0000
Subject: [PATCH v5 01/05] clk: shmobile: Rework CONFIG_ARCH_SHMOBILE_MULTI
Message-Id: <20150831124853.31057.38519.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150831124842.31057.54534.sendpatchset@little-apple>
In-Reply-To: <20150831124842.31057.54534.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: kuninori.morimoto.gx@renesas.com, linux-sh@vger.kernel.org, mturquette@baylibre.com, gaku.inami.xw@bp.renesas.com, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Shmobile is all multiplatform these days, so in get rid of the
reference to CONFIG_ARCH_SHMOBILE_MULTI in drivers/clk/shmobile/.

Also instead of always enabling DIV6 and MSTP adjust the Makefile
to enable DIV6 and MSTP depending on if they are included in the
SoC or not.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

 Earlier known as "clk: shmobile: Get rid of CONFIG_ARCH_SHMOBILE_MULTI"

 Changes since V4:
 - None

 Changes since V3:
 - Got rid of hunks that modified drivers/clk/Makefile
 - This to prevent build issue with non-CCF enabled SH arch
 - A nice side effect is that this patch now can be merged any time

 Changes since V2:
 - Fixed patch subject typo CONFIG_SHMOBILE_MULTI -> CONFIG_ARCH_SHMOBILE_MULTI

 drivers/clk/shmobile/Makefile |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

--- 0001/drivers/clk/shmobile/Makefile
+++ work/drivers/clk/shmobile/Makefile	2015-08-29 16:14:57.522366518 +0900
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
+obj-$(CONFIG_ARCH_R8A7778)		+= clk-r8a7778.o clk-mstp.o
+obj-$(CONFIG_ARCH_R8A7779)		+= clk-r8a7779.o clk-mstp.o
+obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
+obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
+obj-$(CONFIG_ARCH_R8A7793)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
+obj-$(CONFIG_ARCH_R8A7794)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
+obj-$(CONFIG_ARCH_SH73A0)		+= clk-sh73a0.o clk-mstp.o clk-div6.o
