From: Alan Stern <stern@rowland.harvard.edu>
Date: Fri, 05 Apr 2013 14:43:16 +0000
Subject: Re: [PATCH 2/8] ehci-platform: add init() method to platform data
Message-Id: <Pine.LNX.4.44L0.1304051038570.1334-100000@iolanthe.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201304050259.51025.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304050259.51025.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 5 Apr 2013, Sergei Shtylyov wrote:

> Sometimes there is a need to initialize some non-standard registers mapped to
> the EHCI region before accessing the standard EHCI registers.  Add the init()
> method to the 'ehci-platform' platform data for this purpose.

"init" isn't such a good name for this.  It's too vague; there are
already a lot of initialization steps here.  How about "pre_setup"
instead?

> --- renesas.orig/drivers/usb/host/ehci-platform.c
> +++ renesas/drivers/usb/host/ehci-platform.c
> @@ -110,6 +110,13 @@ static int ehci_platform_probe(struct pl
>  		err = PTR_ERR(hcd->regs);
>  		goto err_put_hcd;
>  	}
> +
> +	if (pdata->init) {
> +		err = pdata->init(dev, hcd->regs);
> +		if (err < 0)
> +			goto err_put_hcd;
> +	}

Also, I think this code should go in the ehci_platform_reset() routine, 
just before the call to ehci_setup().  That way more of the setup will 
already have been carried out.

And instead of passing hcd->regs, wouldn't it be better to pass hcd?  
Other users of this interface might need to initialize something other 
than a non-standard register.

Alan Stern

