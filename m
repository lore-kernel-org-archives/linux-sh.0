From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 23 Apr 2014 11:07:28 +0000
Subject: [PATCH] clocksource: sh_cmt: Fix channel IRQ retrieval in legacy case
Message-Id: <1398251248-31504-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

In the legacy platform data case each CMT platform device handles a
single channel with a single IRQ for the platform device. Retrieve the
IRQ using the logical channel number instead of the hardware channel
number.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

This patch applies on top of the clockevents/cmt-mtu2-tmu-cleanups branch of
the git://git.linaro.org/people/daniel.lezcano/linux.git tree. It avoids
breaking bisection of the TMU-related platform cleanup patches, the issue it
fixes will disappear in a later driver cleanup patch. Daniel, I'll ask you to
please apply it to your tree when it will get tested with the timer issues
that Simon has reported.

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
Regards,

Laurent Pinchart

