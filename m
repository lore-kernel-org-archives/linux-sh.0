From: Vasiliy Kulikov <segooon@gmail.com>
Date: Sun, 10 Oct 2010 17:28:27 +0000
Subject: [PATCH] sh: boards/mach-x3proto: gpio: fix error handling code
Message-Id: <1286731708-17822-1-git-send-email-segooon@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Checks for (irq < 0) and (ilsel < 0) didn't make sense since they were
unsigned.  Made them signed.

Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
---
 I cannot compile this driver, so it is not tested.

 arch/sh/boards/mach-x3proto/gpio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-x3proto/gpio.c b/arch/sh/boards/mach-x3proto/gpio.c
index 9fcd7ce..594adf7 100644
--- a/arch/sh/boards/mach-x3proto/gpio.c
+++ b/arch/sh/boards/mach-x3proto/gpio.c
@@ -79,7 +79,7 @@ struct gpio_chip x3proto_gpio_chip = {
 
 int __init x3proto_gpio_setup(void)
 {
-	unsigned int ilsel;
+	int ilsel;
 	int ret, i;
 
 	ilsel = ilsel_enable(ILSEL_KEY);
@@ -92,7 +92,7 @@ int __init x3proto_gpio_setup(void)
 
 	for (i = 0; i < NR_BASEBOARD_GPIOS; i++) {
 		unsigned long flags;
-		unsigned int irq = create_irq();
+		int irq = create_irq();
 
 		if (unlikely(irq < 0)) {
 			ret = -EINVAL;
-- 
1.7.0.4

