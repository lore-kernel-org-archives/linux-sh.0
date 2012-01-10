From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 10 Jan 2012 05:20:28 +0000
Subject: [PATCH v2 2/3] dmaengine: shdma: use sh_dmae_writel/readl in
Message-Id: <4F0BCA9C.2010004@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 about v2
  - No change

 drivers/dma/shdma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 4fff02b..ccc3028 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -92,14 +92,14 @@ static void chcr_write(struct sh_dmae_chan *sh_dc, u32 data)
 {
 	struct sh_dmae_device *shdev = to_sh_dev(sh_dc);

-	__raw_writel(data, sh_dc->base + shdev->chcr_offset / sizeof(u32));
+	sh_dmae_writel(sh_dc, data, shdev->chcr_offset);
 }

 static u32 chcr_read(struct sh_dmae_chan *sh_dc)
 {
 	struct sh_dmae_device *shdev = to_sh_dev(sh_dc);

-	return __raw_readl(sh_dc->base + shdev->chcr_offset / sizeof(u32));
+	return sh_dmae_readl(sh_dc, shdev->chcr_offset);
 }

 /*
-- 
1.7.1
