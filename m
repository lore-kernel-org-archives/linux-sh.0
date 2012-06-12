From: Alan Stern <stern@rowland.harvard.edu>
Date: Tue, 12 Jun 2012 13:57:41 +0000
Subject: Re: [PATCH v2] usb: ehci-sh: fix illegal phy_init() running when platform_data is NULL
Message-Id: <Pine.LNX.4.44L0.1206120957271.1429-100000@iolanthe.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4FD68E99.8020009@renesas.com>
In-Reply-To: <4FD68E99.8020009@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Tue, 12 Jun 2012, Shimoda, Yoshihiro wrote:

> If the platform_data is not set, pdata will be uninitialized value.
> Since the driver has the following code, if the condition is true when
> the pdata is uninitialized value, the driver may jump to the illegal
> phy_init().
> 
> 	if (pdata && pdata->phy_init)
> 		pdata->phy_init();
> 
> This patch also fixes the following warning:
> 
>   CC      drivers/usb/host/ehci-hcd.o
> drivers/usb/host/ehci-sh.c: In function ‘ehci_hcd_sh_probe’:
> drivers/usb/host/ehci-sh.c:104: warning: ‘pdata’ may be used uninitialized in this function
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  about v2:
>   - modify the patch description about phy_init()
> 
>  drivers/usb/host/ehci-sh.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-sh.c b/drivers/usb/host/ehci-sh.c
> index ca819cd..e7cb392 100644
> --- a/drivers/usb/host/ehci-sh.c
> +++ b/drivers/usb/host/ehci-sh.c
> @@ -126,8 +126,7 @@ static int ehci_hcd_sh_probe(struct platform_device *pdev)
>  		goto fail_create_hcd;
>  	}
> 
> -	if (pdev->dev.platform_data != NULL)
> -		pdata = pdev->dev.platform_data;
> +	pdata = pdev->dev.platform_data;
> 
>  	/* initialize hcd */
>  	hcd = usb_create_hcd(&ehci_sh_hc_driver, &pdev->dev,

Acked-by: Alan Stern <stern@rowland.harvard.edu>

