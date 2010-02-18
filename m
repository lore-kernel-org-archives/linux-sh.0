From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 18 Feb 2010 07:44:41 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: Add SCIFA0 support
Message-Id: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index bcd4456..41bc248 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -189,6 +189,10 @@ static void __init ap4evb_init(void)
 {
 	sh7372_pinmux_init();
 
+	/* enable SCIFA0 */
+	gpio_request(GPIO_FN_SCIFA0_TXD, NULL);
+	gpio_request(GPIO_FN_SCIFA0_RXD, NULL);
+
 	/* enable SMSC911X */
 	gpio_request(GPIO_FN_CS5A,	NULL);
 	gpio_request(GPIO_FN_IRQ6_39,	NULL);
-- 
1.6.3.3

