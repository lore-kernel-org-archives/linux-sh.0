From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 24 Jul 2012 13:26:09 +0000
Subject: [PATCH 2/2] ARM: mach-shmobile: armadillo800eva: Enable power button as wakeup source
Message-Id: <1343136369-14636-3-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 04cb65a..a70993f 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -412,10 +412,11 @@ static struct platform_device lcdc0_device = {
 };
 
 /* GPIO KEY */
-#define GPIO_KEY(c, g, d) { .code = c, .gpio = g, .desc = d, .active_low = 1 }
+#define GPIO_KEY(c, g, d, ...) \
+	{ .code = c, .gpio = g, .desc = d, .active_low = 1, __VA_ARGS__ }
 
 static struct gpio_keys_button gpio_buttons[] = {
-	GPIO_KEY(KEY_POWER,	GPIO_PORT99,	"SW3"),
+	GPIO_KEY(KEY_POWER,	GPIO_PORT99,	"SW3", .wakeup = 1),
 	GPIO_KEY(KEY_BACK,	GPIO_PORT100,	"SW4"),
 	GPIO_KEY(KEY_MENU,	GPIO_PORT97,	"SW5"),
 	GPIO_KEY(KEY_HOME,	GPIO_PORT98,	"SW6"),
-- 
1.7.8.6

