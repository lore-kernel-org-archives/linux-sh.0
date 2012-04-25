From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 25 Apr 2012 14:03:29 +0000
Subject: [PATCH v2 01/10] mtd: sh_flctl: Add missing iounmap()
Message-Id: <1335362618-4559-2-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1335362618-4559-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1335362618-4559-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
Cc: Brian Norris <computersforpeace@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>

Add the unmapping for the error case and for the driver removal.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
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

