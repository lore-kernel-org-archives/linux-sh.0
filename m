From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 19 Jan 2015 23:07:59 +0000
Subject: [PATCH 2/2] shdmac: extend PM methods
Message-Id: <7124495.gOhk31Ctg5@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

In order to make it possible to restore from hibernation not only in Linux but
also in e.g. U-Boot, we have to use sh_dmae_{suspend|resume}() for the {freeze|
thaw|restore}() PM methods. It's handy to achieve this with SIMPLE_DEV_PM_OPS()
macro; since  that macro doesn't do anything when CONFIG_PM_SLEEP  is undefined,
we don't need to #define sh_dmae_{suspend|resume} NULL anymore; it seems safe to
leave the #ifdef CONFIG_PM alone  as this option  is selected by CONFIG_PM_SLEEP
anyway...

Based on orignal patch by Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'next' branch of Vinod Koul's 'slave-dma.git' repo.
 
 drivers/dma/sh/shdmac.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: slave-dma/drivers/dma/sh/shdmac.c
=================================--- slave-dma.orig/drivers/dma/sh/shdmac.c
+++ slave-dma/drivers/dma/sh/shdmac.c
@@ -632,14 +632,10 @@ static int sh_dmae_resume(struct device
 
 	return 0;
 }
-#else
-#define sh_dmae_suspend NULL
-#define sh_dmae_resume NULL
 #endif
 
 static const struct dev_pm_ops sh_dmae_pm = {
-	.suspend		= sh_dmae_suspend,
-	.resume			= sh_dmae_resume,
+	SET_SYSTEM_SLEEP_PM_OPS(sh_dmae_suspend, sh_dmae_resume)
 	SET_RUNTIME_PM_OPS(sh_dmae_runtime_suspend, sh_dmae_runtime_resume,
 			   NULL)
 };

