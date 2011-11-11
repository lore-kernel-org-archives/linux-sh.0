From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Nov 2011 02:46:23 +0000
Subject: [PATCH 13/20] ARM: mach-shmobile: r8a7740: add i2c support
Message-Id: <87ipmr9y0z.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds I2C support to r8a7740 CPU
which has lasting errata on I2C I/O pad reset.
This patch is including work-around.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/setup-r8a7740.c |  106 ++++++++++++++++++++++++++++++++
 1 files changed, 106 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 5548518..e16860f 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -17,8 +17,10 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
@@ -233,10 +235,114 @@ static struct platform_device *r8a7740_early_devices[] __initdata = {
 	&cmt10_device,
 };
 
+/* I2C */
+static struct resource i2c0_resources[] = {
+	[0] = {
+		.name	= "IIC0",
+		.start	= 0xfff20000,
+		.end	= 0xfff20425 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(201),
+		.end	= gic_spi(204),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource i2c1_resources[] = {
+	[0] = {
+		.name	= "IIC1",
+		.start	= 0xe6c20000,
+		.end	= 0xe6c20425 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(70),
+		.end	= gic_spi(73),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device i2c0_device = {
+	.name		= "i2c-sh_mobile",
+	.id		= 0,
+	.resource	= i2c0_resources,
+	.num_resources	= ARRAY_SIZE(i2c0_resources),
+};
+
+static struct platform_device i2c1_device = {
+	.name		= "i2c-sh_mobile",
+	.id		= 1,
+	.resource	= i2c1_resources,
+	.num_resources	= ARRAY_SIZE(i2c1_resources),
+};
+
+static struct platform_device *r8a7740_late_devices[] __initdata = {
+	&i2c0_device,
+	&i2c1_device,
+};
+
+#define ICCR	0x0004
+#define ICSTART	0x0070
+
+#define i2c_read(reg, offset)		ioread8(reg + offset)
+#define i2c_write(reg, offset, data)	iowrite8(data, reg + offset)
+
+/*
+ * r8a7740 chip has lasting errata on I2C I/O pad reset.
+ * this is work-around for it.
+ */
+static void r8a7740_i2c_workaround(struct platform_device *pdev)
+{
+	struct resource *res;
+	void __iomem *reg;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (unlikely(!res)) {
+		pr_err("r8a7740 i2c workaround fail (cannot find resource)\n");
+		return;
+	}
+
+	reg = ioremap(res->start, resource_size(res));
+	if (unlikely(!reg)) {
+		pr_err("r8a7740 i2c workaround fail (cannot map IO)\n");
+		return;
+	}
+
+	i2c_write(reg, ICCR, i2c_read(reg, ICCR) | 0x80);
+	i2c_read(reg, ICCR); /* dummy read */
+
+	i2c_write(reg, ICSTART, i2c_read(reg, ICSTART) | 0x10);
+	i2c_read(reg, ICSTART); /* dummy read */
+
+	mdelay(100);
+
+	i2c_write(reg, ICCR, 0x01);
+	i2c_read(reg, ICCR);
+	i2c_write(reg, ICSTART, 0x00);
+	i2c_read(reg, ICSTART);
+
+	i2c_write(reg, ICCR, 0x10);
+	mdelay(100);
+	i2c_write(reg, ICCR, 0x00);
+	mdelay(100);
+	i2c_write(reg, ICCR, 0x10);
+	mdelay(100);
+
+	iounmap(reg);
+}
+
 void __init r8a7740_add_standard_devices(void)
 {
+	/* I2C work-around */
+	r8a7740_i2c_workaround(&i2c0_device);
+	r8a7740_i2c_workaround(&i2c1_device);
+
 	platform_add_devices(r8a7740_early_devices,
 			    ARRAY_SIZE(r8a7740_early_devices));
+	platform_add_devices(r8a7740_late_devices,
+			     ARRAY_SIZE(r8a7740_late_devices));
 }
 
 void __init r8a7740_add_early_devices(void)
-- 
1.7.5.4

