From: Greg KH <greg@kroah.com>
Date: Tue, 03 Dec 2013 18:40:02 +0000
Subject: Re: [PATCH 2/2] usb: hcd: Initialize USB phy if needed
Message-Id: <20131203184002.GA23280@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385505929-30926-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1385505929-30926-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 27, 2013 at 02:45:29AM +0400, Valentine Barshak wrote:
> This adds external USB phy support to USB HCD driver that
> allows to find and initialize external USB phy, bound to
> the HCD, when the HCD is added.
> The usb_add_hcd function returns -EPROBE_DEFER if the USB
> phy, bound to the HCD, is not ready.
> If no USB phy is bound, the HCD is initialized as usual.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> ---
>  drivers/usb/core/hcd.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 7527c8e..649506b 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2589,6 +2589,26 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  	int retval;
>  	struct usb_device *rhdev;
>  
> +#ifdef CONFIG_USB_PHY
> +	if (!hcd->phy) {

Please no #ifdef.
