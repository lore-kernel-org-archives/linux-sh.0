From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 15 Apr 2013 11:42:33 +0000
Subject: Re: [PATCH v2 1/4] rcar-phy: add R8A7778 support
Message-Id: <516BE7A9.6080104@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304130340.15019.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304130340.15019.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 13-04-2013 3:40, I wrote:

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

[...]

> Index: renesas/include/linux/usb/rcar-phy.h
> =================================> --- renesas.orig/include/linux/usb/rcar-phy.h
> +++ renesas/include/linux/usb/rcar-phy.h
> @@ -21,6 +21,7 @@ struct rcar_phy_platform_data {
>   		bool active_high:1; /* true: active  high, false: active low */
>   				/* Set to true  on port 1 in function mode */
>   	} ovc_pin[3];
> +	bool ferrite_bead:1;	/* (R8A7778 only) */

    I think I'll repost this series. I want to move thjis field to the start 
of structure for better packing, and add a comment to 'ovc_pin'.
    I've also forgotten to add an ACK by Felipe.

WBR, Sergei

