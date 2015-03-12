From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 12 Mar 2015 06:35:19 +0000
Subject: [PATCH v3 2/3] usb: renesas_usbhs: fix the sequence in xfer_work()
Message-Id: <1426142120-5072-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426142120-5072-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1426142120-5072-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org, balbi@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch fixes the setup sequence in xfer_work(). Otherwise,
sometimes a usb transaction will get stuck.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/fifo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index 28d10eb..b737661 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -822,10 +822,10 @@ static void xfer_work(struct work_struct *work)
 		fifo->name, usbhs_pipe_number(pipe), pkt->length, pkt->zero);
 
 	usbhs_pipe_running(pipe, 1);
-	usbhs_pipe_set_trans_count_if_bulk(pipe, pkt->trans);
-	usbhs_pipe_enable(pipe);
 	usbhsf_dma_start(pipe, fifo);
+	usbhs_pipe_set_trans_count_if_bulk(pipe, pkt->trans);
 	dma_async_issue_pending(chan);
+	usbhs_pipe_enable(pipe);
 }
 
 /*
-- 
1.9.1

