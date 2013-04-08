From: Bastian Hecht <hechtb@gmail.com>
Date: Mon, 08 Apr 2013 15:27:09 +0000
Subject: [PATCH] sh-pfc: Add entries for INTC external IRQs
Message-Id: <1365434829-21791-1-git-send-email-hechtb+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

We add all necessary entries to support the external IRQs from the INTC.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |  171 ++++++++++++++++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 21ff7f2..f4fa4c8 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -30,6 +30,22 @@
 	PORT_10(fn, pfx##20, sfx),					\
 	PORT_1(fn, pfx##210, sfx),	PORT_1(fn, pfx##211, sfx)
 
+#define IRQC_PIN_MUX(pin, mark)						\
+static const unsigned int intc_irq##mark##_pins[] = {			\
+	pin,								\
+};									\
+static const unsigned int intc_irq##mark##_mux[] = {			\
+	IRQ##mark##_MARK,						\
+}
+
+#define IRQC_PINS_MUX(pin, mark)					\
+static const unsigned int intc_irq##mark##_port##pin##_pins[] = {	\
+	pin,								\
+};									\
+static const unsigned int intc_irq##mark##_port##pin##_mux[] = {	\
+	IRQ##mark##_PORT##pin##_MARK,					\
+}
+
 enum {
 	PINMUX_RESERVED = 0,
 
@@ -1658,6 +1674,58 @@ static struct sh_pfc_pin pinmux_pins[] = {
 	GPIO_PORT_ALL(),
 };
 
+/* - INTC ------------------------------------------------------------------- */
+IRQC_PINS_MUX(0, 5);
+IRQC_PINS_MUX(1, 5);
+IRQC_PINS_MUX(2, 0);
+IRQC_PINS_MUX(10, 3);
+IRQC_PINS_MUX(11, 2);
+IRQC_PINS_MUX(13, 0);
+IRQC_PINS_MUX(14, 3);
+IRQC_PINS_MUX(15, 4);
+IRQC_PIN_MUX(19, 10);
+IRQC_PIN_MUX(20, 1);
+IRQC_PIN_MUX(38, 25);
+IRQC_PINS_MUX(41, 31);
+IRQC_PINS_MUX(42, 12);
+IRQC_PINS_MUX(49, 30);
+IRQC_PINS_MUX(50, 29);
+IRQC_PINS_MUX(56, 28);
+IRQC_PINS_MUX(57, 27);
+IRQC_PINS_MUX(58, 26);
+IRQC_PINS_MUX(62, 15);
+IRQC_PINS_MUX(63, 14);
+IRQC_PINS_MUX(64, 13);
+IRQC_PIN_MUX(67, 20);
+IRQC_PINS_MUX(68, 16);
+IRQC_PIN_MUX(69, 17);
+IRQC_PIN_MUX(70, 18);
+IRQC_PIN_MUX(71, 19);
+IRQC_PINS_MUX(81, 26);
+IRQC_PIN_MUX(95, 22);
+IRQC_PIN_MUX(96, 23);
+IRQC_PINS_MUX(97, 12);
+IRQC_PINS_MUX(98, 13);
+IRQC_PINS_MUX(99, 14);
+IRQC_PINS_MUX(100, 15);
+IRQC_PIN_MUX(104, 11);
+IRQC_PINS_MUX(118, 9);
+IRQC_PIN_MUX(119, 8);
+IRQC_PINS_MUX(120, 7);
+IRQC_PINS_MUX(121, 6);
+IRQC_PINS_MUX(167, 31);
+IRQC_PINS_MUX(168, 27);
+IRQC_PINS_MUX(169, 28);
+IRQC_PINS_MUX(170, 29);
+IRQC_PINS_MUX(171, 30);
+IRQC_PINS_MUX(172, 4);
+IRQC_PINS_MUX(173, 6);
+IRQC_PIN_MUX(180, 24);
+IRQC_PIN_MUX(202, 21);
+IRQC_PINS_MUX(209, 7);
+IRQC_PINS_MUX(210, 9);
+IRQC_PINS_MUX(211, 16);
+
 /* - LCD0 ------------------------------------------------------------------- */
 static const unsigned int lcd0_data8_pins[] = {
 	/* D[0:7] */
@@ -2062,6 +2130,56 @@ static const unsigned int sdhi2_wp_1_mux[] = {
 };
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(intc_irq1),
+	SH_PFC_PIN_GROUP(intc_irq8),
+	SH_PFC_PIN_GROUP(intc_irq10),
+	SH_PFC_PIN_GROUP(intc_irq11),
+	SH_PFC_PIN_GROUP(intc_irq17),
+	SH_PFC_PIN_GROUP(intc_irq18),
+	SH_PFC_PIN_GROUP(intc_irq19),
+	SH_PFC_PIN_GROUP(intc_irq20),
+	SH_PFC_PIN_GROUP(intc_irq21),
+	SH_PFC_PIN_GROUP(intc_irq22),
+	SH_PFC_PIN_GROUP(intc_irq23),
+	SH_PFC_PIN_GROUP(intc_irq24),
+	SH_PFC_PIN_GROUP(intc_irq25),
+	SH_PFC_PIN_GROUP(intc_irq5_port0),
+	SH_PFC_PIN_GROUP(intc_irq5_port1),
+	SH_PFC_PIN_GROUP(intc_irq0_port2),
+	SH_PFC_PIN_GROUP(intc_irq3_port10),
+	SH_PFC_PIN_GROUP(intc_irq2_port11),
+	SH_PFC_PIN_GROUP(intc_irq0_port13),
+	SH_PFC_PIN_GROUP(intc_irq3_port14),
+	SH_PFC_PIN_GROUP(intc_irq4_port15),
+	SH_PFC_PIN_GROUP(intc_irq31_port41),
+	SH_PFC_PIN_GROUP(intc_irq12_port42),
+	SH_PFC_PIN_GROUP(intc_irq30_port49),
+	SH_PFC_PIN_GROUP(intc_irq29_port50),
+	SH_PFC_PIN_GROUP(intc_irq28_port56),
+	SH_PFC_PIN_GROUP(intc_irq27_port57),
+	SH_PFC_PIN_GROUP(intc_irq26_port58),
+	SH_PFC_PIN_GROUP(intc_irq15_port62),
+	SH_PFC_PIN_GROUP(intc_irq14_port63),
+	SH_PFC_PIN_GROUP(intc_irq13_port64),
+	SH_PFC_PIN_GROUP(intc_irq16_port68),
+	SH_PFC_PIN_GROUP(intc_irq26_port81),
+	SH_PFC_PIN_GROUP(intc_irq12_port97),
+	SH_PFC_PIN_GROUP(intc_irq13_port98),
+	SH_PFC_PIN_GROUP(intc_irq14_port99),
+	SH_PFC_PIN_GROUP(intc_irq15_port100),
+	SH_PFC_PIN_GROUP(intc_irq9_port118),
+	SH_PFC_PIN_GROUP(intc_irq7_port120),
+	SH_PFC_PIN_GROUP(intc_irq6_port121),
+	SH_PFC_PIN_GROUP(intc_irq31_port167),
+	SH_PFC_PIN_GROUP(intc_irq27_port168),
+	SH_PFC_PIN_GROUP(intc_irq28_port169),
+	SH_PFC_PIN_GROUP(intc_irq29_port170),
+	SH_PFC_PIN_GROUP(intc_irq30_port171),
+	SH_PFC_PIN_GROUP(intc_irq4_port172),
+	SH_PFC_PIN_GROUP(intc_irq6_port173),
+	SH_PFC_PIN_GROUP(intc_irq7_port209),
+	SH_PFC_PIN_GROUP(intc_irq9_port210),
+	SH_PFC_PIN_GROUP(intc_irq16_port211),
 	SH_PFC_PIN_GROUP(lcd0_data8),
 	SH_PFC_PIN_GROUP(lcd0_data9),
 	SH_PFC_PIN_GROUP(lcd0_data12),
@@ -2112,6 +2230,59 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(sdhi2_wp_1),
 };
 
+static const char * const intc_groups[] = {
+	"intc_irq1",
+	"intc_irq8",
+	"intc_irq10",
+	"intc_irq11",
+	"intc_irq17",
+	"intc_irq18",
+	"intc_irq19",
+	"intc_irq20",
+	"intc_irq21",
+	"intc_irq22",
+	"intc_irq23",
+	"intc_irq24",
+	"intc_irq25",
+	"intc_irq5_port0",
+	"intc_irq5_port1",
+	"intc_irq0_port2",
+	"intc_irq3_port10",
+	"intc_irq2_port11",
+	"intc_irq0_port13",
+	"intc_irq3_port14",
+	"intc_irq4_port15",
+	"intc_irq31_port41",
+	"intc_irq12_port42",
+	"intc_irq30_port49",
+	"intc_irq29_port50",
+	"intc_irq28_port56",
+	"intc_irq27_port57",
+	"intc_irq26_port58",
+	"intc_irq15_port62",
+	"intc_irq14_port63",
+	"intc_irq13_port64",
+	"intc_irq16_port68",
+	"intc_irq26_port81",
+	"intc_irq12_port97",
+	"intc_irq13_port98",
+	"intc_irq14_port99",
+	"intc_irq15_port100",
+	"intc_irq9_port118",
+	"intc_irq7_port120",
+	"intc_irq6_port121",
+	"intc_irq31_port167",
+	"intc_irq27_port168",
+	"intc_irq28_port169",
+	"intc_irq29_port170",
+	"intc_irq30_port171",
+	"intc_irq4_port172",
+	"intc_irq6_port173",
+	"intc_irq7_port209",
+	"intc_irq9_port210",
+	"intc_irq16_port211",
+};
+
 static const char * const lcd0_groups[] = {
 	"lcd0_data8",
 	"lcd0_data9",
-- 
1.7.9.5

