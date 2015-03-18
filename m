From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 18 Mar 2015 18:41:08 +0000
Subject: [PATCH 2/3] gpio: rcar: Add more register documentation
Message-Id: <1426704069-26389-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1426704069-26389-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1426704069-26389-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpio/gpio-rcar.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index e67d578ac07c45d5..d96166ca1b42f93e 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -39,18 +39,18 @@ struct gpio_rcar_priv {
 	struct irq_chip irq_chip;
 };
 
-#define IOINTSEL 0x00
-#define INOUTSEL 0x04
-#define OUTDT 0x08
-#define INDT 0x0c
-#define INTDT 0x10
-#define INTCLR 0x14
-#define INTMSK 0x18
-#define MSKCLR 0x1c
-#define POSNEG 0x20
-#define EDGLEVEL 0x24
-#define FILONOFF 0x28
-#define BOTHEDGE 0x4c
+#define IOINTSEL 0x00	/* General IO/Interrupt Switching Register */
+#define INOUTSEL 0x04	/* General Input/Output Switching Register */
+#define OUTDT 0x08	/* General Output Register */
+#define INDT 0x0c	/* General Input Register */
+#define INTDT 0x10	/* Interrupt Display Register */
+#define INTCLR 0x14	/* Interrupt Clear Register */
+#define INTMSK 0x18	/* Interrupt Mask Register */
+#define MSKCLR 0x1c	/* Interrupt Mask Clear Register */
+#define POSNEG 0x20	/* Positive/Negative Logic Select Register */
+#define EDGLEVEL 0x24	/* Edge/level Select Register */
+#define FILONOFF 0x28	/* Chattering Prevention On/Off Register */
+#define BOTHEDGE 0x4c	/* One Edge/Both Edge Select Register */
 
 #define RCAR_MAX_GPIO_PER_BANK		32
 
-- 
1.9.1

