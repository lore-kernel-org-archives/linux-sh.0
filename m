From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 30 Jun 2011 07:30:29 +0000
Subject: [PATCH] ARM: mach-shmobile: sh73a0: add MMC data pin pull-up
Message-Id: <87k4c34vzl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add MMC data pin pull-up option and select it for ag5evm.
The MMC read/write will be error if without this patch

Cc: Takashi YOSHII <takashi.yoshii.zj@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c        |   16 ++++++++--------
 arch/arm/mach-shmobile/include/mach/sh73a0.h |    8 ++++++++
 arch/arm/mach-shmobile/pfc-sh73a0.c          |   25 +++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index ce5c251..9761f80 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -506,14 +506,14 @@ static void __init ag5evm_init(void)
 	/* enable MMCIF */
 	gpio_request(GPIO_FN_MMCCLK0, NULL);
 	gpio_request(GPIO_FN_MMCCMD0_PU, NULL);
-	gpio_request(GPIO_FN_MMCD0_0, NULL);
-	gpio_request(GPIO_FN_MMCD0_1, NULL);
-	gpio_request(GPIO_FN_MMCD0_2, NULL);
-	gpio_request(GPIO_FN_MMCD0_3, NULL);
-	gpio_request(GPIO_FN_MMCD0_4, NULL);
-	gpio_request(GPIO_FN_MMCD0_5, NULL);
-	gpio_request(GPIO_FN_MMCD0_6, NULL);
-	gpio_request(GPIO_FN_MMCD0_7, NULL);
+	gpio_request(GPIO_FN_MMCD0_0_PU, NULL);
+	gpio_request(GPIO_FN_MMCD0_1_PU, NULL);
+	gpio_request(GPIO_FN_MMCD0_2_PU, NULL);
+	gpio_request(GPIO_FN_MMCD0_3_PU, NULL);
+	gpio_request(GPIO_FN_MMCD0_4_PU, NULL);
+	gpio_request(GPIO_FN_MMCD0_5_PU, NULL);
+	gpio_request(GPIO_FN_MMCD0_6_PU, NULL);
+	gpio_request(GPIO_FN_MMCD0_7_PU, NULL);
 	gpio_request(GPIO_PORT208, NULL); /* Reset */
 	gpio_direction_output(GPIO_PORT208, 1);
 
diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
index 216c3d6..93b44d6 100644
--- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
@@ -458,6 +458,14 @@ enum {
 	GPIO_FN_SDHICMD1_PU,
 	GPIO_FN_MMCCMD0_PU,
 	GPIO_FN_MMCCMD1_PU,
+	GPIO_FN_MMCD0_0_PU,
+	GPIO_FN_MMCD0_1_PU,
+	GPIO_FN_MMCD0_2_PU,
+	GPIO_FN_MMCD0_3_PU,
+	GPIO_FN_MMCD0_4_PU,
+	GPIO_FN_MMCD0_5_PU,
+	GPIO_FN_MMCD0_6_PU,
+	GPIO_FN_MMCD0_7_PU,
 	GPIO_FN_FSIACK_PU,
 	GPIO_FN_FSIAILR_PU,
 	GPIO_FN_FSIAIBT_PU,
diff --git a/arch/arm/mach-shmobile/pfc-sh73a0.c b/arch/arm/mach-shmobile/pfc-sh73a0.c
index 3eed44e..2343c7f 100644
--- a/arch/arm/mach-shmobile/pfc-sh73a0.c
+++ b/arch/arm/mach-shmobile/pfc-sh73a0.c
@@ -495,6 +495,14 @@ enum {
 	SDHICMD1_PU_MARK,
 	MMCCMD0_PU_MARK,
 	MMCCMD1_PU_MARK,
+	MMCD0_0_PU_MARK,
+	MMCD0_1_PU_MARK,
+	MMCD0_2_PU_MARK,
+	MMCD0_3_PU_MARK,
+	MMCD0_4_PU_MARK,
+	MMCD0_5_PU_MARK,
+	MMCD0_6_PU_MARK,
+	MMCD0_7_PU_MARK,
 	FSIACK_PU_MARK,
 	FSIAILR_PU_MARK,
 	FSIAIBT_PU_MARK,
@@ -1526,6 +1534,15 @@ static pinmux_enum_t pinmux_data[] = {
 		MSEL4CR_MSEL15_0),
 	PINMUX_DATA(MMCCMD1_PU_MARK, PORT297_FN2, PORT279_IN_PU,
 		MSEL4CR_MSEL15_1),
+	PINMUX_DATA(MMCD0_0_PU_MARK, PORT271_FN1, PORT271_IN_PU, MSEL4CR_MSEL15_0),
+	PINMUX_DATA(MMCD0_1_PU_MARK, PORT272_FN1, PORT272_IN_PU, MSEL4CR_MSEL15_0),
+	PINMUX_DATA(MMCD0_2_PU_MARK, PORT273_FN1, PORT273_IN_PU, MSEL4CR_MSEL15_0),
+	PINMUX_DATA(MMCD0_3_PU_MARK, PORT274_FN1, PORT274_IN_PU, MSEL4CR_MSEL15_0),
+	PINMUX_DATA(MMCD0_4_PU_MARK, PORT275_FN1, PORT275_IN_PU, MSEL4CR_MSEL15_0),
+	PINMUX_DATA(MMCD0_5_PU_MARK, PORT276_FN1, PORT276_IN_PU, MSEL4CR_MSEL15_0),
+	PINMUX_DATA(MMCD0_6_PU_MARK, PORT277_FN1, PORT277_IN_PU, MSEL4CR_MSEL15_0),
+	PINMUX_DATA(MMCD0_7_PU_MARK, PORT278_FN1, PORT278_IN_PU, MSEL4CR_MSEL15_0),
+
 	PINMUX_DATA(FSIACK_PU_MARK, PORT49_FN1, PORT49_IN_PU),
 	PINMUX_DATA(FSIAILR_PU_MARK, PORT50_FN5, PORT50_IN_PU),
 	PINMUX_DATA(FSIAIBT_PU_MARK, PORT51_FN5, PORT51_IN_PU),
@@ -2188,6 +2205,14 @@ static struct pinmux_gpio pinmux_gpios[] = {
 	GPIO_FN(SDHICMD1_PU),
 	GPIO_FN(MMCCMD0_PU),
 	GPIO_FN(MMCCMD1_PU),
+	GPIO_FN(MMCD0_0_PU),
+	GPIO_FN(MMCD0_1_PU),
+	GPIO_FN(MMCD0_2_PU),
+	GPIO_FN(MMCD0_3_PU),
+	GPIO_FN(MMCD0_4_PU),
+	GPIO_FN(MMCD0_5_PU),
+	GPIO_FN(MMCD0_6_PU),
+	GPIO_FN(MMCD0_7_PU),
 	GPIO_FN(FSIACK_PU),
 	GPIO_FN(FSIAILR_PU),
 	GPIO_FN(FSIAIBT_PU),
-- 
1.7.4.1

