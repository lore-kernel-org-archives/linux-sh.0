From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 12 Nov 2015 04:37:40 +0000
Subject: [PATCH] dmaengine: usb-dmac: fix endless loop in usb_dmac_chan_terminate_all()
Message-Id: <1447303060-7880-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes an issue that list_for_each_entry() in
usb_dmac_chan_terminate_all() is possible to cause endless loop because
this will move own desc to the desc_freed. So, this driver should use
list_for_each_entry_safe() instead of list_for_each_entry().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/dma/sh/usb-dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index ebd8a5f..16fb330 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -448,7 +448,7 @@ usb_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 static int usb_dmac_chan_terminate_all(struct dma_chan *chan)
 {
 	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
-	struct usb_dmac_desc *desc;
+	struct usb_dmac_desc *desc, *_desc;
 	unsigned long flags;
 	LIST_HEAD(head);
 	LIST_HEAD(list);
@@ -459,7 +459,7 @@ static int usb_dmac_chan_terminate_all(struct dma_chan *chan)
 	if (uchan->desc)
 		uchan->desc = NULL;
 	list_splice_init(&uchan->desc_got, &list);
-	list_for_each_entry(desc, &list, node)
+	list_for_each_entry_safe(desc, _desc, &list, node)
 		list_move_tail(&desc->node, &uchan->desc_freed);
 	spin_unlock_irqrestore(&uchan->vc.lock, flags);
 	vchan_dma_desc_free_list(&uchan->vc, &head);
-- 
1.9.1

