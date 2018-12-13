From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 13 Dec 2018 18:27:05 +0000
Subject: [PATCH 06/15] pinctrl: sh-pfc: r8a77995: Remove bogus SEL_PWM[0-3]_3 configurations
Message-Id: <20181213182714.26094-7-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213182714.26094-1-geert+renesas@glider.be>
In-Reply-To: <20181213182714.26094-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

While the SEL_PWM[0-3] fields in the Module Select Register 0 support 4
possible configurations per PWM pin, only the first 3 are valid.

Replace the invalid and unused configurations for SEL_PWM[0-3]_3 by
dummies.

Fixes: 794a6711764658a1 ("pinctrl: sh-pfc: Initial R8A77995 PFC support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
index e457539a61c55bb9..84d78db381e30249 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
@@ -388,10 +388,10 @@ FM(IP12_31_28)	IP12_31_28 \
 #define MOD_SEL0_27		FM(SEL_MSIOF3_0)	FM(SEL_MSIOF3_1)
 #define MOD_SEL0_26		FM(SEL_HSCIF3_0)	FM(SEL_HSCIF3_1)
 #define MOD_SEL0_25		FM(SEL_SCIF4_0)		FM(SEL_SCIF4_1)
-#define MOD_SEL0_24_23		FM(SEL_PWM0_0)		FM(SEL_PWM0_1)		FM(SEL_PWM0_2)		FM(SEL_PWM0_3)
-#define MOD_SEL0_22_21		FM(SEL_PWM1_0)		FM(SEL_PWM1_1)		FM(SEL_PWM1_2)		FM(SEL_PWM1_3)
-#define MOD_SEL0_20_19		FM(SEL_PWM2_0)		FM(SEL_PWM2_1)		FM(SEL_PWM2_2)		FM(SEL_PWM2_3)
-#define MOD_SEL0_18_17		FM(SEL_PWM3_0)		FM(SEL_PWM3_1)		FM(SEL_PWM3_2)		FM(SEL_PWM3_3)
+#define MOD_SEL0_24_23		FM(SEL_PWM0_0)		FM(SEL_PWM0_1)		FM(SEL_PWM0_2)		F_(0, 0)
+#define MOD_SEL0_22_21		FM(SEL_PWM1_0)		FM(SEL_PWM1_1)		FM(SEL_PWM1_2)		F_(0, 0)
+#define MOD_SEL0_20_19		FM(SEL_PWM2_0)		FM(SEL_PWM2_1)		FM(SEL_PWM2_2)		F_(0, 0)
+#define MOD_SEL0_18_17		FM(SEL_PWM3_0)		FM(SEL_PWM3_1)		FM(SEL_PWM3_2)		F_(0, 0)
 #define MOD_SEL0_15		FM(SEL_IRQ_0_0)		FM(SEL_IRQ_0_1)
 #define MOD_SEL0_14		FM(SEL_IRQ_1_0)		FM(SEL_IRQ_1_1)
 #define MOD_SEL0_13		FM(SEL_IRQ_2_0)		FM(SEL_IRQ_2_1)
-- 
2.17.1
