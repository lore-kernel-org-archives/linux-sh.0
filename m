From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 02 Jul 2013 15:37:58 +0000
Subject: [PATCH] DMA: shdma: fix CHCLR register address calculation
Message-Id: <Pine.LNX.4.64.1307021733280.1965@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

struct sh_dmae_device::chan_reg is a pointer to u32, therefore when adding
offsets to it care should be taken to add offsets in sizeof(u32) units, not
in bytes. This patch corrects such a bug. While at it we also remove the
redundant parameter of the affected function.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

This is a theoretical fix, I don't have a test-case for it, but the 
original calculation does seem to be buggy to me. Reviews and tests are 
welcome.

 drivers/dma/sh/shdma.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/shdma.c b/drivers/dma/sh/shdma.c
index 98b2693..c7950be 100644
--- a/drivers/dma/sh/shdma.c
+++ b/drivers/dma/sh/shdma.c
@@ -51,12 +51,12 @@
 static DEFINE_SPINLOCK(sh_dmae_lock);
 static LIST_HEAD(sh_dmae_devices);
 
-static void chclr_write(struct sh_dmae_chan *sh_dc, u32 data)
+static void channel_clear(struct sh_dmae_chan *sh_dc)
 {
 	struct sh_dmae_device *shdev = to_sh_dev(sh_dc);
 
-	__raw_writel(data, shdev->chan_reg +
-		     shdev->pdata->channel[sh_dc->shdma_chan.id].chclr_offset);
+	__raw_writel(0, shdev->chan_reg +
+		shdev->pdata->channel[sh_dc->shdma_chan.id].chclr_offset / sizeof(u32));
 }
 
 static void sh_dmae_writel(struct sh_dmae_chan *sh_dc, u32 data, u32 reg)
@@ -135,7 +135,7 @@ static int sh_dmae_rst(struct sh_dmae_device *shdev)
 		for (i = 0; i < shdev->pdata->channel_num; i++) {
 			struct sh_dmae_chan *sh_chan = shdev->chan[i];
 			if (sh_chan)
-				chclr_write(sh_chan, 0);
+				channel_clear(sh_chan);
 		}
 	}
 
-- 
1.7.2.5

