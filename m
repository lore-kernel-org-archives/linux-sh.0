From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 24 Jan 2013 12:16:31 +0000
Subject: [PATCH v2 4/8] ARM: shmobile: armadillo800eva: Use gpio_set_value() to set GPIO value
Message-Id: <1359029795-7871-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The GPIO is already configured as an output, there's no reason to use
gpio_direction_output() just to set the output value. Use
gpio_set_value() instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 838a56c..2adb28f 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -700,9 +700,9 @@ static int mt9t111_power(struct device *dev, int mode)
 		/* video1 (= CON1 camera) expect 24MHz */
 		clk_set_rate(mclk, clk_round_rate(mclk, 24000000));
 		clk_enable(mclk);
-		gpio_direction_output(GPIO_PORT158, 1);
+		gpio_set_value(GPIO_PORT158, 1);
 	} else {
-		gpio_direction_output(GPIO_PORT158, 0);
+		gpio_set_value(GPIO_PORT158, 0);
 		clk_disable(mclk);
 	}
 
-- 
1.7.12.4

