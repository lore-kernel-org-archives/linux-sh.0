From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Mon, 11 May 2009 06:51:28 +0000
Subject: [PATCH] sh: sh7785lcr: fix I2C device address map for 32-bit mode
Message-Id: <4A07CAF0.9080701@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix the problem that cannot work RTC on 32-bit mode.
The cause is because the board datasheet had a mistake.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 arch/sh/include/mach-common/mach/sh7785lcr.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sh/include/mach-common/mach/sh7785lcr.h b/arch/sh/include/mach-common/mach/sh7785lcr.h
index 1ce27d5..90011d4 100644
--- a/arch/sh/include/mach-common/mach/sh7785lcr.h
+++ b/arch/sh/include/mach-common/mach/sh7785lcr.h
@@ -9,11 +9,11 @@
  * -----------------------------+---------------+---------------
  * 0x00000000 - 0x03ffffff(CS0)	| NOR Flash	| NOR Flash
  * 0x04000000 - 0x05ffffff(CS1)	| PLD		| PLD
- * 0x06000000 - 0x07ffffff(CS1)	| reserved	| I2C
+ * 0x06000000 - 0x07ffffff(CS1)	| I2C		| I2C
  * 0x08000000 - 0x0bffffff(CS2)	| USB		| DDR SDRAM
  * 0x0c000000 - 0x0fffffff(CS3)	| SD		| DDR SDRAM
  * 0x10000000 - 0x13ffffff(CS4)	| SM107		| SM107
- * 0x14000000 - 0x17ffffff(CS5)	| I2C		| USB
+ * 0x14000000 - 0x17ffffff(CS5)	| reserved	| USB
  * 0x18000000 - 0x1bffffff(CS6)	| reserved	| SD
  * 0x40000000 - 0x5fffffff	| DDR SDRAM	| (cannot use)
  *
@@ -32,6 +32,9 @@
 #define PLD_VERSR		(PLD_BASE_ADDR + 0x0c)
 #define PLD_MMSR		(PLD_BASE_ADDR + 0x0e)

+#define PCA9564_ADDR		0x06000000	/* I2C */
+#define PCA9564_SIZE		0x00000100
+
 #define SM107_MEM_ADDR		0x10000000
 #define SM107_MEM_SIZE		0x00e00000
 #define SM107_REG_ADDR		0x13e00000
@@ -40,16 +43,13 @@
 #if defined(CONFIG_SH_SH7785LCR_29BIT_PHYSMAPS)
 #define R8A66597_ADDR		0x14000000	/* USB */
 #define CG200_ADDR		0x18000000	/* SD */
-#define PCA9564_ADDR		0x06000000	/* I2C */
 #else
 #define R8A66597_ADDR		0x08000000
 #define CG200_ADDR		0x0c000000
-#define PCA9564_ADDR		0x14000000
 #endif

 #define R8A66597_SIZE		0x00000100
 #define CG200_SIZE		0x00010000
-#define PCA9564_SIZE		0x00000100

 #endif  /* __ASM_SH_RENESAS_SH7785LCR_H */

-- 
1.5.5

