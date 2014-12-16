From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 16 Dec 2014 09:59:17 +0000
Subject: [PATCH] pinctrl: consumer: use correct retval for placeholder functions
Message-Id: <1418723959-10253-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org
Cc: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

These functions are supposed to return an error pointer, not NULL.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/pinctrl/consumer.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index e96eea7a835c..5e949122529d 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -83,7 +83,7 @@ static inline int pinctrl_gpio_direction_output(unsigned gpio)
 
 static inline struct pinctrl * __must_check pinctrl_get(struct device *dev)
 {
-	return NULL;
+	return ERR_PTR(-ENOSYS);
 }
 
 static inline void pinctrl_put(struct pinctrl *p)
@@ -94,7 +94,7 @@ static inline struct pinctrl_state * __must_check pinctrl_lookup_state(
 							struct pinctrl *p,
 							const char *name)
 {
-	return NULL;
+	return ERR_PTR(-ENOSYS);
 }
 
 static inline int pinctrl_select_state(struct pinctrl *p,
@@ -109,7 +109,7 @@ static inline void pinctrl_deselect_state(struct pinctrl *p)
 
 static inline struct pinctrl * __must_check devm_pinctrl_get(struct device *dev)
 {
-	return NULL;
+	return ERR_PTR(-ENOSYS);
 }
 
 static inline void devm_pinctrl_put(struct pinctrl *p)
-- 
2.1.3

