From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 Oct 2010 07:36:38 +0000
Subject: [PATCH] ARM: shmobile: remove sh_timer_config clk member
Message-Id: <20101013073638.19764.20402.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Now when the SH-Mobile ARM platforms have been converted
to use device name it is possible to remove "clk" from
struct sh_timer_config.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies on top of the following outstanding CMT patches:
 "[PATCH] clocksource: sh_cmt: One-off clockevent fix V2"
 "[PATCH] clocksource: sh_cmt: Rate calculation fix"

 drivers/clocksource/sh_cmt.c  |   10 +++-------
 drivers/clocksource/sh_mtu2.c |   10 +++-------
 drivers/clocksource/sh_tmu.c  |   10 +++-------
 include/linux/sh_timer.h      |    1 -
 4 files changed, 9 insertions(+), 22 deletions(-)

--- 0007/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2010-10-13 15:51:52.000000000 +0900
@@ -616,13 +616,9 @@ static int sh_cmt_setup(struct sh_cmt_pr
 	/* get hold of clock */
 	p->clk = clk_get(&p->pdev->dev, "cmt_fck");
 	if (IS_ERR(p->clk)) {
-		dev_warn(&p->pdev->dev, "using deprecated clock lookup\n");
-		p->clk = clk_get(&p->pdev->dev, cfg->clk);
-		if (IS_ERR(p->clk)) {
-			dev_err(&p->pdev->dev, "cannot get clock\n");
-			ret = PTR_ERR(p->clk);
-			goto err1;
-		}
+		dev_err(&p->pdev->dev, "cannot get clock\n");
+		ret = PTR_ERR(p->clk);
+		goto err1;
 	}
 
 	if (resource_size(res) = 6) {
--- 0001/drivers/clocksource/sh_mtu2.c
+++ work/drivers/clocksource/sh_mtu2.c	2010-10-13 15:52:20.000000000 +0900
@@ -287,13 +287,9 @@ static int sh_mtu2_setup(struct sh_mtu2_
 	/* get hold of clock */
 	p->clk = clk_get(&p->pdev->dev, "mtu2_fck");
 	if (IS_ERR(p->clk)) {
-		dev_warn(&p->pdev->dev, "using deprecated clock lookup\n");
-		p->clk = clk_get(&p->pdev->dev, cfg->clk);
-		if (IS_ERR(p->clk)) {
-			dev_err(&p->pdev->dev, "cannot get clock\n");
-			ret = PTR_ERR(p->clk);
-			goto err1;
-		}
+		dev_err(&p->pdev->dev, "cannot get clock\n");
+		ret = PTR_ERR(p->clk);
+		goto err1;
 	}
 
 	return sh_mtu2_register(p, (char *)dev_name(&p->pdev->dev),
--- 0001/drivers/clocksource/sh_tmu.c
+++ work/drivers/clocksource/sh_tmu.c	2010-10-13 15:52:09.000000000 +0900
@@ -393,13 +393,9 @@ static int sh_tmu_setup(struct sh_tmu_pr
 	/* get hold of clock */
 	p->clk = clk_get(&p->pdev->dev, "tmu_fck");
 	if (IS_ERR(p->clk)) {
-		dev_warn(&p->pdev->dev, "using deprecated clock lookup\n");
-		p->clk = clk_get(&p->pdev->dev, cfg->clk);
-		if (IS_ERR(p->clk)) {
-			dev_err(&p->pdev->dev, "cannot get clock\n");
-			ret = PTR_ERR(p->clk);
-			goto err1;
-		}
+		dev_err(&p->pdev->dev, "cannot get clock\n");
+		ret = PTR_ERR(p->clk);
+		goto err1;
 	}
 
 	return sh_tmu_register(p, (char *)dev_name(&p->pdev->dev),
--- 0001/include/linux/sh_timer.h
+++ work/include/linux/sh_timer.h	2010-10-13 15:49:08.000000000 +0900
@@ -5,7 +5,6 @@ struct sh_timer_config {
 	char *name;
 	long channel_offset;
 	int timer_bit;
-	char *clk;
 	unsigned long clockevent_rating;
 	unsigned long clocksource_rating;
 };
