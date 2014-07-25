From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 25 Jul 2014 14:40:47 +0000
Subject: [PATCH 3/6] clk: shmobile: Add r8a7794 support
Message-Id: <1406299250-23975-4-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/shmobile/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
index e002923..531d4f6 100644
--- a/drivers/clk/shmobile/Makefile
+++ b/drivers/clk/shmobile/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_ARCH_R8A7740)		+= clk-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7779)		+= clk-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o
+obj-$(CONFIG_ARCH_R8A7794)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-div6.o
 obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-mstp.o
 # for emply built-in.o
-- 
1.8.4.5

