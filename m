From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 12 Nov 2015 15:54:42 +0000
Subject: [PATCH v6 1/5] clk: shmobile: Rework CONFIG_ARCH_SHMOBILE_MULTI
Message-Id: <1447343686-2038-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1447343686-2038-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1447343686-2038-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-clk@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

From: Magnus Damm <damm+renesas@opensource.se>

Shmobile is all multiplatform these days, so get rid of the reference to
CONFIG_ARCH_SHMOBILE_MULTI in drivers/clk/shmobile/.

Also instead of always enabling DIV6 and MSTP adjust the Makefile
to enable DIV6 and MSTP depending on if they are included in the
SoC or not.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v6:
  - No changes,

v5:
  - Integrated in this series as a contextual dependency.
---
 drivers/clk/shmobile/Makefile | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
index 97c71c885e4f38c5..1eb947db6f5926a0 100644
--- a/drivers/clk/shmobile/Makefile
+++ b/drivers/clk/shmobile/Makefile
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
-- 
1.9.1

