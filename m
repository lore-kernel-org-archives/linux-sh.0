From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 13 Apr 2012 09:41:06 +0000
Subject: [PATCH] ARM: mach-shmobile: r8a7740: cleanup I2C workaround method
Message-Id: <87wr5k2clt.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Current workaround of I2C on r8a7740 used mdelay(),
but it were overkill.
This patch cleanup workaround delay.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/setup-r8a7740.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 14edb5c..34a1548 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -350,19 +350,19 @@ static void r8a7740_i2c_workaround(struct platform_device *pdev)
 	i2c_write(reg, ICSTART, i2c_read(reg, ICSTART) | 0x10);
 	i2c_read(reg, ICSTART); /* dummy read */
 
-	mdelay(100);
+	udelay(10);
 
 	i2c_write(reg, ICCR, 0x01);
-	i2c_read(reg, ICCR);
 	i2c_write(reg, ICSTART, 0x00);
-	i2c_read(reg, ICSTART);
+
+	udelay(10);
 
 	i2c_write(reg, ICCR, 0x10);
-	mdelay(100);
+	udelay(10);
 	i2c_write(reg, ICCR, 0x00);
-	mdelay(100);
+	udelay(10);
 	i2c_write(reg, ICCR, 0x10);
-	mdelay(100);
+	udelay(10);
 
 	iounmap(reg);
 }
-- 
1.7.5.4

