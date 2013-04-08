From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 08 Apr 2013 10:05:30 +0000
Subject: [PATCH v2 1/3] gpio-rcar: Add RCAR_GP_PIN macro
Message-Id: <1365415532-24544-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Pins are numbered in the R-Car family documentation using a bank number
and a pin number in the bank. As the Linux pin number space is linear,
we need to flatten this by multiplying the bank number by 32 and adding
the pin number. The resulting number bear no directly visible
relationship  to the documentation, making it error-prone.

Add a RCAR_GP_PIN macro to convert from the documentation pin number
space to the linear Linux space.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 include/linux/platform_data/gpio-rcar.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/platform_data/gpio-rcar.h b/include/linux/platform_data/gpio-rcar.h
index b253f77..cc472f6 100644
--- a/include/linux/platform_data/gpio-rcar.h
+++ b/include/linux/platform_data/gpio-rcar.h
@@ -23,4 +23,6 @@ struct gpio_rcar_config {
 	const char *pctl_name;
 };
 
+#define RCAR_GP_PIN(bank, pin)		(((bank) * 32) + (pin))
+
 #endif /* __GPIO_RCAR_H__ */
-- 
1.8.1.5

