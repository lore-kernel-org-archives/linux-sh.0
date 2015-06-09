From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 09 Jun 2015 07:14:40 +0000
Subject: [PATCH 2/2] ARM: shmobile: r8a7740: remove I2C errata handling
Message-Id: <1433834080-5630-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1433834080-5630-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1433834080-5630-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This is now done in the I2C driver.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 55 ----------------------------------
 1 file changed, 55 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 9832e48396a40a..00291cc1772df9 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -13,7 +13,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
-#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -690,56 +689,6 @@ void __init r8a7740_meram_workaround(void)
 	}
 }
 
-#define ICCR	0x0004
-#define ICSTART	0x0070
-
-#define i2c_read(reg, offset)		ioread8(reg + offset)
-#define i2c_write(reg, offset, data)	iowrite8(data, reg + offset)
-
-/*
- * r8a7740 chip has lasting errata on I2C I/O pad reset.
- * this is work-around for it.
- */
-static void r8a7740_i2c_workaround(struct platform_device *pdev)
-{
-	struct resource *res;
-	void __iomem *reg;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (unlikely(!res)) {
-		pr_err("r8a7740 i2c workaround fail (cannot find resource)\n");
-		return;
-	}
-
-	reg = ioremap(res->start, resource_size(res));
-	if (unlikely(!reg)) {
-		pr_err("r8a7740 i2c workaround fail (cannot map IO)\n");
-		return;
-	}
-
-	i2c_write(reg, ICCR, i2c_read(reg, ICCR) | 0x80);
-	i2c_read(reg, ICCR); /* dummy read */
-
-	i2c_write(reg, ICSTART, i2c_read(reg, ICSTART) | 0x10);
-	i2c_read(reg, ICSTART); /* dummy read */
-
-	udelay(10);
-
-	i2c_write(reg, ICCR, 0x01);
-	i2c_write(reg, ICSTART, 0x00);
-
-	udelay(10);
-
-	i2c_write(reg, ICCR, 0x10);
-	udelay(10);
-	i2c_write(reg, ICCR, 0x00);
-	udelay(10);
-	i2c_write(reg, ICCR, 0x10);
-	udelay(10);
-
-	iounmap(reg);
-}
-
 void __init r8a7740_add_standard_devices(void)
 {
 	static struct pm_domain_device domain_devices[] __initdata = {
@@ -766,10 +715,6 @@ void __init r8a7740_add_standard_devices(void)
 		{ "A3SP", &usb_dma_device },
 	};
 
-	/* I2C work-around */
-	r8a7740_i2c_workaround(&i2c0_device);
-	r8a7740_i2c_workaround(&i2c1_device);
-
 	r8a7740_init_pm_domains();
 
 	/* add devices */
-- 
2.1.4

