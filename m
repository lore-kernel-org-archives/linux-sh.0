From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 07 Jul 2015 19:47:32 +0000
Subject: Re: [PATCH 2/5] i2c: emev2: add binding documentation
Message-Id: <13947160.RNzBrc1uk4@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1436219188-4325-1-git-send-email-wsa@the-dreams.de> <2376548.GgBSKQ3Rxq@avalon> <20150707194313.GB1572@katana>
In-Reply-To: <20150707194313.GB1572@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Hi Wolfram,

On Tuesday 07 July 2015 21:43:13 Wolfram Sang wrote:
> > > +Device tree configuration for Renesas EMEV2 IIC driver
> > 
> > s/driver/controller/
> 
> Yes,
> 
> > > +- interrupts      : 1 interrupt
> > 
> > I'd write this as "specifier for the IIC controller interrupt".
> 
> Yes.
> 
> > > +- clocks          : phandle to the IP core SCLK
> > 
> > The datasheet mentions PCLK and IIC_SCLK but doesn't provide details. Do
> > you have more information ?
> 
> I follow what is done for the other EMEV2 IP cores currently supported.
> All cores I checked have PCLK and SCLK but only SCLK is referenced in
> the DTS.

Could you briefly explain what the two clocks are for ? Or point me to the 
right documentation ?

-- 
Regards,

Laurent Pinchart

