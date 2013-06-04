From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 04 Jun 2013 05:12:08 +0000
Subject: [PATCH 5/6 v4] ARM: shmobile: r8a7778: add support HSPI driver
Message-Id: <8738sy5ujf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a platform device for the r8a7778 HSPI.

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v3 -> v4

 - separated into "driver" support

 arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7778.c        |   23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index a428bc6..ca8bc14 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -25,6 +25,7 @@ extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
 extern void r8a7778_add_i2c_device(int id);
+extern void r8a7778_add_hspi_device(int id);
 
 extern void r8a7778_init_delay(void);
 extern void r8a7778_init_irq(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index eaa6b06..fdc483d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -198,6 +198,29 @@ void __init r8a7778_add_i2c_device(int id)
 		i2c_resources + (2 * id), 2);
 }
 
+/* HSPI */
+static struct resource hspi_resources[] __initdata = {
+	/* HSPI0 */
+	DEFINE_RES_MEM(0xfffc7000, 0x18),
+	DEFINE_RES_IRQ(gic_iid(0x5f)),
+	/* HSPI1 */
+	DEFINE_RES_MEM(0xfffc8000, 0x18),
+	DEFINE_RES_IRQ(gic_iid(0x74)),
+	/* HSPI2 */
+	DEFINE_RES_MEM(0xfffc6000, 0x18),
+	DEFINE_RES_IRQ(gic_iid(0x75)),
+};
+
+void __init r8a7778_add_hspi_device(int id)
+{
+	BUG_ON(id < 0 || id > 2);
+
+	platform_device_register_simple(
+		"sh-hspi", id,
+		hspi_resources + (2 * id), 2);
+}
+
+
 void __init r8a7778_add_standard_devices(void)
 {
 	int i;
-- 
1.7.9.5

