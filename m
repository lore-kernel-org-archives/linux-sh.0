From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 14 Feb 2013 12:23:47 +0000
Subject: [PATCH] sh-pfc: sh_pfc_probe() sizeof() fix
Message-Id: <20130214122347.20778.10789.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fix sizeof() usage in sh-pfc/core.c to allocate space
for the full data structure instead of a pointer.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against -next in renesas.git

 drivers/pinctrl/sh-pfc/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/pinctrl/sh-pfc/core.c
+++ work/drivers/pinctrl/sh-pfc/core.c	2013-02-14 21:04:20.000000000 +0900
@@ -495,7 +495,7 @@ static int sh_pfc_probe(struct platform_
 	if (info = NULL)
 		return -ENODEV;
 
-	pfc = devm_kzalloc(&pdev->dev, sizeof(pfc), GFP_KERNEL);
+	pfc = devm_kzalloc(&pdev->dev, sizeof(*pfc), GFP_KERNEL);
 	if (pfc = NULL)
 		return -ENOMEM;
 
