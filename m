From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 27 Aug 2010 09:49:39 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: modify tsc2007 platform settings
Message-Id: <w3plj7sidvw.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p1v9weglx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p1v9weglx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch modify x_plate_ohms to correct value for tsc2007,
and removed un-necessary ts_get_pendown_state().
gpio_pull_up() was removed also.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   51 ++-------------------------------
 1 files changed, 3 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 23d472f..46e75a2 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -716,7 +716,6 @@ device_initcall(hdmi_init_pm_clock);
  * FIXME !!
  *
  * gpio_no_direction
- * gpio_pull_up
  * are quick_hack.
  *
  * current gpio frame work doesn't have
@@ -728,58 +727,12 @@ static void __init gpio_no_direction(u32 addr)
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
 #define IRQ28	evt2irq(0x3380) /* IRQ28A */
 #define IRQ7	evt2irq(0x02e0) /* IRQ7A */
-static int ts_get_pendown_state(void)
-{
-	int val1, val2;
-
-	gpio_free(GPIO_FN_IRQ28_123);
-	gpio_free(GPIO_FN_IRQ7_40);
-
-	gpio_request(GPIO_PORT123, NULL);
-	gpio_request(GPIO_PORT40, NULL);
-
-	gpio_direction_input(GPIO_PORT123);
-	gpio_direction_input(GPIO_PORT40);
-
-	val1 = gpio_get_value(GPIO_PORT123);
-	val2 = gpio_get_value(GPIO_PORT40);
-
-	gpio_request(GPIO_FN_IRQ28_123, NULL);	/* for QHD */
-	gpio_request(GPIO_FN_IRQ7_40, NULL);	/* for WVGA */
-
-	return val1 ^ val2;
-}
-
-#define PORT40CR	0xE6051028
-#define PORT123CR	0xE605007B
-static int ts_init(void)
-{
-	gpio_request(GPIO_FN_IRQ28_123, NULL);	/* for QHD */
-	gpio_request(GPIO_FN_IRQ7_40, NULL);	/* for WVGA */
-
-	gpio_pull_up(PORT40CR);
-	gpio_pull_up(PORT123CR);
-
-	return 0;
-}
-
 static struct tsc2007_platform_data tsc2007_info = {
 	.model			= 2007,
-	.x_plate_ohms		= 180,
-	.get_pendown_state	= ts_get_pendown_state,
-	.init_platform_hw	= ts_init,
+	.x_plate_ohms		= 1000,
 };
 
 static struct i2c_board_info tsc_device = {
@@ -968,6 +921,7 @@ static void __init ap4evb_init(void)
 	gpio_request(GPIO_FN_KEYIN4,     NULL);
 
 	/* enable TouchScreen */
+	gpio_request(GPIO_FN_IRQ28_123, NULL);
 	set_irq_type(IRQ28, IRQ_TYPE_LEVEL_LOW);
 
 	tsc_device.irq = IRQ28;
@@ -1043,6 +997,7 @@ static void __init ap4evb_init(void)
 	lcdc_info.ch[0].lcd_size_cfg.height	= 91;
 
 	/* enable TouchScreen */
+	gpio_request(GPIO_FN_IRQ7_40, NULL);
 	set_irq_type(IRQ7, IRQ_TYPE_LEVEL_LOW);
 
 	tsc_device.irq = IRQ7;
-- 
1.7.0.4

