From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 02 Jun 2009 09:22:02 +0000
Subject: [PATCH] sh: rework mode pin code
Message-Id: <20090602092202.7558.11142.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch reworks the mode pin code to keep the pin
definitions in one place. The mode pins values are now
the value of the bit instead of bit number.

With this patch in place the sh7785 header file contains
mode pin comments. The sh7785 clock code and the sh7785lcr
board code are updated to reflect the new shared mode pins.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/board-sh7785lcr.c       |   14 +++++------
 arch/sh/include/asm/processor.h        |   17 +++++++++++++
 arch/sh/include/cpu-sh4/cpu/sh7785.h   |   39 ++++++++++++++++----------------
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |    2 -
 arch/sh/kernel/setup.c                 |    2 -
 5 files changed, 46 insertions(+), 28 deletions(-)

--- 0001/arch/sh/boards/board-sh7785lcr.c
+++ work/arch/sh/boards/board-sh7785lcr.c	2009-06-02 17:56:30.000000000 +0900
@@ -330,13 +330,13 @@ static int sh7785lcr_mode_pins(void)
 	 * If you change these dip switches then you will need to
 	 * adjust the values below as well.
 	 */
-	value |= 1 << MODE_PIN_MODE4; /* Clock Mode 16 */
-	value |= 1 << MODE_PIN_MODE5; /* 32-bit Area0 bus width */
-	value |= 1 << MODE_PIN_MODE6; /* 32-bit Area0 bus width */
-	value |= 1 << MODE_PIN_MODE7; /* Area 0 SRAM interface [fixed] */
-	value |= 1 << MODE_PIN_MODE8; /* Little Endian */
-	value |= 1 << MODE_PIN_MODE9; /* Master Mode */
-	value |= 1 << MODE_PIN_MODE14; /* No PLL step-up */
+	value |= MODE_PIN4; /* Clock Mode 16 */
+	value |= MODE_PIN5; /* 32-bit Area0 bus width */
+	value |= MODE_PIN6; /* 32-bit Area0 bus width */
+	value |= MODE_PIN7; /* Area 0 SRAM interface [fixed] */
+	value |= MODE_PIN8; /* Little Endian */
+	value |= MODE_PIN9; /* Master Mode */
+	value |= MODE_PIN14; /* No PLL step-up */
 
 	return value;
 }
