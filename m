From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 30 Apr 2015 07:30:48 +0000
Subject: Re: [PATCH] ARM: shmobile: koelsch: Fix adv7511 IRQ sensing
Message-Id: <3267953.EtXjKtbbY7@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1430315743-8521-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1430315743-8521-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Thursday 30 April 2015 13:56:40 Simon Horman wrote:
> Hi Laurent,
> 
> On Wed, Apr 29, 2015 at 04:55:43PM +0300, Laurent Pinchart wrote:
> > The adv7511 IRQ is low level triggered, not falling edge triggered. The
> > wrong sense configuration results in no interrupt being triggered at
> > all, breaking hotplug detection. Fix it.
> 
> Would I be correct in adding the following and queuing it up
> as a fix for v4.1 and v4.0-stable?
> 
> Fixes: 83a0731b39f3 ("ARM: shmobile: koelsch: Add DU HDMI output support")

I think that would be fine. It's not a regression fix in the traditional 
sense, but it fixes a shortcoming of the original commit.

> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts
> > b/arch/arm/boot/dts/r8a7791-koelsch.dts index 74c3212f1f11..824ddab9c3ad
> > 100644
> > --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> > +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> > @@ -545,7 +545,7 @@
> >  		compatible = "adi,adv7511w";
> >  		reg = <0x39>;
> >  		interrupt-parent = <&gpio3>;
> > -		interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
> > +		interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
> > 
> >  		adi,input-depth = <8>;
> >  		adi,input-colorspace = "rgb";

-- 
Regards,

Laurent Pinchart

