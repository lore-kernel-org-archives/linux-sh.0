From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 28 Apr 2015 02:43:42 +0000
Subject: RE: [PATCH] usb: renesas_usbhs: Revise the binding document about the dma-names
Message-Id: <SG2PR06MB0919F96450C1795252DF55BFD8E80@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1428489744-4872-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20150408131403.GC5977@leverpostej>
 <HKNPR06MB322EC49F217406EBDD006DFD8FB0@HKNPR06MB322.apcprd06.prod.outlook.com>
 <20150409090625.GA18488@leverpostej>
In-Reply-To: <20150409090625.GA18488@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "balbi@ti.com" <balbi@ti.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>

Hi Felipe,


> Sent: Thursday, April 09, 2015 6:06 PM
> 
> On Thu, Apr 09, 2015 at 01:17:44AM +0100, Yoshihiro Shimoda wrote:
> > Hi Mark,
> >
> > >
> > > On Wed, Apr 08, 2015 at 11:42:24AM +0100, Yoshihiro Shimoda wrote:
> > > > Since the DT should describe the hardware (not the driver limitation),
> > > > This patch revises the binding document about the dma-names to change
> > > > simple numbering as "ch%d" instead of "tx<n>" and "rx<n>".
> > >
> > > The naming given in this patch looks more sensible to me.
> >
> > Thank you for your comment!
> >
> > > > Also this patch fixes the actual code of renesas_usbhs driver to handle
> > > > the new dma-names.
> > > >
> > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > ---
> > > >  This patch is based on Felipe's usb.bit / testing/next branch.
> > > >  (commit id = bbc78c07a51f6fd29c227b1220a9016e585358ba)
> > >
> > > I take it the existing driver and binding haven't hit mainline, and
> > > therefore there are no users yet?
> >
> > That's correct. At the moment, nobody uses the dma-names in the node of
> > renesas_usbhs yet.
> 
> Given that:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Would you apply this patch to your repository?
(If possible, it is merged in your fixes branch because the commit ab330cf388 is already merged
 on v4.1-rc1 and this patch is related to the commit.)

Or, should I resubmit this patch with Mark and Geert's Acked-by?
(I confirmed that this patch could be applied on the branches of both fixes and testing/next.)

Best regards,
Yoshihiro Shimoda

P.S.
I am surprised, the Morimoto-san's patch "tidyup usbhs_for_each_dfifo macro" is threaded to
this patch. However, this patch is not related to the Morimoto-san's patch.
http://thread.gmane.org/gmane.linux.ports.sh.devel/45229/focus4680

> Thanks,
> Mark.
