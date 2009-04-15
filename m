From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Apr 2009 10:50:04 +0000
Subject: [PATCH 01/05] clocksource: sh_cmt earlytimer support
Message-Id: <20090415105004.29940.25791.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add Early Platform Driver support to the sh_cmt driver
using the earlytimer class.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/clocksource/sh_cmt.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

--- 0016/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2009-01-22 17:30:35.000000000 +0900
@@ -567,9 +567,19 @@ static int sh_cmt_setup(struct sh_cmt_pr
 static int __devinit sh_cmt_probe(struct platform_device *pdev)
 {
 	struct sh_cmt_priv *p = platform_get_drvdata(pdev);
+	struct sh_cmt_config *cfg = pdev->dev.platform_data;
 	int ret;
 
-	p = kmalloc(sizeof(*p), GFP_KERNEL);
+	if (p) {
+		pr_info("sh_cmt: %s kept as earlytimer\n", cfg->name);
+		return 0;
+	}
+
+	if (is_early_platform_device(pdev))
+		p = alloc_bootmem(sizeof(*p));
+	else
+		p = kmalloc(sizeof(*p), GFP_KERNEL);
+
 	if (p = NULL) {
 		dev_err(&pdev->dev, "failed to allocate driver data\n");
 		return -ENOMEM;
@@ -577,7 +587,10 @@ static int __devinit sh_cmt_probe(struct
 
 	ret = sh_cmt_setup(p, pdev);
 	if (ret) {
-		kfree(p);
+		if (is_early_platform_device(pdev))
+			free_bootmem(__pa(p), sizeof(*p));
+		else
+			kfree(p);
 
 		platform_set_drvdata(pdev, NULL);
 	}
@@ -607,6 +620,7 @@ static void __exit sh_cmt_exit(void)
 	platform_driver_unregister(&sh_cmt_device_driver);
 }
 
+early_platform_init("earlytimer", &sh_cmt_device_driver);
 module_init(sh_cmt_init);
 module_exit(sh_cmt_exit);
 
