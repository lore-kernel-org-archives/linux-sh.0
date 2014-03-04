From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 04 Mar 2014 17:47:22 +0000
Subject: [PATCH 15/22] clocksource: sh_mtu2: Rename clock to "fck" in the non-legacy case
Message-Id: <1393955249-18736-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The sh_mtu2 driver gets the MTU2 functional clock using a connection ID
of "mtu2_fck". While all SH SoCs create clock lookup entries with a NULL
device ID and a "mtu2_fck" connection ID, the ARM SoCs use the device ID
only with a NULL connection ID. This works on legacy platforms but will
break on ARM with DT boot.

Fix the situation by using a connection ID of "fck" in the non-legacy
platform data case. Clock lookup entries will be renamed to use the
device ID as well as the connection ID as platforms get moved to new
platform data. The legacy code will eventually be dropped, leaving us
with device ID based clock lookup, compatible with DT boot.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_mtu2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 7cc6d94..3a37857 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -465,7 +465,7 @@ static int sh_mtu2_setup(struct sh_mtu2_device *mtu,
 	}
 
 	/* Get hold of clock. */
-	mtu->clk = clk_get(&mtu->pdev->dev, "mtu2_fck");
+	mtu->clk = clk_get(&mtu->pdev->dev, mtu->legacy ? "mtu2_fck" : "fck");
 	if (IS_ERR(mtu->clk)) {
 		dev_err(&mtu->pdev->dev, "cannot get clock\n");
 		return PTR_ERR(mtu->clk);
-- 
1.8.3.2

