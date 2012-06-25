From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Jun 2012 10:41:09 +0000
Subject: [PATCH 1/5] ARM: shmobile: add common extra gpio functions
Message-Id: <87lijbk726.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current gpio frame work doesn't have the method to control
just pull up/down/free, but some SH-ARM boards need such kind of operation.
This patch adds common extra gpio functions for SH-ARM.

But these functions should be replaced by correct
gpio function in the future.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/include/mach/gpio.h |   32 ++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/gpio.h b/arch/arm/mach-shmobile/include/mach/gpio.h
index de795b4..844507d 100644
--- a/arch/arm/mach-shmobile/include/mach/gpio.h
+++ b/arch/arm/mach-shmobile/include/mach/gpio.h
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/sh_pfc.h>
+#include <linux/io.h>
 
 #ifdef CONFIG_GPIOLIB
 
@@ -27,4 +28,35 @@ static inline int irq_to_gpio(unsigned int irq)
 
 #endif /* CONFIG_GPIOLIB */
 
+/*
+ * FIXME !!
+ *
+ * current gpio frame work doesn't have
+ * the method to control only pull up/down/free.
+ * this function should be replaced by correct gpio function
+ */
+static inline void __init gpio_direction_none(u32 addr)
+{
+	__raw_writeb(0x00, addr);
+}
+
+static inline void __init gpio_request_pullup(u32 addr)
+{
+	u8 data = __raw_readb(addr);
+
+	data &= 0x0F;
+	data |= 0xC0;
+	__raw_writeb(data, addr);
+}
+
+static inline void __init gpio_request_pulldown(u32 addr)
+{
+	u8 data = __raw_readb(addr);
+
+	data &= 0x0F;
+	data |= 0xA0;
+
+	__raw_writeb(data, addr);
+}
+
 #endif /* __ASM_ARCH_GPIO_H */
-- 
1.7.5.4

