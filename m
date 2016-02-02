From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 02 Feb 2016 08:29:00 +0000
Subject: RE: [PATCH] phy: rcar-gen3-usb2: remove HSUSB registers handling
Message-Id: <TY1PR06MB0928A539F613E34157EA79C8D8DF0@TY1PR06MB0928.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452158204-5236-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20160109223307.GA14530@rob-hp-laptop>
In-Reply-To: <20160109223307.GA14530@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "kishon@ti.com" <kishon@ti.com>
Cc: "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Rob Herring <robh@kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Hi Kishon,

Would you review this patch?
I checked the latest linux-phy.git / next branch today, and it is the same as the following.

> >  This patch is based on the linux-phy / next branch.
> >  (commit id = 9955a7835bf376e12482583958b2661f501b868b)

Best regards,
Yoshihiro Shimoda

> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Sunday, January 10, 2016 7:33 AM
> To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: kishon@ti.com; pawel.moll@arm.com; mark.rutland@arm.com; ijc+devicetree@hellion.org.uk; galak@codeaurora.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-sh@vger.kernel.org
> Subject: Re: [PATCH] phy: rcar-gen3-usb2: remove HSUSB registers handling
> 
> On Thu, Jan 07, 2016 at 06:16:44PM +0900, Yoshihiro Shimoda wrote:
> > Since the related driver (CPG/MSSR driver) only manages the first module
> > clock, this driver should not handle the HSUSB registers. So, this patch
> > removes the HSUSB registers handling.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  This patch is based on the linux-phy / next branch.
> >  (commit id = 9955a7835bf376e12482583958b2661f501b868b)
> >
> >  .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 15 ++--
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> >  drivers/phy/phy-rcar-gen3-usb2.c                   | 83 +++-------------------
> >  2 files changed, 15 insertions(+), 83 deletions(-)
> 

