From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Fri, 27 Dec 2013 11:27:39 +0000
Subject: [PATCH 3/3 V2] ARM: shmobile: koelsch: Add I2C support
Message-Id: <1388143659-8739-4-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds I2C[1245] busses support to Koelsch board.
I2C[03] do not have any slave devices connected and
are not used because of the following:
* I2C0 pins are multiplexed with LBSC pins;
* I2C3 pins are multiplexed with EtherMAC and VIN0 pins.

Changes in V2:
* Capitalized ARM in the subject.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/board-koelsch.c | 46 ++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index de7cc64..799825c 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -148,6 +148,38 @@ static const struct gpio_keys_platform_data koelsch_keys_pdata __initconst = {
 	.nbuttons	= ARRAY_SIZE(gpio_buttons),
 };
 
+/* I2C */
+static const struct resource i2c_resources[] __initconst = {
+	/* I2C0 */
+	DEFINE_RES_MEM(0xE6508000, 0x40),
+	DEFINE_RES_IRQ(gic_spi(287)),
+	/* I2C1 */
+	DEFINE_RES_MEM(0xE6518000, 0x40),
+	DEFINE_RES_IRQ(gic_spi(288)),
+	/* I2C2 */
+	DEFINE_RES_MEM(0xE6530000, 0x40),
+	DEFINE_RES_IRQ(gic_spi(286)),
+	/* I2C3 */
+	DEFINE_RES_MEM(0xE6540000, 0x40),
+	DEFINE_RES_IRQ(gic_spi(290)),
+	/* I2C4 */
+	DEFINE_RES_MEM(0xE6520000, 0x40),
+	DEFINE_RES_IRQ(gic_spi(19)),
+	/* I2C5 */
+	DEFINE_RES_MEM(0xE6528000, 0x40),
+	DEFINE_RES_IRQ(gic_spi(20)),
+};
+
+static void __init koelsch_add_i2c(unsigned idx)
+{
+	unsigned res_idx = idx * 2;
+
+	BUG_ON(res_idx >= ARRAY_SIZE(i2c_resources));
+
+	platform_device_register_simple("i2c-rcar_gen2", idx,
+					i2c_resources + res_idx, 2);
+}
+
 static const struct pinctrl_map koelsch_pinctrl_map[] = {
 	/* DU */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7791", "pfc-r8a7791",
@@ -171,6 +203,15 @@ static const struct pinctrl_map koelsch_pinctrl_map[] = {
 	/* SCIF1 (CN20: DEBUG SERIAL1) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.7", "pfc-r8a7791",
 				  "scif1_data_d", "scif1"),
+	/* I2C1 */
+	PIN_MAP_MUX_GROUP_DEFAULT("i2c-rcar_gen2.1", "pfc-r8a7791",
+				  "i2c1_e", "i2c1"),
+	/* I2C2 */
+	PIN_MAP_MUX_GROUP_DEFAULT("i2c-rcar_gen2.2", "pfc-r8a7791",
+				  "i2c2", "i2c2"),
+	/* I2C4 */
+	PIN_MAP_MUX_GROUP_DEFAULT("i2c-rcar_gen2.4", "pfc-r8a7791",
+				  "i2c4_c", "i2c4"),
 };
 
 static void __init koelsch_add_standard_devices(void)
@@ -192,6 +233,11 @@ static void __init koelsch_add_standard_devices(void)
 				      sizeof(koelsch_keys_pdata));
 
 	koelsch_add_du_device();
+
+	koelsch_add_i2c(1);
+	koelsch_add_i2c(2);
+	koelsch_add_i2c(4);
+	koelsch_add_i2c(5);
 }
 
 /*
-- 
1.8.3.1

