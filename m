From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 22 Oct 2008 09:29:17 +0000
Subject: [PATCH] sh: improve pinmux support for single direction pins
Message-Id: <20081022092917.1078.93030.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch improves the support for gpio pins that are hard wired
to either input or output and lack control register association.
A special force enum id is used to allow use without control
register but still mark the gpio pin as input or output.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/gpio.h              |    1 
 arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c |   43 +++++++++++++++----------------
 arch/sh/kernel/gpio.c                   |    6 +++-
 3 files changed, 27 insertions(+), 23 deletions(-)

--- 0001/arch/sh/include/asm/gpio.h
+++ work/arch/sh/include/asm/gpio.h	2008-10-22 16:06:18.000000000 +0900
@@ -64,6 +64,7 @@ struct pinmux_data_reg {
 struct pinmux_range {
 	pinmux_enum_t begin;
 	pinmux_enum_t end;
+	pinmux_enum_t force;
 };
 
 struct pinmux_info {
--- 0001/arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c
+++ work/arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c	2008-10-22 16:17:57.000000000 +0900
@@ -46,11 +46,10 @@ enum {
 	PINMUX_DATA_END,
 
 	PINMUX_INPUT_BEGIN,
+	FORCE_IN,
 	PA7_IN, PA6_IN, PA5_IN, PA4_IN,
 	PA3_IN, PA2_IN, PA1_IN, PA0_IN,
 	PB11_IN, PB10_IN, PB9_IN, PB8_IN,
-	PB7_IN, PB6_IN, PB5_IN, PB4_IN,
-	PB3_IN, PB2_IN, PB1_IN, PB0_IN,
 	PC14_IN, PC13_IN, PC12_IN,
 	PC11_IN, PC10_IN, PC9_IN, PC8_IN,
 	PC7_IN, PC6_IN, PC5_IN, PC4_IN,
@@ -74,7 +73,7 @@ enum {
 	PINMUX_INPUT_END,
 
 	PINMUX_OUTPUT_BEGIN,
-	PB12_OUT,
+	FORCE_OUT,
 	PB11_OUT, PB10_OUT, PB9_OUT, PB8_OUT,
 	PC14_OUT, PC13_OUT, PC12_OUT,
 	PC11_OUT, PC10_OUT, PC9_OUT, PC8_OUT,
@@ -285,7 +284,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(PA0_DATA, PA0_IN),
 
 	/* PB */
-	PINMUX_DATA(PB12_DATA, PB12MD_00, PB12_OUT),
+	PINMUX_DATA(PB12_DATA, PB12MD_00, FORCE_OUT),
 	PINMUX_DATA(WDTOVF_MARK, PB12MD_01),
 	PINMUX_DATA(IRQOUT_MARK, PB12MD_10, PB12IRQ_00),
 	PINMUX_DATA(REFOUT_MARK, PB12MD_10, PB12IRQ_01),
@@ -306,42 +305,42 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(CRX0_MARK, PB8MD_01),
 	PINMUX_DATA(CRX0_CRX1_MARK, PB8MD_10),
 
-	PINMUX_DATA(PB7_DATA, PB7MD_00, PB7_IN),
+	PINMUX_DATA(PB7_DATA, PB7MD_00, FORCE_IN),
 	PINMUX_DATA(SDA3_MARK, PB7MD_01),
 	PINMUX_DATA(PINT7_PB_MARK, PB7MD_10),
 	PINMUX_DATA(IRQ7_PB_MARK, PB7MD_11),
 
-	PINMUX_DATA(PB6_DATA, PB6MD_00, PB6_IN),
+	PINMUX_DATA(PB6_DATA, PB6MD_00, FORCE_IN),
 	PINMUX_DATA(SCL3_MARK, PB6MD_01),
 	PINMUX_DATA(PINT6_PB_MARK, PB6MD_10),
 	PINMUX_DATA(IRQ6_PB_MARK, PB6MD_11),
 
-	PINMUX_DATA(PB5_DATA, PB5MD_00, PB5_IN),
+	PINMUX_DATA(PB5_DATA, PB5MD_00, FORCE_IN),
 	PINMUX_DATA(SDA2_MARK, PB6MD_01),
 	PINMUX_DATA(PINT5_PB_MARK, PB6MD_10),
 	PINMUX_DATA(IRQ5_PB_MARK, PB6MD_11),
 
-	PINMUX_DATA(PB4_DATA, PB4MD_00, PB4_IN),
+	PINMUX_DATA(PB4_DATA, PB4MD_00, FORCE_IN),
 	PINMUX_DATA(SCL2_MARK, PB4MD_01),
 	PINMUX_DATA(PINT4_PB_MARK, PB4MD_10),
 	PINMUX_DATA(IRQ4_PB_MARK, PB4MD_11),
 
-	PINMUX_DATA(PB3_DATA, PB3MD_00, PB3_IN),
+	PINMUX_DATA(PB3_DATA, PB3MD_00, FORCE_IN),
 	PINMUX_DATA(SDA1_MARK, PB3MD_01),
 	PINMUX_DATA(PINT3_PB_MARK, PB3MD_10),
 	PINMUX_DATA(IRQ3_PB_MARK, PB3MD_11),
 
-	PINMUX_DATA(PB2_DATA, PB2MD_00, PB2_IN),
+	PINMUX_DATA(PB2_DATA, PB2MD_00, FORCE_IN),
 	PINMUX_DATA(SCL1_MARK, PB2MD_01),
 	PINMUX_DATA(PINT2_PB_MARK, PB2MD_10),
 	PINMUX_DATA(IRQ2_PB_MARK, PB2MD_11),
 
-	PINMUX_DATA(PB1_DATA, PB1MD_00, PB1_IN),
+	PINMUX_DATA(PB1_DATA, PB1MD_00, FORCE_IN),
 	PINMUX_DATA(SDA0_MARK, PB1MD_01),
 	PINMUX_DATA(PINT1_PB_MARK, PB1MD_10),
 	PINMUX_DATA(IRQ1_PB_MARK, PB1MD_11),
 
-	PINMUX_DATA(PB0_DATA, PB0MD_00, PB0_IN),
+	PINMUX_DATA(PB0_DATA, PB0MD_00, FORCE_IN),
 	PINMUX_DATA(SCL0_MARK, PB0MD_01),
 	PINMUX_DATA(PINT0_PB_MARK, PB0MD_10),
 	PINMUX_DATA(IRQ0_PB_MARK, PB0MD_11),
@@ -1083,14 +1082,14 @@ static struct pinmux_cfg_reg pinmux_conf
 		PB10_IN, PB10_OUT,
 		PB9_IN, PB9_OUT,
 		PB8_IN, PB8_OUT,
-		PB7_IN, 0,
-		PB6_IN, 0,
-		PB5_IN, 0,
-		PB4_IN, 0,
-		PB3_IN, 0,
-		PB2_IN, 0,
-		PB1_IN, 0,
-		PB0_IN, 0 }
+		0, 0,
+		0, 0,
+		0, 0,
+		0, 0,
+		0, 0,
+		0, 0,
+		0, 0,
+		0, 0 }
 	},
 	{ PINMUX_CFG_REG("PBCRL4", 0xfffe3890, 16, 4) {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -1575,8 +1574,8 @@ static struct pinmux_info sh7203_pinmux_
 	.name = "sh7203_pfc",
 	.reserved_id = PINMUX_RESERVED,
 	.data = { PINMUX_DATA_BEGIN, PINMUX_DATA_END },
-	.input = { PINMUX_INPUT_BEGIN, PINMUX_INPUT_END },
-	.output = { PINMUX_OUTPUT_BEGIN, PINMUX_OUTPUT_END },
+	.input = { PINMUX_INPUT_BEGIN, PINMUX_INPUT_END, FORCE_IN },
+	.output = { PINMUX_OUTPUT_BEGIN, PINMUX_OUTPUT_END, FORCE_OUT },
 	.mark = { PINMUX_MARK_BEGIN, PINMUX_MARK_END },
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
 
--- 0001/arch/sh/kernel/gpio.c
+++ work/arch/sh/kernel/gpio.c	2008-10-22 16:22:24.000000000 +0900
@@ -267,9 +267,13 @@ int pinmux_config_gpio(struct pinmux_inf
 			break;
 
 		in_range = enum_in_range(enum_id, &gpioc->function);
-		if (!in_range && range)
+		if (!in_range && range) {
 			in_range = enum_in_range(enum_id, range);
 
+			if (in_range && enum_id = range->force)
+				continue;
+		}
+
 		if (!in_range)
 			continue;
 
