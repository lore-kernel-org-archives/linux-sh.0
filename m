From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Fri, 30 Aug 2013 12:37:39 +0000
Subject: [RFC 05/10] ARM: shmobile: r8a7790: add I2C setup
Message-Id: <1377866264-21110-6-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Nguyen Viet Dung <nv-dung@jinso.co.jp>

This patch add setup for I2C bus.

Signed-off-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
---
 arch/arm/mach-shmobile/include/mach/r8a7790.h |  3 +++
 arch/arm/mach-shmobile/setup-r8a7790.c        | 28 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h b/arch/arm/mach-shmobile/include/mach/r8a7790.h
index 177a837..ad8b502 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7790.h
@@ -1,7 +1,10 @@
 #ifndef __ASM_R8A7790_H__
 #define __ASM_R8A7790_H__
 
+#include <linux/i2c/i2c-rcar.h>
+
 void r8a7790_add_standard_devices(void);
+void r8a7790_add_i2c_device(int idx, struct i2c_rcar_platform_data *pdata);
 void r8a7790_add_dt_devices(void);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index e0d29a2..969fdf2 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/clocksource.h>
+#include <linux/i2c/i2c-rcar.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
@@ -196,6 +197,33 @@ void __init r8a7790_add_dt_devices(void)
 	r8a7790_register_cmt(00);
 }
 
+/* I2C */
+static struct resource rcar_i2c_res[] __initdata = {
+	/* I2C0 */
+	DEFINE_RES_MEM(0xe6508000, 0x10000),
+	DEFINE_RES_IRQ(gic_spi(287)),
+	/* I2C1 */
+	DEFINE_RES_MEM(0xe6518000, 0x10000),
+	DEFINE_RES_IRQ(gic_spi(288)),
+	/* I2C2 */
+	DEFINE_RES_MEM(0xe6530000, 0x10000),
+	DEFINE_RES_IRQ(gic_spi(286)),
+	/* I2C3 */
+	DEFINE_RES_MEM(0xe6540000, 0x10000),
+	DEFINE_RES_IRQ(gic_spi(290)),
+};
+
+void __init r8a7790_add_i2c_device(int idx,
+				   struct i2c_rcar_platform_data *pdata)
+{
+	BUG_ON(idx < 0 || idx > 3);
+
+	platform_device_register_resndata(
+			&platform_bus, "i2c-rcar", idx,
+			rcar_i2c_res + (2*idx), 2,
+			pdata, sizeof(*pdata));
+}
+
 void __init r8a7790_add_standard_devices(void)
 {
 	r8a7790_add_dt_devices();
-- 
1.8.1.4

