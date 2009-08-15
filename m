From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 15 Aug 2009 02:53:25 +0000
Subject: [PATCH 02/04] sh: CMT suspend/resume
Message-Id: <20090815025325.8125.34501.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch updates the SuperH CMT driver with suspend and resume
callbacks for the suspend-to-ram case. This patch stops the CMT
channel at suspend time to avoid unwanted wake up events.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/clocksource/sh_cmt.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

--- 0001/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2009-08-13 13:37:21.000000000 +0900
@@ -40,6 +40,7 @@ struct sh_cmt_priv {
 	struct platform_device *pdev;
 
 	unsigned long flags;
+	unsigned long flags_suspend;
 	unsigned long match_value;
 	unsigned long next_match_value;
 	unsigned long max_match_value;
@@ -667,11 +668,38 @@ static int __devexit sh_cmt_remove(struc
 	return -EBUSY; /* cannot unregister clockevent and clocksource */
 }
 
+static int sh_cmt_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sh_cmt_priv *p = platform_get_drvdata(pdev);
+
+	/* save flag state and stop CMT channel */
+	p->flags_suspend = p->flags;
+	sh_cmt_stop(p, p->flags);
+	return 0;
+}
+
+static int sh_cmt_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sh_cmt_priv *p = platform_get_drvdata(pdev);
+
+	/* start CMT channel from saved state */
+	sh_cmt_start(p, p->flags_suspend);
+	return 0;
+}
+
+static struct dev_pm_ops sh_cmt_dev_pm_ops = {
+	.suspend = sh_cmt_suspend,
+	.resume = sh_cmt_resume,
+};
+
 static struct platform_driver sh_cmt_device_driver = {
 	.probe		= sh_cmt_probe,
 	.remove		= __devexit_p(sh_cmt_remove),
 	.driver		= {
 		.name	= "sh_cmt",
+		.pm	= &sh_cmt_dev_pm_ops,
 	}
 };
 
