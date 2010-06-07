From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 07 Jun 2010 11:16:36 +0000
Subject: [PATCH] initialise DMA engine before MMC
Message-Id: <Pine.LNX.4.64.1006071312060.12965@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-mmc@vger.kernel.org

To use DMA engine based DMA with MMC in a non-modular build, the DMA 
engine has to initialise before MMC.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/drivers/Makefile b/drivers/Makefile
index 91874e0..b713e75 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_EISA)		+= eisa/
 obj-y				+= lguest/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle/
+obj-$(CONFIG_DMA_ENGINE)	+= dma/
 obj-$(CONFIG_MMC)		+= mmc/
 obj-$(CONFIG_MEMSTICK)		+= memstick/
 obj-$(CONFIG_NEW_LEDS)		+= leds/
@@ -102,7 +103,6 @@ obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
 obj-$(CONFIG_ARCH_SHMOBILE)	+= sh/
 obj-$(CONFIG_GENERIC_TIME)	+= clocksource/
-obj-$(CONFIG_DMA_ENGINE)	+= dma/
 obj-$(CONFIG_DCA)		+= dca/
 obj-$(CONFIG_HID)		+= hid/
 obj-$(CONFIG_PPC_PS3)		+= ps3/
