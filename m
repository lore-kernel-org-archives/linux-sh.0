From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 02 May 2012 09:41:41 +0000
Subject: [PATCH v3 01/10] mtd: sh_flctl: Add missing iounmap()
Message-Id: <1335951710-9390-2-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1335951710-9390-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1335951710-9390-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
Cc: Brian Norris <computersforpeace@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>, Artem Bityutskiy <dedekind1@gmail.com>

Add the unmapping for the error case and for the driver removal.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/mtd/nand/sh_flctl.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 2ee9a1b..ed86a64 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -919,6 +919,7 @@ static int __devinit flctl_probe(struct platform_device *pdev)
 
 err_chip:
 	pm_runtime_disable(&pdev->dev);
+	iounmap(flctl->reg);
 err_iomap:
 	kfree(flctl);
 	return ret;
@@ -930,6 +931,7 @@ static int __devexit flctl_remove(struct platform_device *pdev)
 
 	nand_release(&flctl->mtd);
 	pm_runtime_disable(&pdev->dev);
+	iounmap(flctl->reg);
 	kfree(flctl);
 
 	return 0;
-- 
1.7.5.4

