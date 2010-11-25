From: Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 25 Nov 2010 15:46:04 +0000
Subject: Re: [PATCH] SuperH on-chip EHCI glue
Message-Id: <Pine.LNX.4.44L0.1011251042340.22247-100000@netrider.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101125080349.GG3270@linux-sh.org>
In-Reply-To: <20101125080349.GG3270@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, 25 Nov 2010, Paul Mundt wrote:

> This is a simple patch series for adding EHCI glue for the SuperH on-chip
> controller. It's largely modelled after the ohci-sh driver with clock
> management added on top, which I plan to move out to be shared between
> the two like Octeon presently does in a future patch -- this just hasn't
> been done yet since I need to go through and audit all of the SH OHCI
> users first.
> 
> The changes themselves are sitting in a topic branch, and I've had
> Shimoda-san give them a cursory review without incident. If you don't
> have any issues with the series then you can feel free to pull the topic
> branch in to one of your trees as-is, or I can merge it via the SH tree
> (I don't have anything that depends on it, so I'm fine with whatever you
> prefer).

...

> --- /dev/null
> +++ b/drivers/usb/host/ehci-sh.c

> +static const struct hc_driver ehci_sh_hc_driver = {
> +	.description			= hcd_name,
> +	.product_desc			= "SuperH EHCI",
> +	.hcd_priv_size			= sizeof(struct ehci_hcd),
> +
> +	/*
> +	 * generic hardware linkage
> +	 */
> +	.irq				= ehci_irq,
> +	.flags				= HCD_USB2 | HCD_MEMORY,
> +
> +	/*
> +	 * basic lifecycle operations
> +	 */
> +	.reset				= ehci_sh_reset,
> +	.start				= ehci_run,
> +	.stop				= ehci_stop,
> +	.shutdown			= ehci_shutdown,
> +
> +	/*
> +	 * managing i/o requests and associated device resources
> +	 */
> +	.urb_enqueue			= ehci_urb_enqueue,
> +	.urb_dequeue			= ehci_urb_dequeue,
> +	.endpoint_disable		= ehci_endpoint_disable,
> +
> +	/*
> +	 * scheduling support
> +	 */
> +	.get_frame_number		= ehci_get_frame,
> +
> +	/*
> +	 * root hub support
> +	 */
> +	.hub_status_data		= ehci_hub_status_data,
> +	.hub_control			= ehci_hub_control,
> +
> +#ifdef CONFIG_PM
> +	.bus_suspend			= ehci_bus_suspend,
> +	.bus_resume			= ehci_bus_resume,
> +#endif
> +
> +	.relinquish_port		= ehci_relinquish_port,
> +	.port_handed_over		= ehci_port_handed_over,
> +};

You are missing the .endpoint_reset and .ehci_clear_tt_buffer_complete 
members.  This is a little surprising -- it implies the driver was 
written by copying another one that didn't have these things, meaning 
it must have been pretty old.

Alan Stern

