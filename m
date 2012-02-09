From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 09 Feb 2012 22:17:47 +0000
Subject: [PATCH 1/2] usb: renesas_usbhs: (cosmetic) simplify list operations
Message-Id: <Pine.LNX.4.64.1202092313560.18719@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/usb/renesas_usbhs/fifo.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index 72339bd..5d543e3 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -75,8 +75,7 @@ void usbhs_pkt_push(struct usbhs_pipe *pipe, struct usbhs_pkt *pkt,
 		pipe->handler = &usbhsf_null_handler;
 	}
 
-	list_del_init(&pkt->node);
-	list_add_tail(&pkt->node, &pipe->list);
+	list_move_tail(&pkt->node, &pipe->list);
 
 	/*
 	 * each pkt must hold own handler.
@@ -106,7 +105,7 @@ static struct usbhs_pkt *__usbhsf_pkt_get(struct usbhs_pipe *pipe)
 	if (list_empty(&pipe->list))
 		return NULL;
 
-	return list_entry(pipe->list.next, struct usbhs_pkt, node);
+	return list_first_entry(&pipe->list, struct usbhs_pkt, node);
 }
 
 struct usbhs_pkt *usbhs_pkt_pop(struct usbhs_pipe *pipe, struct usbhs_pkt *pkt)
-- 
1.7.2.5