--- 0001/arch/sh/include/asm/processor.h
+++ work/arch/sh/include/asm/processor.h	2009-06-02 17:58:30.000000000 +0900
@@ -95,6 +95,23 @@ const char *get_cpu_subtype(struct sh_cp
 extern const struct seq_operations cpuinfo_op;
 
 /* processor boot mode configuration */
+#define MODE_PIN0 (1 << 0)
+#define MODE_PIN1 (1 << 1)
+#define MODE_PIN2 (1 << 2)
+#define MODE_PIN3 (1 << 3)
+#define MODE_PIN4 (1 << 4)
+#define MODE_PIN5 (1 << 5)
+#define MODE_PIN6 (1 << 6)
+#define MODE_PIN7 (1 << 7)
+#define MODE_PIN8 (1 << 8)
+#define MODE_PIN9 (1 << 9)
+#define MODE_PIN10 (1 << 10)
+#define MODE_PIN11 (1 << 11)
+#define MODE_PIN12 (1 << 12)
+#define MODE_PIN13 (1 << 13)
+#define MODE_PIN14 (1 << 14)
+#define MODE_PIN15 (1 << 15)
+
 int generic_mode_pins(void);
 int test_mode_pin(int pin);
 
--- 0001/arch/sh/include/cpu-sh4/cpu/sh7785.h
+++ work/arch/sh/include/cpu-sh4/cpu/sh7785.h	2009-06-02 18:02:17.000000000 +0900
@@ -1,25 +1,26 @@
 #ifndef __ASM_SH7785_H__
 #define __ASM_SH7785_H__
 
-/* Boot Mode Pins, more information in sh7785 manual Rev.1.00, page 1628 */
-enum {
-	MODE_PIN_MODE0,  /* CPG - Initial Pck/Bck Frequency [FRQMR1] */
-	MODE_PIN_MODE1,  /* CPG - Initial Uck/SHck/DDRck Frequency [FRQMR1] */
-	MODE_PIN_MODE2,  /* CPG - Reserved (L: Normal operation) */
-	MODE_PIN_MODE3,  /* CPG - Reserved (L: Normal operation) */
-	MODE_PIN_MODE4,  /* CPG - Initial PLL setting (72x/36x) */
-	MODE_PIN_MODE5,  /* LBSC - Area0 Memory Type / Bus Width [CS0BCR.8] */
-	MODE_PIN_MODE6,  /* LBSC - Area0 Memory Type / Bus Width [CS0BCR.9] */
-	MODE_PIN_MODE7,  /* LBSC - Area0 Memory Type / Bus Width [CS0BCR.3] */
-	MODE_PIN_MODE8,  /* LBSC - Endian Mode (L: Big, H: Little) [BCR.31] */
-	MODE_PIN_MODE9,  /* LBSC - Master/Slave Mode (L: Slave) [BCR.30] */
-	MODE_PIN_MODE10, /* CPG - Clock Input (L: Ext Clk, H: Crystal) */
-	MODE_PIN_MODE11, /* PCI - Pin Mode (LL: PCI host, LH: PCI slave) */
-	MODE_PIN_MODE12, /* PCI - Pin Mode (HL: Local bus, HH: DU) */
-	MODE_PIN_MODE13, /* Boot Address Mode (L: 29-bit, H: 32-bit) */
-	MODE_PIN_MODE14, /* Reserved (H: Normal operation) */
-	MODE_PIN_MPMD,   /* Emulation Mode (L: Emulation mode, H: LSI mode) */
-};
+/* Boot Mode Pins:
+ *
+ * MODE0: CPG - Initial Pck/Bck Frequency [FRQMR1]
+ * MODE1: CPG - Initial Uck/SHck/DDRck Frequency [FRQMR1]
+ * MODE2: CPG - Reserved (L: Normal operation)
+ * MODE3: CPG - Reserved (L: Normal operation)
+ * MODE4: CPG - Initial PLL setting (72x/36x)
+ * MODE5: LBSC - Area0 Memory Type / Bus Width [CS0BCR.8]
+ * MODE6: LBSC - Area0 Memory Type / Bus Width [CS0BCR.9]
+ * MODE7: LBSC - Area0 Memory Type / Bus Width [CS0BCR.3]
+ * MODE8: LBSC - Endian Mode (L: Big, H: Little) [BCR.31]
+ * MODE9: LBSC - Master/Slave Mode (L: Slave) [BCR.30]
+ * MODE10: CPG - Clock Input (L: Ext Clk, H: Crystal)
+ * MODE11: PCI - Pin Mode (LL: PCI host, LH: PCI slave)
+ * MODE12: PCI - Pin Mode (HL: Local bus, HH: DU)
+ * MODE13: Boot Address Mode (L: 29-bit, H: 32-bit)
+ * MODE14: Reserved (H: Normal operation)
+ *
+ * More information in sh7785 manual Rev.1.00, page 1628.
+ */
 
 /* Pin Function Controller:
  * GPIO_FN_xx - GPIO used to select pin function
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7785.c	2009-06-02 17:56:07.000000000 +0900
@@ -32,7 +32,7 @@ static unsigned long pll_recalc(struct c
 {
 	int multiplier;
 
-	multiplier = test_mode_pin(MODE_PIN_MODE4) ? 36 : 72;
+	multiplier = test_mode_pin(MODE_PIN4) ? 36 : 72;
 
 	return clk->parent->rate * multiplier;
 }
--- 0001/arch/sh/kernel/setup.c
+++ work/arch/sh/kernel/setup.c	2009-06-02 17:58:59.000000000 +0900
@@ -429,7 +429,7 @@ int generic_mode_pins(void)
 
 int test_mode_pin(int pin)
 {
-	return sh_mv.mv_mode_pins() & (1 << pin);
+	return sh_mv.mv_mode_pins() & pin;
 }
 
 static const char *cpu_name[] = {
