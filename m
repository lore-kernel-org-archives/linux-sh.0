From: Mathias Nyman <mathias.nyman@intel.com>
Date: Tue, 26 May 2015 11:44:31 +0000
Subject: Re: [PATCH v2 RFT] usb: xhci: Add to check CRR bit in xhci_suspend()
Message-Id: <55645C9F.4010207@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1431596357-4460-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1431596357-4460-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 14.05.2015 12:39, Yoshihiro Shimoda wrote:
> The STS_HALT is not set until the CRR (CMD_RING_RUNNING) is cleared
> on specific xHCI controllers (e.g. R-Car SoCs) after this driver set
> the R/S (CMD_RUN) to 0. So, to avoid using a quirks XHCI_SLOW_SUSPEND,
> this patch adds to wait for the CRR to clear.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  My environment (R-Car H2) could work correctly. I would like to know
>  that this patch causes side effect or not. Also I'd like to know
>  this patch can avoid the XHCI_SLOW_SUSPEND quirk on other environment
>  (Fresco Logic XHCI controller).
> 
>  Changes from v1:
>   - Remove a abort code.
>   - Wait for the CRR to clear after this driver set the R/S to 0.
>   - Rebase on the usb.git / usb-next branch.
>     (commit id = aa519be34f45954f33a6c20430deac8e544a180f)
> 
>  drivers/usb/host/xhci.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index ec8ac16..a357917 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -923,6 +923,15 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
>  	command &= ~CMD_RUN;
>  	writel(command, &xhci->op_regs->command);
>  
> +	/*
> +	 * The STS_HALT is not set until the CRR is cleared on specific
> +	 * xHCI controllers (e.g. R-Car SoCs) after this driver set the R/S
> +	 * to 0. So, to avoid using a quirks XHCI_SLOW_SUSPEND, this driver
> +	 * waits for the CRR to clear.
> +	 */
> +	xhci_handshake(&xhci->op_regs->cmd_ring, CMD_RING_RUNNING, 0,
> +		       5 * 1000 * 1000);
> +
>  	/* Some chips from Fresco Logic need an extraordinary delay */
>  	delay *= (xhci->quirks & XHCI_SLOW_SUSPEND) ? 10 : 1;
>  
> 

Hi, sorry about the delay.

Does polling for the command ring running bit really help?
We are anyway polling for the HCHalted (STS_HALT) status bit right after this,
and it should indicate the command ring was halted as well.

Is it possible that the R-Car xhci host controller halts just a tiny bit slower
than the default delay value, and the additional CRR check gives it
just enough time to HALT before timeout?

Any chance you could compare the actual halt time using your patch against 
the XHCI_SLOW_SUSPEND quirk?  (time from clearing CMD_RUN until STS_HALT is set)

-Mathias
