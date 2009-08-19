From: Alan Stern <stern@rowland.harvard.edu>
Date: Wed, 19 Aug 2009 14:44:01 +0000
Subject: Re: [PATCH] usb: add support R8A66597 peripheral controller driver
Message-Id: <Pine.LNX.4.44L0.0908191042130.3001-100000@iolanthe.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4A8B86BB.1020605@renesas.com>
In-Reply-To: <4A8B86BB.1020605@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 19 Aug 2009, Yoshihiro Shimoda wrote:

> The R8A66597 is Renesas USB 2.0 host and peripheral controller.
> This controller supports USB High-speed. This driver supports
> peripheral side.

> +static struct usb_ep_ops r8a66597_ep_ops = {
> +	.enable		= r8a66597_enable,
> +	.disable	= r8a66597_disable,
> +
> +	.alloc_request	= r8a66597_alloc_request,
> +	.free_request	= r8a66597_free_request,
> +
> +	.queue		= r8a66597_queue,
> +	.dequeue	= r8a66597_dequeue,
> +
> +	.set_halt	= r8a66597_set_halt,
> +	.fifo_flush	= r8a66597_fifo_flush,
> +};

All new peripheral controller drivers should implement the set_wedge 
method.

Alan Stern

