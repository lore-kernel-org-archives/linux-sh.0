From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:02:33 +0000
Subject: [PATCH 30/35] ARM: shmobile: ap4evb: Simplify tsc2007 pen state read function
Message-Id: <1366671758-8954-31-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The pen state is retrieved by reading the state of a pin used as an IRQ.
There's no need to reconfigure the pin as a pure GPIO, as the IRQ pin
state can be read.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
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
1.8.1.5

