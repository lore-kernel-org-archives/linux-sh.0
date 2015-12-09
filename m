From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 09 Dec 2015 13:42:37 +0000
Subject: [PATCH 150/182] sh: sdk7786-gpio: switch to gpiochip_add_data()
Message-Id: <1449668557-5309-1-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Michael Welling <mwelling@ieee.org>, Markus Pargmann <mpa@pengutronix.de>, Paul Mundt <lethal@linux-sh.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org

We're planning to remove the gpiochip_add() function to swith
to gpiochip_add_data() with NULL for data argument.

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
SH people: please ACK this so I can take it through the
GPIO tree.
---
 arch/sh/boards/mach-sdk7786/gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-sdk7786/gpio.c b/arch/sh/boards/mach-sdk7786/gpio.c
index f71ce09d4e15..47997010b77a 100644
--- a/arch/sh/boards/mach-sdk7786/gpio.c
+++ b/arch/sh/boards/mach-sdk7786/gpio.c
@@ -9,7 +9,7 @@
  */
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
@@ -44,6 +44,6 @@ static struct gpio_chip usrgpir_gpio_chip = {
 
 static int __init usrgpir_gpio_setup(void)
 {
-	return gpiochip_add(&usrgpir_gpio_chip);
+	return gpiochip_add_data(&usrgpir_gpio_chip, NULL);
 }
 device_initcall(usrgpir_gpio_setup);
-- 
2.4.3

