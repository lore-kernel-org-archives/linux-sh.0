From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 10 Apr 2009 00:54:07 +0000
Subject: [PATCH v2] sh7786: modify usb setup timeout judgment bug.
Message-Id: <uskkdh0oz.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Timeout counter "i" can reach -1 if USB setup isn't done.
And "i" can be 0 if USB setup is done when last possible moment.
Then it is judged to fail though setup is done.
This patch modify this problem.
Special thanks to Mr. Juha Leppanen and Iwamatsu-san for nice advice.

Reported-by: "Juha Leppanen" <juha_motorsportcom@luukku.com>
Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
>> Paul
Can you test this patch on Urquell board please ?

>> Michael
I will try to create patch which skip setup if bootloader is already done.
please wait.

v1 -> v2

o Set the PHY RST bit in "while loop".
  Thank you Iwamatsu-san
o Add Iwamatsu-san's name in patch explanation area

 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index 5a47e1c..90e8cff 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -143,14 +143,14 @@ static void __init sh7786_usb_setup(void)
 	 * Set the PHY and PLL enable bit
 	 */
 	__raw_writel(PHY_ENB | PLL_ENB, USBPCTL1);
-	while (i-- &&
-	       ((__raw_readl(USBST) & ACT_PLL_STATUS) != ACT_PLL_STATUS))
+	while (i--) {
+		if (ACT_PLL_STATUS = (__raw_readl(USBST) & ACT_PLL_STATUS)) {
+			/* Set the PHY RST bit */
+			__raw_writel(PHY_ENB | PLL_ENB | PHY_RST, USBPCTL1);
+			printk(KERN_INFO "sh7786 usb setup done\n");
+			break;
+		}
 		cpu_relax();
-
-	if (i) {
-		/* Set the PHY RST bit */
-		__raw_writel(PHY_ENB | PLL_ENB | PHY_RST, USBPCTL1);
-		printk(KERN_INFO "sh7786 usb setup done\n");
 	}
 }
 
-- 
1.5.6.3

