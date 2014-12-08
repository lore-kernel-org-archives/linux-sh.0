From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Mon, 08 Dec 2014 10:42:43 +0000
Subject: [PATCH] clk: shmobile: Add r8a7793 support
Message-Id: <1418035363-3678-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

R-Car M2N (r8a7793) clock is handled in R-Car Gen2 clock driver.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on renesas/devel.

 drivers/clk/shmobile/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
index 960bf22..3cc716d 100644
--- a/drivers/clk/shmobile/Makefile
+++ b/drivers/clk/shmobile/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_ARCH_R8A7740)		+= clk-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7779)		+= clk-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o
+obj-$(CONFIG_ARCH_R8A7793)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7794)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-div6.o
 obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-mstp.o
-- 
1.9.1

