From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 23 Dec 2013 02:07:14 +0000
Subject: [PATCH 09/26] ARM: shmobile: koelsch: set .debounce_interval
Message-Id: <478e2f9ca5ac9862a5cac0798814ba7d6a5de002.1387763524.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1387763524.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1387763524.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

In R-Car GPIO hardware block, 'chattering removal' feature can be
enabled on GPIO-n-[3:0] pins, but it's not supported on rest of pins
GPIO-n-[31:4].

Set an appropriate debounce interval, instead.  We could confirm that
spurious/unnecessary GPIO interrupts are prevented by this settings.

Based on work for the lager board by Shinya Kuribayashi.

Cc: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index 59fa0b9..5b81a34 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -56,7 +56,8 @@ static const struct gpio_led_platform_data koelsch_leds_pdata __initconst = {
 
 /* GPIO KEY */
 #define GPIO_KEY(c, g, d, ...) \
-	{ .code = c, .gpio = g, .desc = d, .active_low = 1 }
+	{ .code = c, .gpio = g, .desc = d, .active_low = 1, \
+	  .debounce_interval = 20 }
 
 static struct gpio_keys_button gpio_buttons[] = {
 	GPIO_KEY(KEY_4,		RCAR_GP_PIN(5, 3),	"SW2-pin4"),
-- 
1.8.4

