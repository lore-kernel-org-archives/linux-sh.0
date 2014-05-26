From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 26 May 2014 23:08:11 +0000
Subject: Re: [PATCH usb: phy: add run-time dependencies to R-Car driver
Message-Id: <2295087.cjuxKqNLig@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <2252714.CbdvSBxGFE@avalon>
In-Reply-To: <2252714.CbdvSBxGFE@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Monday 26 May 2014 17:55:49 Sergei Shtylyov wrote:
> On 05/26/2014 04:50 PM, Laurent Pinchart wrote:
> >> The Renesas R-Car USB PHY driver only supports the R8A7778 and
> >> R8A7779, it isn't useful on other systems unless build testing.
> >> 
> >> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> >> Cc: Felipe Balbi <balbi@ti.com>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Could you please CC the linux-sh mailing list for similar patches in the
> > future ?
> > 
> > Sergei, any opinion on this ?
> 
>     I wouldn't object.

Thank you. I won't object either then.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> >> ---
> >> 
> >>   drivers/usb/phy/Kconfig |    1 +
> >>   1 file changed, 1 insertion(+)
> >> 
> >> --- linux-3.15-rc6.orig/drivers/usb/phy/Kconfig	2014-04-14
> >> 09:42:31.481112766 +0200 +++
> >> linux-3.15-rc6/drivers/usb/phy/Kconfig	2014-05-23 10:11:59.979813625
> >> +0200
> >> @@ -208,6 +208,7 @@ config USB_MXS_PHY
> >>   config USB_RCAR_PHY
> >>   	tristate "Renesas R-Car USB PHY support"
> >>   	depends on USB || USB_GADGET
> >> +	depends on ARCH_R8A7778 || ARCH_R8A7779 || COMPILE_TEST
> >>   	select USB_PHY
> >>   	help
> >>   	  Say Y here to add support for the Renesas R-Car USB common PHY
> >>   	  driver.

-- 
Regards,

Laurent Pinchart

