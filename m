From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 16 Jun 2014 15:07:13 +0000
Subject: [PATCH v4 01/19] clocksource: sh_tmu: Fix channel IRQ retrieval in legacy case
Message-Id: <1402931251-22581-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

In the legacy platform data case each TMU platform device handles a
single channel with a single IRQ for the platform device. Retrieve the
IRQ using the logical channel number instead of the hardware channel
number.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/clocksource/sh_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 4ba2c0f..ec34095 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -498,7 +498,7 @@ static int sh_tmu_channel_setup(struct sh_tmu_channel *ch, unsigned int index,
 			ch->base = tmu->mapbase + 8 + ch->index * 12;
 	}
 
-	ch->irq = platform_get_irq(tmu->pdev, ch->index);
+	ch->irq = platform_get_irq(tmu->pdev, index);
 	if (ch->irq < 0) {
 		dev_err(&tmu->pdev->dev, "ch%u: failed to get irq\n",
 			ch->index);
-- 
1.8.5.5

