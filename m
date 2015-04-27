From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 27 Apr 2015 08:55:56 +0000
Subject: [PATCH] [RFC] usb: xhci: Add to check CRR bit in xhci_suspend()
Message-Id: <1430124956-7960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to the xHCI spec "4.23.2 xHCI Power Management", the CRR bit
of CRCR register should be zero before setting Run/Stop (R/S) = '0'.
Otherwise, the STS_HALT is not set until the CRR is cleared on specific
xHCI controllers. In case of R-Car SoCs, it spent about 90 ms to clear
the CRR. So, to avoid the quirks XHCI_SLOW_SUSPEND, the driver calls
the aborting function if the CRR is set to 1.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/host/xhci-ring.c |  2 +-
 drivers/usb/host/xhci.c      | 21 ++++++++++++++++++++-
 drivers/usb/host/xhci.h      |  1 +
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index f5397a5..21f3932 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -280,7 +280,7 @@ void xhci_ring_cmd_db(struct xhci_hcd *xhci)
 	readl(&xhci->dba->doorbell[0]);
 }
 
-static int xhci_abort_cmd_ring(struct xhci_hcd *xhci)
+int xhci_abort_cmd_ring(struct xhci_hcd *xhci)
 {
 	u64 temp_64;
 	int ret;
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index ec8ac16..d2d81a0 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -892,7 +892,7 @@ static void xhci_disable_port_wake_on_bits(struct xhci_hcd *xhci)
  */
 int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
 {
-	int			rc = 0;
+	int			rc = 0, ret;
 	unsigned int		delay = XHCI_MAX_HALT_USEC;
 	struct usb_hcd		*hcd = xhci_to_hcd(xhci);
 	u32			command;
@@ -918,6 +918,25 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
 	/* step 1: stop endpoint */
 	/* skipped assuming that port suspend has done */
 
+	/*
+	 * According to the xHCI spec "4.23.2 xHCI Power Management", the CRR
+	 * bit of CRCR register should be zero before setting Run/Stop (R/S) +	 * '0', the driver calls the aborting function if the CRR is set to 1.
+	 */
+	if (xhci_read_64(xhci, &xhci->op_regs->cmd_ring) & CMD_RING_RUNNING) {
+		/* unlock here because this may wait about 5 seconds */
+		spin_unlock_irq(&xhci->lock);
+		ret = xhci_abort_cmd_ring(xhci);
+		if (unlikely(ret = -ESHUTDOWN)) {
+			xhci_err(xhci, "Abort command ring failed\n");
+			xhci_cleanup_command_queue(xhci);
+			usb_hc_died(xhci_to_hcd(xhci)->primary_hcd);
+			xhci_dbg(xhci, "xHCI host controller is dead.\n");
+			return ret;
+		}
+		spin_lock_irq(&xhci->lock);
+	}
+
 	/* step 2: clear Run/Stop bit */
 	command = readl(&xhci->op_regs->command);
 	command &= ~CMD_RUN;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 8e421b8..c861bf0 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1796,6 +1796,7 @@ struct xhci_segment *trb_in_td(struct xhci_hcd *xhci,
 		union xhci_trb *end_trb, dma_addr_t suspect_dma, bool debug);
 int xhci_is_vendor_info_code(struct xhci_hcd *xhci, unsigned int trb_comp_code);
 void xhci_ring_cmd_db(struct xhci_hcd *xhci);
+int xhci_abort_cmd_ring(struct xhci_hcd *xhci);
 int xhci_queue_slot_control(struct xhci_hcd *xhci, struct xhci_command *cmd,
 		u32 trb_type, u32 slot_id);
 int xhci_queue_address_device(struct xhci_hcd *xhci, struct xhci_command *cmd,
-- 
1.9.1

