From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 01 Apr 2015 04:09:08 +0000
Subject: RE: [PATCH v2 2/2] dmaengine: usb-dmac: Add Renesas USB DMA Controller (USB-DMAC) driver
Message-Id: <HKNPR06MB3220A30518EA91F1A1E9824D8F30@HKNPR06MB322.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426052394-5556-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1426052394-5556-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20150318082215.GF32683@intel.com>
 <SIXPR06MB33355F6F0532539A23ED8A9D8010@SIXPR06MB333.apcprd06.prod.outlook.com>
 <20150319095927.GX32683@intel.com>
 <HKNPR06MB32208DCB73732603FF61234D80D0@HKNPR06MB322.apcprd06.prod.outlook.com>
 <20150401034308.GU7192@intel.com>
In-Reply-To: <20150401034308.GU7192@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "horms@verge.net.au" <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Vinod,

> > > > > > +static void usb_dmac_chan_remove(struct usb_dmac_chan *uchan)
> > > > > > +{
> > > > > > +	tasklet_kill(&uchan->task);
> > > > > that part is good, but how about disabling irq? you can still get insterrupt
> > > >
> > > > Thank you for the point! I will add calling usb_dmac_chan_halt() to disable the interrupt.
> > > On top of that you should free/disable the irq as well
> >
> > Does this mean I should call free_irq() or something in this remove function?
> Yes, that way irq can be be invoked
> 
> > Since this driver uses devm_request_irq(), I don't think the driver call such a function.
> > (After this driver was removed, free_irq() was called by devm_irq_release())
> Yes FW will call, but the issue is that isr can get triggered after you ahve
> freed up stuff. So to prevent thsi it is recomendded that driver invoked
> free_irq() explictly or disable the irq line

Thank you for the comment! I understood it.
So, I will submit v4 patches.

Best regards,
Yoshihiro Shimoda

> --
> ~Vinod

