From: Greg KH <gregkh@linuxfoundation.org>
Date: Sat, 17 Oct 2015 06:37:31 +0000
Subject: Re: [PATCH v2 1/6] usb: host: xhci: add a platform-private pointer field
Message-Id: <20151017063731.GA13889@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444217938-4668-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1444217938-4668-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 07, 2015 at 08:38:53PM +0900, Yoshihiro Shimoda wrote:
> This patch adds an xhci->priv field for storing the of_device_id.data
> pointer. This will simplify the code to match platform specific
> variables (e.g. platform type and firmware name).
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/usb/host/xhci.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 51093df..da227ba 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1653,6 +1653,9 @@ struct xhci_hcd {
>  	u32			port_status_u0;
>  /* Compliance Mode Timer Triggered every 2 seconds */
>  #define COMP_MODE_RCVRY_MSECS 2000
> +
> +	/* Store of_device_id.data pointer as xhci-plat private data */
> +	const void		*priv;
>  };

Why can't we do what we do with the other *_hcd structures and pad out
the end of the structure as needed with the following:
	/* platform-specific data -- must come last */
	unsigned long           priv[0] __aligned(sizeof(s64));

and then ask for the requested amount of space depending on the platform
being used?

thanks,

greg k-h
