From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 09 Dec 2015 13:42:46 +0000
Subject: [PATCH 151/182] sh: x3proto-gpio: switch to gpiochip_add_data()
Message-Id: <1449668566-5356-1-git-send-email-linus.walleij@linaro.org>
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
 arch/sh/boards/mach-x3proto/gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-x3proto/gpio.c b/arch/sh/boards/mach-x3proto/gpio.c
index 1fb2cbee25f2..cea88b0effa2 100644
--- a/arch/sh/boards/mach-x3proto/gpio.c
+++ b/arch/sh/boards/mach-x3proto/gpio.c
@@ -13,7 +13,7 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
@@ -107,7 +107,7 @@ int __init x3proto_gpio_setup(void)
 	if (unlikely(ilsel < 0))
 		return ilsel;
 
-	ret = gpiochip_add(&x3proto_gpio_chip);
+	ret = gpiochip_add_data(&x3proto_gpio_chip, NULL);
 	if (unlikely(ret))
 		goto err_gpio;
 
-- 
2.4.3

