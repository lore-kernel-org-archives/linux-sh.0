From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 03 Apr 2015 11:20:15 +0000
Subject: [PATCH] dmaengine: usb-dmac: Fix dereferencing freed memory 'desc'
Message-Id: <1428060015-2896-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes an issue that the usb_dmac_desc_free() is
dereferencing freed memory 'desc' because it uses list_for_each_entry().
This function should use list_for_each_entry_safe().

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 This patch is based on slave-dma / for-linus branch.
 (commit id = f3070e7efdc37a84fa63cbe84ac4febc87440121)

 drivers/dma/sh/usb-dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index d5dad98..f705798 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -285,13 +285,13 @@ static int usb_dmac_desc_alloc(struct usb_dmac_chan *chan, unsigned int sg_len,
 
 static void usb_dmac_desc_free(struct usb_dmac_chan *chan)
 {
-	struct usb_dmac_desc *desc;
+	struct usb_dmac_desc *desc, *_desc;
 	LIST_HEAD(list);
 
 	list_splice_init(&chan->desc_freed, &list);
 	list_splice_init(&chan->desc_got, &list);
 
-	list_for_each_entry(desc, &list, node) {
+	list_for_each_entry_safe(desc, _desc, &list, node) {
 		list_del(&desc->node);
 		kfree(desc);
 	}
-- 
1.9.1

