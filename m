From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 23 Sep 2013 21:41:00 +0000
Subject: [PATCH 03/10] ARM: OMAP: Initialize PWM backlight enable_gpio field
Message-Id: <1379972467-11243-4-git-send-email-treding@nvidia.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
In-Reply-To: <1379972467-11243-1-git-send-email-treding@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The GPIO API defines 0 as being a valid GPIO number, so this field needs
to be initialized explicitly.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index a90375d..5ed2884 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -227,6 +227,7 @@ static struct platform_pwm_backlight_data zoom_backlight_data = {
 	.max_brightness = 127,
 	.dft_brightness = 127,
 	.pwm_period_ns = 7812500,
+	.enable_gpio = -1,
 };
 
 static struct platform_device zoom_backlight_pwm = {
-- 
1.8.4

