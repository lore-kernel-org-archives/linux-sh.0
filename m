From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 07 Sep 2010 02:05:30 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: modify touchpanel judgment
Message-Id: <w3p39tm8g0p.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p1v9weglx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p1v9weglx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current touchpanel had below 2 issues

- LCDD2 pin which is needed for WVGA was changed to
  IRQ28_123 pin on ts_get_pendown_state

- GPIO pull up on ts_init was disabled by gpio_request
  on ts_get_pendown_state.
  This mean the return value from gpio_get_value is untrusted.

This patch solve these issues

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
This is bug fix patch.

And is NOT V2 of
[PATCH] ARM: mach-shmobile: ap4evb: modify tsc2007 platform settings

 arch/arm/mach-shmobile/board-ap4evb.c |   45 +++++++++++---------------------
 1 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 95935c8..b954848 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -756,7 +756,6 @@ device_initcall(hdmi_init_pm_clock);
  * FIXME !!
  *
  * gpio_no_direction
- * gpio_pull_up
  * are quick_hack.
  *
  * current gpio frame work doesn't have
@@ -768,49 +767,37 @@ static void __init gpio_no_direction(u32 addr)
 	__raw_writeb(0x00, addr);
 }
 
-static void __init gpio_pull_up(u32 addr)
-{
-	u8 data = __raw_readb(addr);
-
-	data &= 0x0F;
-	data |= 0xC0;
-	__raw_writeb(data, addr);
-}
-
 /* TouchScreen */
+#ifdef CONFIG_AP4EVB_QHD
+# define GPIO_TSC_IRQ	GPIO_FN_IRQ28_123
+# define GPIO_TSC_PORT	GPIO_PORT123
+#else /* WVGA */
+# define GPIO_TSC_IRQ	GPIO_FN_IRQ7_40
+# define GPIO_TSC_PORT	GPIO_PORT40
+#endif
+
 #define IRQ28	evt2irq(0x3380) /* IRQ28A */
 #define IRQ7	evt2irq(0x02e0) /* IRQ7A */
 static int ts_get_pendown_state(void)
 {
-	int val1, val2;
+	int val;
 
-	gpio_free(GPIO_FN_IRQ28_123);
-	gpio_free(GPIO_FN_IRQ7_40);
+	gpio_free(GPIO_TSC_IRQ);
 
-	gpio_request(GPIO_PORT123, NULL);
-	gpio_request(GPIO_PORT40, NULL);
+	gpio_request(GPIO_TSC_PORT, NULL);
 
-	gpio_direction_input(GPIO_PORT123);
-	gpio_direction_input(GPIO_PORT40);
+	gpio_direction_input(GPIO_TSC_PORT);
 
-	val1 = gpio_get_value(GPIO_PORT123);
-	val2 = gpio_get_value(GPIO_PORT40);
+	val = gpio_get_value(GPIO_TSC_PORT);
 
-	gpio_request(GPIO_FN_IRQ28_123, NULL);	/* for QHD */
-	gpio_request(GPIO_FN_IRQ7_40, NULL);	/* for WVGA */
+	gpio_request(GPIO_TSC_IRQ, NULL);
 
-	return val1 ^ val2;
+	return !val;
 }
 
-#define PORT40CR	0xE6051028
-#define PORT123CR	0xE605007B
 static int ts_init(void)
 {
-	gpio_request(GPIO_FN_IRQ28_123, NULL);	/* for QHD */
-	gpio_request(GPIO_FN_IRQ7_40, NULL);	/* for WVGA */
-
-	gpio_pull_up(PORT40CR);
-	gpio_pull_up(PORT123CR);
+	gpio_request(GPIO_TSC_IRQ, NULL);
 
 	return 0;
 }
-- 
1.7.0.4

