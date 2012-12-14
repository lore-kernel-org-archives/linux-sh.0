From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 14 Dec 2012 05:53:51 +0000
Subject: [PATCH 03/08] clocksource: sh_cmt: Consolidate platform_set_drvdata() call
Message-Id: <20121214055351.10081.82218.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20121214055323.10081.12056.sendpatchset@w520>
In-Reply-To: <20121214055323.10081.12056.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, johnstul@us.ibm.com, horms@verge.net.au, shinya.kuribayashi.px@renesas.com, tglx@linutronix.de, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@opensource.se>

Cleanup the use of platform_set_drvdata() to reduce code size

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/clocksource/sh_cmt.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- 0003/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2012-12-14 12:54:59.000000000 +0900
@@ -649,8 +649,6 @@ static int sh_cmt_setup(struct sh_cmt_pr
 		goto err0;
 	}
 
-	platform_set_drvdata(pdev, p);
-
 	res = platform_get_resource(p->pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&p->pdev->dev, "failed to get I/O memory\n");
@@ -718,6 +716,8 @@ static int sh_cmt_setup(struct sh_cmt_pr
 		goto err2;
 	}
 
+	platform_set_drvdata(pdev, p);
+
 	return 0;
 err2:
 	clk_put(p->clk);
@@ -753,7 +753,6 @@ static int __devinit sh_cmt_probe(struct
 	ret = sh_cmt_setup(p, pdev);
 	if (ret) {
 		kfree(p);
-		platform_set_drvdata(pdev, NULL);
 		pm_runtime_idle(&pdev->dev);
 		return ret;
 	}
