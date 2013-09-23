From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 23 Sep 2013 21:40:59 +0000
Subject: [PATCH 02/10] pwm-backlight: Add optional enable GPIO
Message-Id: <1379972467-11243-3-git-send-email-treding@nvidia.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
In-Reply-To: <1379972467-11243-1-git-send-email-treding@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

To support a wider variety of backlight setups, introduce an optional
enable GPIO. Legacy users of the platform data already have a means of
supporting GPIOs by using the .init(), .exit() and .notify() hooks. DT
users however cannot use those, so an alternative method is required.

In order to ease the introduction of the optional enable GPIO, make it
available in the platform data first, so that existing users can be
converted. Once that has happened a second patch will add code to make
use of it in the driver.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 include/linux/pwm_backlight.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pwm_backlight.h b/include/linux/pwm_backlight.h
index 56f4a86..2de2e27 100644
--- a/include/linux/pwm_backlight.h
+++ b/include/linux/pwm_backlight.h
@@ -6,6 +6,9 @@
 
 #include <linux/backlight.h>
 
+/* TODO: convert to gpiod_*() API once it has been merged */
+#define PWM_BACKLIGHT_GPIO_ACTIVE_LOW	(1 << 0)
+
 struct platform_pwm_backlight_data {
 	int pwm_id;
 	unsigned int max_brightness;
@@ -13,6 +16,8 @@ struct platform_pwm_backlight_data {
 	unsigned int lth_brightness;
 	unsigned int pwm_period_ns;
 	unsigned int *levels;
+	int enable_gpio;
+	unsigned long enable_gpio_flags;
 	int (*init)(struct device *dev);
 	int (*notify)(struct device *dev, int brightness);
 	void (*notify_after)(struct device *dev, int brightness);
-- 
1.8.4

