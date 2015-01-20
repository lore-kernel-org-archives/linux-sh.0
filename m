From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 20 Jan 2015 21:09:46 +0000
Subject: [PATCH v2 1/2] shdmac: use SET_RUNTIME_PM_OPS()
Message-Id: <9005734.b9UuUHqyUV@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Use SET_RUNTIME_PM_OPS() to initialize the runtime PM method pointers in the
'struct dev_pm_ops';  since that macro doesn't  do anything  if CONFIG_PM is
not defined, we have  to move #ifdef up to also cover the runtime PM methods
in order to avoid compilation warnings.

Based on orignal patch by Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'next' branch of Vinod Koul's 'slave-dma.git' repo.
 
 drivers/dma/sh/shdmac.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: slave-dma/drivers/dma/sh/shdmac.c
=================================--- slave-dma.orig/drivers/dma/sh/shdmac.c
+++ slave-dma/drivers/dma/sh/shdmac.c
@@ -588,6 +588,7 @@ static void sh_dmae_shutdown(struct plat
 	sh_dmae_ctl_stop(shdev);
 }
 
+#ifdef CONFIG_PM
 static int sh_dmae_runtime_suspend(struct device *dev)
 {
 	return 0;
@@ -600,7 +601,6 @@ static int sh_dmae_runtime_resume(struct
 	return sh_dmae_rst(shdev);
 }
 
-#ifdef CONFIG_PM
 static int sh_dmae_suspend(struct device *dev)
 {
 	return 0;
@@ -640,8 +640,8 @@ static int sh_dmae_resume(struct device
 static const struct dev_pm_ops sh_dmae_pm = {
 	.suspend		= sh_dmae_suspend,
 	.resume			= sh_dmae_resume,
-	.runtime_suspend	= sh_dmae_runtime_suspend,
-	.runtime_resume		= sh_dmae_runtime_resume,
+	SET_RUNTIME_PM_OPS(sh_dmae_runtime_suspend, sh_dmae_runtime_resume,
+			   NULL)
 };
 
 static dma_addr_t sh_dmae_slave_addr(struct shdma_chan *schan)
