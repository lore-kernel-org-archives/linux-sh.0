From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 04 Jun 2013 05:11:58 +0000
Subject: [PATCH 4/6 v4] ARM: shmobile: r8a7778: add support I2C driver
Message-Id: <874nde5uju.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a platform device for the r8a7778 I2C.

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v3 -> v4

 - separated into "driver" support

 arch/arm/mach-shmobile/include/mach/r8a7778.h |    2 ++
 arch/arm/mach-shmobile/setup-r8a7778.c        |   25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index ae65b45..a428bc6 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -24,6 +24,8 @@
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
+extern void r8a7778_add_i2c_device(int id);
+
 extern void r8a7778_init_delay(void);
 extern void r8a7778_init_irq(void);
 extern void r8a7778_init_irq_dt(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 9191acc..eaa6b06 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -173,6 +173,31 @@ void __init r8a7778_sdhi_init(int id,
 		info, sizeof(*info));
 }
 
+/* I2C */
+static struct resource i2c_resources[] __initdata = {
+	/* I2C0 */
+	DEFINE_RES_MEM(0xffc70000, 0x1000),
+	DEFINE_RES_IRQ(gic_iid(0x63)),
+	/* I2C1 */
+	DEFINE_RES_MEM(0xffc71000, 0x1000),
+	DEFINE_RES_IRQ(gic_iid(0x6e)),
+	/* I2C2 */
+	DEFINE_RES_MEM(0xffc72000, 0x1000),
+	DEFINE_RES_IRQ(gic_iid(0x6c)),
+	/* I2C3 */
+	DEFINE_RES_MEM(0xffc73000, 0x1000),
+	DEFINE_RES_IRQ(gic_iid(0x6d)),
+};
+
+void __init r8a7778_add_i2c_device(int id)
+{
+	BUG_ON(id < 0 || id > 3);
+
+	platform_device_register_simple(
+		"i2c-rcar", id,
+		i2c_resources + (2 * id), 2);
+}
+
 void __init r8a7778_add_standard_devices(void)
 {
 	int i;
-- 
1.7.9.5

