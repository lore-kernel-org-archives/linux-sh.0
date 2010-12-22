From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 22 Dec 2010 06:30:19 +0000
Subject: [PATCH] ARM: mach-shmobile: Use pullups for AG5EVM KEYSC pins
Message-Id: <20101222063019.28467.5098.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Takashi YOSHII <takashi.yoshii.zj@renesas.com>

Follow up to pfc-sh73a0.c's pull-up support.
Change GPIO_FN_KEYINx to GPIO_FN_KEYINx_PU.

Signed-off-by: Takashi YOSHII <takashi.yoshii.zj@renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ag5evm.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- 0004/arch/arm/mach-shmobile/board-ag5evm.c
+++ work/arch/arm/mach-shmobile/board-ag5evm.c	2010-12-22 15:27:07.000000000 +0900
@@ -197,14 +197,14 @@ static void __init ag5evm_init(void)
 	gpio_request(GPIO_FN_SCIFA2_CTS1_, NULL);
 
 	/* enable KEYSC */
-	gpio_request(GPIO_FN_KEYIN0, NULL);
-	gpio_request(GPIO_FN_KEYIN1, NULL);
-	gpio_request(GPIO_FN_KEYIN2, NULL);
-	gpio_request(GPIO_FN_KEYIN3, NULL);
-	gpio_request(GPIO_FN_KEYIN4, NULL);
-	gpio_request(GPIO_FN_KEYIN5, NULL);
-	gpio_request(GPIO_FN_KEYIN6, NULL);
-	gpio_request(GPIO_FN_KEYIN7, NULL);
+	gpio_request(GPIO_FN_KEYIN0_PU, NULL);
+	gpio_request(GPIO_FN_KEYIN1_PU, NULL);
+	gpio_request(GPIO_FN_KEYIN2_PU, NULL);
+	gpio_request(GPIO_FN_KEYIN3_PU, NULL);
+	gpio_request(GPIO_FN_KEYIN4_PU, NULL);
+	gpio_request(GPIO_FN_KEYIN5_PU, NULL);
+	gpio_request(GPIO_FN_KEYIN6_PU, NULL);
+	gpio_request(GPIO_FN_KEYIN7_PU, NULL);
 	gpio_request(GPIO_FN_KEYOUT0, NULL);
 	gpio_request(GPIO_FN_KEYOUT1, NULL);
 	gpio_request(GPIO_FN_KEYOUT2, NULL);
