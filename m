From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 09 Feb 2011 07:46:47 +0000
Subject: [PATCH v2] dma: shdma: add checking the DMAOR_AE in sh_dmae_err
Message-Id: <4D524667.3040306@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The irq numbers of tranfer end and address error are assigned same number
on some CPU. So the sh_dmae_err() should check the AE flag in DMAOR.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 about v2:
  - remove unnecessary cast

 drivers/dma/shdma.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 28720d3..3e4c627 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -865,7 +865,12 @@ static unsigned int sh_dmae_reset(struct sh_dmae_device *shdev)

 static irqreturn_t sh_dmae_err(int irq, void *data)
 {
-	return IRQ_RETVAL(sh_dmae_reset(data));
+	struct sh_dmae_device *shdev = data;
+
+	if (dmaor_read(shdev) & DMAOR_AE)
+		return IRQ_RETVAL(sh_dmae_reset(data));
+	else
+		return IRQ_NONE;
 }

 static void dmae_do_tasklet(unsigned long data)
-- 
1.7.1
