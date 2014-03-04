From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 04 Mar 2014 17:47:16 +0000
Subject: [PATCH 09/22] clocksource: sh_mtu2: Replace kmalloc + memset with kzalloc
Message-Id: <1393955249-18736-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

One kzalloc a day keeps the bugs away.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_mtu2.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 61827c6..94a5342 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -241,8 +241,6 @@ static void sh_mtu2_register_clockevent(struct sh_mtu2_channel *ch,
 	struct clock_event_device *ced = &ch->ced;
 	int ret;
 
-	memset(ced, 0, sizeof(*ced));
-
 	ced->name = name;
 	ced->features = CLOCK_EVT_FEAT_PERIODIC;
 	ced->rating = rating;
@@ -279,7 +277,6 @@ static int sh_mtu2_setup_channel(struct sh_mtu2_channel *ch,
 {
 	struct sh_timer_config *cfg = mtu->pdev->dev.platform_data;
 
-	memset(ch, 0, sizeof(*ch));
 	ch->mtu = mtu;
 	ch->index = cfg->timer_bit;
 
@@ -302,7 +299,6 @@ static int sh_mtu2_setup(struct sh_mtu2_device *mtu,
 	int ret;
 	ret = -ENXIO;
 
-	memset(mtu, 0, sizeof(*mtu));
 	mtu->pdev = pdev;
 
 	if (!cfg) {
@@ -373,7 +369,7 @@ static int sh_mtu2_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	mtu = kmalloc(sizeof(*mtu), GFP_KERNEL);
+	mtu = kzalloc(sizeof(*mtu), GFP_KERNEL);
 	if (mtu = NULL) {
 		dev_err(&pdev->dev, "failed to allocate driver data\n");
 		return -ENOMEM;
-- 
1.8.3.2

