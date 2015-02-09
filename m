From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 09 Feb 2015 08:16:11 +0000
Subject: [PATCH 1/4] usb: renesas_usbhs: fix spinlock recursion by usbhsf_dma_complete()
Message-Id: <1423469774-6532-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423469774-6532-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1423469774-6532-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org, balbi@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

The usbhsf_pkt_handler(pipe, USBHSF_PKT_DMA_DONE) in usbhsf_dma_complete()
will call the complete function of a usb gadget driver finally.
According to the gadget.h, "The function will always be called with
interrupts disabled".

So, this patch adds a local_irq_save/local_irq_restore in the
usbhsf_dma_complete() because a dmaengine driver may call this
callback function when interrupts enabled (e.g. in tasklet).

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/fifo.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index d891bff..b1440d0 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -1165,11 +1165,14 @@ static void usbhsf_dma_complete(void *arg)
 	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
 	struct device *dev = usbhs_priv_to_dev(priv);
 	int ret;
+	unsigned long flags;
 
+	local_irq_save(flags);
 	ret = usbhsf_pkt_handler(pipe, USBHSF_PKT_DMA_DONE);
 	if (ret < 0)
 		dev_err(dev, "dma_complete run_error %d : %d\n",
 			usbhs_pipe_number(pipe), ret);
+	local_irq_restore(flags);
 }
 
 void usbhs_fifo_clear_dcp(struct usbhs_pipe *pipe)
-- 
1.7.9.5

