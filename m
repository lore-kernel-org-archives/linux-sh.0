From: Mathias Nyman <mathias.nyman@linux.intel.com>
Date: Wed, 28 Oct 2015 14:31:13 +0000
Subject: Re: [PATCH v3 1/7] usb: host: xhci: fix hcd private size
Message-Id: <5630DC31.1020600@linux.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1445847155-5468-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1445847155-5468-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 26.10.2015 10:12, Yoshihiro Shimoda wrote:
> This patch fixes the hcd private size to sutabile size.
> The previous code has "sizeof(struct xhci_hcd *)" in xhci_hc_driver
> as hcd_priv_size and sizeof(struct xhci_hcd) in xhci_plat_overrides
> or xhci_pci_overrides as extra_priv_size. However, the xhci driver
> uses a "sizeof(struct xhcd_hcd)" memory space in each hcd
> (main_hcd and shared_hcd) actually.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>   drivers/usb/host/xhci-pci.c  | 1 -
>   drivers/usb/host/xhci-plat.c | 1 -
>   drivers/usb/host/xhci.c      | 2 +-
>   3 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 17f6897..b51ac63 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -53,7 +53,6 @@ static struct hc_driver __read_mostly xhci_pci_hc_driver;
>   static int xhci_pci_setup(struct usb_hcd *hcd);
>
>   static const struct xhci_driver_overrides xhci_pci_overrides __initconst = {
> -	.extra_priv_size = sizeof(struct xhci_hcd),
>   	.reset = xhci_pci_setup,
>   };
>
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 05647e6..4699c1e 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -31,7 +31,6 @@ static int xhci_plat_setup(struct usb_hcd *hcd);
>   static int xhci_plat_start(struct usb_hcd *hcd);
>
>   static const struct xhci_driver_overrides xhci_plat_overrides __initconst = {
> -	.extra_priv_size = sizeof(struct xhci_hcd),
>   	.reset = xhci_plat_setup,
>   	.start = xhci_plat_start,
>   };
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 6e7dc6f..c295785 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -4942,7 +4942,7 @@ EXPORT_SYMBOL_GPL(xhci_gen_setup);
>   static const struct hc_driver xhci_hc_driver = {
>   	.description =		"xhci-hcd",
>   	.product_desc =		"xHCI Host Controller",
> -	.hcd_priv_size =	sizeof(struct xhci_hcd *),
> +	.hcd_priv_size =	sizeof(struct xhci_hcd),
>
>   	/*
>   	 * generic hardware linkage
>

Seems that when changing from storing a xhci_hcd pointer to storing the whole xhci_hcd structure
in hcd->hcd_priv we accidentally left the extra sizeof(struct xhci_hcd *) in the .hcd_priv_size

Also setting the .hcd_priv_size = sizeof(struct xhci_hcd) when creating struct hc_driver xhci_hc_driver,
instead of in the .extra_priv_size seems like the correct way to do it.

Thanks for the fixes

-Mathias
