From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Dec 2014 13:37:04 +0000
Subject: [PATCH] i2c: sh_mobile: I2C_SH_MOBILE should depend on HAS_DMA
Message-Id: <1418650624-28174-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

If NO_DMA=y:

drivers/built-in.o: In function `sh_mobile_i2c_dma_unmap':
i2c-sh_mobile.c:(.text+0x60de42): undefined reference to `dma_unmap_single'
drivers/built-in.o: In function `sh_mobile_i2c_xfer_dma':
i2c-sh_mobile.c:(.text+0x60df22): undefined reference to `dma_map_single'
i2c-sh_mobile.c:(.text+0x60df2e): undefined reference to `dma_mapping_error'

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/i2c/busses/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index c1351d9fb35bbc8d..f08dd20f625c184d 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -753,6 +753,7 @@ config I2C_SH7760
 
 config I2C_SH_MOBILE
 	tristate "SuperH Mobile I2C Controller"
+	depends on HAS_DMA
 	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
 	help
 	  If you say yes to this option, support will be included for the
-- 
1.9.1

