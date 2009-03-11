From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 11 Mar 2009 08:04:23 +0000
Subject: [PATCH] input: sh_keysc suspend can use to_platform_device()
Message-Id: <20090311080423.2006.22858.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-input@vger.kernel.org
Cc: soni.trilok@gmail.com, Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch changes sh_keysc to use to_platform_device()
for suspend. Thanks to Trilok Soni for this suggestion.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/input/keyboard/sh_keysc.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- 0001/drivers/input/keyboard/sh_keysc.c
+++ work/drivers/input/keyboard/sh_keysc.c	2009-03-11 13:33:14.000000000 +0900
@@ -257,13 +257,10 @@ static int __devexit sh_keysc_remove(str
 
 static int sh_keysc_suspend(struct device *dev)
 {
-	struct platform_device *pdev;
-	struct sh_keysc_priv *priv;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sh_keysc_priv *priv = platform_get_drvdata(pdev);
 	unsigned short value;
 
-	pdev = container_of(dev, struct platform_device, dev);
-	priv = platform_get_drvdata(pdev);
-
 	value = ioread16(priv->iomem_base + KYCR1_OFFS);
 
 	if (device_may_wakeup(dev))
