From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 07 May 2013 15:16:51 +0000
Subject: Re: [PATCH] sh-pfc: r8a7779: Don't group USB OVC and PENC pins
Message-Id: <2165023.iIgNqWDicN@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1367908563-20293-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1367908563-20293-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Tuesday 07 May 2013 19:09:53 Sergei Shtylyov wrote:
> On 07-05-2013 18:51, Laurent Pinchart wrote:

[snip]

> >>> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> >>> b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c index d6056ed..ddc2b2e 100644
> >>> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> >>> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> >>> @@ -2392,27 +2392,48 @@ static const unsigned int sdhi3_wp_mux[] = {
> >>> 
> >>>    };
> >>>    /* - USB0
> >>>    -------------------------------------------------------------------
> >>>    */
> >>>    static const unsigned int usb0_pins[] = {
> >>> 
> >>> -	/* OVC */
> >>> -	RCAR_GP_PIN(4, 22), RCAR_GP_PIN(4, 26),
> >>> +	/* PENC */
> >>> 
> >>       PENC0.
> > 
> > It's the PENC pin for the USB0 function, so the comments refer to PENC,
> > not PENC0. Same for the other pins below.
> 
> No, the other pins are not the same: there's OVCn and USB_OVCn pins, you're
> mixing them up in your other comments.

I will s/OVC/USB_OVC/

-- 
Regards,

Laurent Pinchart

