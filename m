From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 26 Apr 2015 09:53:54 +0000
Subject: [PATCH] dmaengine: usb-dmac: Protect PM-only functions to kill warning
Message-Id: <1430042034-30780-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

If CONFIG_PM=n:

    drivers/dma/sh/usb-dmac.c:677: warning: ‘usb_dmac_runtime_suspend’ defined but not used
    drivers/dma/sh/usb-dmac.c:688: warning: ‘usb_dmac_runtime_resume’ defined but not used

Protect the unused functions by #ifdef CONFIG_PM to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/dma/sh/usb-dmac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index f705798ce3eb1129..ebd8a5f398b08ee2 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -673,6 +673,7 @@ static struct dma_chan *usb_dmac_of_xlate(struct of_phandle_args *dma_spec,
  * Power management
  */
 
+#ifdef CONFIG_PM
 static int usb_dmac_runtime_suspend(struct device *dev)
 {
 	struct usb_dmac *dmac = dev_get_drvdata(dev);
@@ -690,6 +691,7 @@ static int usb_dmac_runtime_resume(struct device *dev)
 
 	return usb_dmac_init(dmac);
 }
+#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops usb_dmac_pm = {
 	SET_RUNTIME_PM_OPS(usb_dmac_runtime_suspend, usb_dmac_runtime_resume,
-- 
1.9.1

