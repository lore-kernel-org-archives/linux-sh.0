From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 28 Dec 2010 05:54:53 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4/mackerel: modify wrong comment out of
Message-Id: <w3ptyhy8msa.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c   |    2 +-
 arch/arm/mach-shmobile/board-mackerel.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index a119675..9c56946 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1181,7 +1181,7 @@ static void __init ap4evb_init(void)
 	gpio_request(GPIO_FN_OVCN2_1,    NULL);
 
 	/* setup USB phy */
-	__raw_writew(0x8a0a, 0xE6058130);	/* USBCR2 */
+	__raw_writew(0x8a0a, 0xE6058130);	/* USBCR4 */
 
 	/* enable FSI2 port A (ak4643) */
 	gpio_request(GPIO_FN_FSIAIBT,	NULL);
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 0a79112..82ce74f 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -735,7 +735,7 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_OVCN2_1,    NULL);
 
 	/* setup USB phy */
-	__raw_writew(0x8a0a, 0xE6058130);	/* USBCR2 */
+	__raw_writew(0x8a0a, 0xE6058130);	/* USBCR4 */
 
 	/* enable FSI2 port A (ak4643) */
 	gpio_request(GPIO_FN_FSIAIBT,	NULL);
-- 
1.7.1

