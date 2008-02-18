From: Roel Kluin <12o3l@tiscali.nl>
Date: Mon, 18 Feb 2008 13:09:10 +0000
Subject: [PATCH] arch/sh/drivers/heartbeat.c ioremap is expected to succeed
Message-Id: <47B98376.5040906@tiscali.nl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org
Cc: lkml <linux-kernel@vger.kernel.org>

!unlikely(hd->base) is equivalent to likely(!hd->base) (for instance see
comments with commit fd312561adcc90e924f35d3032d5493aeb4c3017), I think
the ioremap is expected to succeed? please confirm that's right.
The patch below was *not* tested.
---
ioremap is expected to succeed

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/sh/drivers/heartbeat.c b/arch/sh/drivers/heartbeat.c
index b76a14f..ab77b0e 100644
--- a/arch/sh/drivers/heartbeat.c
+++ b/arch/sh/drivers/heartbeat.c
@@ -93,7 +93,7 @@ static int heartbeat_drv_probe(struct platform_device *pdev)
 	}
 
 	hd->base = ioremap_nocache(res->start, res->end - res->start + 1);
-	if (!unlikely(hd->base)) {
+	if (unlikely(!hd->base)) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 
 		if (!pdev->dev.platform_data)
