From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 21 Mar 2008 11:14:46 +0000
Subject: [PATCH] Fix sh_keysc double free
Message-Id: <20080321111446.13134.8863.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-input@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, dmitry.torokhov@gmail.com, akpm@linux-foundation.org, linux-sh@vger.kernel.org

Avoid double free situation from happening by removing input_free_device() 
after input_unregister_device(). Suggested by Dmitry Torokhov.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/input/keyboard/sh_keysc.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/drivers/input/keyboard/sh_keysc.c
+++ work/drivers/input/keyboard/sh_keysc.c	2008-03-21 10:58:20.000000000 +0900
@@ -238,7 +238,6 @@ static int __devexit sh_keysc_remove(str
 
 	input_unregister_device(priv->input);
 	free_irq(platform_get_irq(pdev, 0), pdev);
-	input_free_device(priv->input);
 	iounmap(priv->iomem_base);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
