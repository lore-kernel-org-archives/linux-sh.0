From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 05 Jun 2013 08:25:43 +0000
Subject: [PATCH 052/130] ARM: shmobile: ap4evb: Simplify tsc2007 pen state read function
Message-Id: <1370420821-28420-53-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The pen state is retrieved by reading the state of a pin used as an IRQ.
There's no need to reconfigure the pin as a pure GPIO, as the IRQ pin
state can be read.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ap4evb.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 9ee8bcd..0109bb3 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1037,22 +1037,13 @@ out:
 #define IRQ7	evt2irq(0x02e0) /* IRQ7A */
 static int ts_get_pendown_state(void)
 {
-	int val;
-
-	gpio_free(GPIO_TSC_IRQ);
-
-	gpio_request_one(GPIO_TSC_PORT, GPIOF_IN, NULL);
-
-	val = gpio_get_value(GPIO_TSC_PORT);
-
-	gpio_request(GPIO_TSC_IRQ, NULL);
-
-	return !val;
+	return !gpio_get_value(GPIO_TSC_PORT);
 }
 
 static int ts_init(void)
 {
 	gpio_request(GPIO_TSC_IRQ, NULL);
+	gpio_request_one(GPIO_TSC_PORT, GPIOF_IN, NULL);
 
 	return 0;
 }
-- 
1.8.2.1

