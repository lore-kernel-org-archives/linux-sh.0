From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 28 Apr 2015 01:33:36 +0000
Subject: RE: [PATCH] [RFC] usb: xhci: Add to check CRR bit in xhci_suspend()
Message-Id: <SG2PR06MB0919E3D8692FC6F18F1BC2A5D8E80@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430124956-7960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1430124956-7960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

Thank you for the comments!

> Sent: Monday, April 27, 2015 10:15 PM
> 
> On 27.04.2015 11:55, Yoshihiro Shimoda wrote:
> Hi
> 
> > According to the xHCI spec "4.23.2 xHCI Power Management", the CRR bit
> > of CRCR register should be zero before setting Run/Stop (R/S) = '0'.
> > Otherwise, the STS_HALT is not set until the CRR is cleared on specific
> > xHCI controllers. In case of R-Car SoCs, it spent about 90 ms to clear
> > the CRR. So, to avoid the quirks XHCI_SLOW_SUSPEND, the driver calls
> > the aborting function if the CRR is set to 1.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/usb/host/xhci-ring.c |  2 +-
> >  drivers/usb/host/xhci.c      | 21 ++++++++++++++++++++-
> >  drivers/usb/host/xhci.h      |  1 +
> >  3 files changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> > index f5397a5..21f3932 100644
> > --- a/drivers/usb/host/xhci-ring.c
> > +++ b/drivers/usb/host/xhci-ring.c
< snip >
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index ec8ac16..d2d81a0 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -892,7 +892,7 @@ static void xhci_disable_port_wake_on_bits(struct xhci_hcd *xhci)
> >   */
> >  int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
> >  {
> > -	int			rc = 0;
> > +	int			rc = 0, ret;
> >  	unsigned int		delay = XHCI_MAX_HALT_USEC;
> >  	struct usb_hcd		*hcd = xhci_to_hcd(xhci);
> >  	u32			command;
> > @@ -918,6 +918,25 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
> >  	/* step 1: stop endpoint */
> >  	/* skipped assuming that port suspend has done */
> >
> > +	/*
> > +	 * According to the xHCI spec "4.23.2 xHCI Power Management", the CRR
> > +	 * bit of CRCR register should be zero before setting Run/Stop (R/S) > > +	 * '0', the driver calls the aborting function if the CRR is set to 1.
> > +	 */
> > +	if (xhci_read_64(xhci, &xhci->op_regs->cmd_ring) & CMD_RING_RUNNING) {
> > +		/* unlock here because this may wait about 5 seconds */
> > +		spin_unlock_irq(&xhci->lock);
> > +		ret = xhci_abort_cmd_ring(xhci);
> 
> Would it work for R-Car if we instead of unlocking and and aborting the command just wait for
> the CRR bit to turn 0 before setting Run/stop = 0?

Unfortunately, it didn't work correctly. However, after setting Run/stop = 0, it worked correctly.
(According to the Table 36 of xHCI spec, the CRR bit will be cleared if the R/S but us cleared to 0.)

> Aborting the command ring by setting CA bit in CRCR will generate a command abort/stop completion event,
> which will point to the stopped/aborted event on the command ring. We are however clearing the command
> ring completely in xhci_suspend() right after this, and setting the dequeue pointer to the beginning of
> the ring. This will likely mess with the handling of the abort/stop event.

Thank you for the comment. I understood that this driver should not call aborting function here.

> Waiting for the CRR to clear could be done using:
> xhci_handshake(&xhci->op_regs->cmd_ring, CMD_RING_RUNNING, timeout)

Thank you for the suggestion.

As I tested above, after I applied the following patch, R-Car SoCs environment worked correctly.
However, I don't know that it is a reasonable solution for all xHCI controllers.
Should I add a new quirks? Or, should it use a XHCI_SLOW_SUSPEND instead of the below patch?
(If R-Car SoCs with XHCI_SLOW_SUSPEND, it also worked correctly.)

======================================
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -923,6 +923,15 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
 	command &= ~CMD_RUN;
 	writel(command, &xhci->op_regs->command);
 
+	/*
+	 * The STS_HALT is not set until the CRR is cleared on specific
+	 * xHCI controllers (e.g. R-Car SoCs) after this driver set the R/S
+	 * to 0. So, to avoid using a quirks XHCI_SLOW_SUSPEND, this driver
+	 * waits for the CRR to clear using xhci_handshake().
+	 */
+	xhci_handshake(&xhci->op_regs->cmd_ring, CMD_RING_RUNNING, 0,
+		       5 * 1000 * 1000);
+
 	/* Some chips from Fresco Logic need an extraordinary delay */
 	delay *= (xhci->quirks & XHCI_SLOW_SUSPEND) ? 10 : 1;
======================================

Best regards,
Yoshihiro Shimoda

> -Mathias

