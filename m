From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 16 Apr 2013 22:36:49 +0000
Subject: Re: [PATCH v3 1/4] rcar-phy: add R8A7778 support
Message-Id: <516DD281.2060402@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304170132.43232.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304170132.43232.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 04/17/2013 01:32 AM, I wrote:

> The driver currently only supports R8A7779 SoC. Compared to it, R8A7778 USB-PHY
> has extra register range containing two high-speed signal quality characteristic
> control registers which should be set up  during USB-PHY  startup depending on
> whether a ferrite bead is in use or not.  So, we now handle an optional second
> memory range in the driver's probe method, add the 'ferrite_bead' field to the
> driver's platform data, and add an extra (optional) step to the USB-PHY startup
> routine which sets up the extended registers.
>
> Also mark in the driver's Kconfig section  that R8A7778 is  now supported and
> generally clarify that section, uppercasing the word "phy", while at it...
>
> The patch has been tested on the Marzen and BOCK-W boards.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
[...]
> @@ -109,10 +126,11 @@ static int rcar_usb_phy_init(struct usb_
>   			goto phy_init_end;
>   		}
>   
> -		/* (4) USB-PHY reset clear */
> +		/* (5) USB-PHY reset clear */
>   		iowrite32(PHY_ENB | PLL_ENB | PHY_RST, (reg0 + USBPCTRL1));
>   
>   		/* Board specific port settings */
> +		printk("sizeof(*pdata) = %d\n", sizeof(*pdata));

    Shoot! I thought I'd killed that... :-(

WBR, Sergei

