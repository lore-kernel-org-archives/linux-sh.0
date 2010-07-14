From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 14 Jul 2010 07:01:07 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: Add ts_get_pendown_state for
Message-Id: <w3pmxtufsy3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This function is necessary to ensure the detection of pen-down.
This patch support both QHD / WVGA pannel.

Tested-by: Tony SIM <chinyeow.sim.xt@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
This patch is depend on
[PATCH] ARM: mach-shmobile: ap4evb: Add LCD panel selection

# above patch got "Applied, thanks" from Paul
# But I can not find it on latest Paul's git...

 arch/arm/mach-shmobile/board-ap4evb.c |   78 ++++++++++++++++++++++++++-------
 1 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index e8a9d79..9686012 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -576,12 +576,74 @@ static struct platform_device *ap4evb_devices[] __initdata = {
 	&sh_mmcif_device
 };
 
+/*
+ * FIXME !!
+ *
+ * gpio_no_direction
+ * gpio_pull_up
+ * are quick_hack.
+ *
+ * current gpio frame work doesn't have
+ * the method to control only pull up/down/free.
+ * this function should be replaced by correct gpio function
+ */
+static void __init gpio_no_direction(u32 addr)
+{
+	__raw_writeb(0x00, addr);
+}
+
+static void __init gpio_pull_up(u32 addr)
+{
+	u8 data = __raw_readb(addr);
+
+	data &= 0x0F;
+	data |= 0xC0;
+	__raw_writeb(data, addr);
+}
+
 /* TouchScreen */
 #define IRQ28	evt2irq(0x3380) /* IRQ28A */
 #define IRQ7	evt2irq(0x02e0) /* IRQ7A */
+static int ts_get_pendown_state(void)
+{
+	int val1, val2;
+
+	gpio_free(GPIO_FN_IRQ28_123);
+	gpio_free(GPIO_FN_IRQ7_40);
+
+	gpio_request(GPIO_PORT123, NULL);
+	gpio_request(GPIO_PORT40, NULL);
+
+	gpio_direction_input(GPIO_PORT123);
+	gpio_direction_input(GPIO_PORT40);
+
+	val1 = gpio_get_value(GPIO_PORT123);
+	val2 = gpio_get_value(GPIO_PORT40);
+
+	gpio_request(GPIO_FN_IRQ28_123, NULL);	/* for QHD */
+	gpio_request(GPIO_FN_IRQ7_40, NULL);	/* for WVGA */
+
+	return val1 ^ val2;
+}
+
+#define PORT40CR	0xE6051028
+#define PORT123CR	0xE605007B
+static int ts_init(void)
+{
+	gpio_request(GPIO_FN_IRQ28_123, NULL);	/* for QHD */
+	gpio_request(GPIO_FN_IRQ7_40, NULL);	/* for WVGA */
+
+	gpio_pull_up(PORT40CR);
+	gpio_pull_up(PORT123CR);
+
+	return 0;
+}
+
 static struct tsc2007_platform_data tsc2007_info = {
 	.model			= 2007,
 	.x_plate_ohms		= 180,
+	.get_pendown_state	= ts_get_pendown_state,
+	.init_platform_hw	= ts_init,
 };
 
 static struct i2c_board_info tsc_device = {
@@ -625,20 +687,6 @@ static void __init ap4evb_map_io(void)
 	shmobile_setup_console();
 }
 
-/*
- * FIXME !!
- *
- * gpio_no_direction is quick_hack.
- *
- * current gpio frame work doesn't have
- * the method to control only pull up/down/free.
- * this function should be replaced by correct gpio function
- */
-static void __init gpio_no_direction(u32 addr)
-{
-	__raw_writeb(0x00, addr);
-}
-
 #define GPIO_PORT9CR	0xE6051009
 #define GPIO_PORT10CR	0xE605100A
 
@@ -784,7 +832,6 @@ static void __init ap4evb_init(void)
 	gpio_request(GPIO_FN_KEYIN4,     NULL);
 
 	/* enable TouchScreen */
-	gpio_request(GPIO_FN_IRQ28_123, NULL);
 	set_irq_type(IRQ28, IRQ_TYPE_LEVEL_LOW);
 
 	tsc_device.irq = IRQ28;
@@ -860,7 +907,6 @@ static void __init ap4evb_init(void)
 	lcdc_info.ch[0].lcd_size_cfg.height	= 91;
 
 	/* enable TouchScreen */
-	gpio_request(GPIO_FN_IRQ7_40, NULL);
 	set_irq_type(IRQ7, IRQ_TYPE_LEVEL_LOW);
 
 	tsc_device.irq = IRQ7;
-- 
1.7.0.4

