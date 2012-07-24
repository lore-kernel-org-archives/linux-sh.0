From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 24 Jul 2012 13:26:08 +0000
Subject: [PATCH 1/2] ARM: mach-shmobile: armadillo800eva: Fix GPIO buttons descriptions
Message-Id: <1343136369-14636-2-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87bomfuove.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bomfuove.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The GPIO buttons are named SW3, SW4, SW5 and SW6 on the board
silkscreen. Update the buttons descriptions accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 6948212..04cb65a 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -415,10 +415,10 @@ static struct platform_device lcdc0_device = {
 #define GPIO_KEY(c, g, d) { .code = c, .gpio = g, .desc = d, .active_low = 1 }
 
 static struct gpio_keys_button gpio_buttons[] = {
-	GPIO_KEY(KEY_POWER,	GPIO_PORT99,	"SW1"),
-	GPIO_KEY(KEY_BACK,	GPIO_PORT100,	"SW2"),
-	GPIO_KEY(KEY_MENU,	GPIO_PORT97,	"SW3"),
-	GPIO_KEY(KEY_HOME,	GPIO_PORT98,	"SW4"),
+	GPIO_KEY(KEY_POWER,	GPIO_PORT99,	"SW3"),
+	GPIO_KEY(KEY_BACK,	GPIO_PORT100,	"SW4"),
+	GPIO_KEY(KEY_MENU,	GPIO_PORT97,	"SW5"),
+	GPIO_KEY(KEY_HOME,	GPIO_PORT98,	"SW6"),
 };
 
 static struct gpio_keys_platform_data gpio_key_info = {
-- 
1.7.8.6

