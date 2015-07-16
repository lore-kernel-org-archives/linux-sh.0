From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Jul 2015 11:29:04 +0000
Subject: Re: [PATCH] ARM: shmobile: lager: Fix adv7511 IRQ sensing
Message-Id: <1587338.NX4Ks6TcsD@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1430885131-6098-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1430885131-6098-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Tuesday 07 July 2015 09:48:09 Simon Horman wrote:
> On Mon, May 25, 2015 at 10:08:24AM +0900, Simon Horman wrote:
> > On Wed, May 06, 2015 at 04:12:39PM +0300, Laurent Pinchart wrote:
> >> On Wednesday 06 May 2015 12:34:34 Ben Hutchings wrote:
> >>> On Wed, 2015-05-06 at 07:05 +0300, Laurent Pinchart wrote:
> >>>> The adv7511 IRQ is low level triggered, not falling edge triggered.
> >>>> The wrong sense configuration results in no interrupt being
> >>>> triggered at all, breaking hotplug detection. Fix it.
> >>>> 
> >>>> Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> >>>> Signed-off-by: Laurent Pinchart
> >>>> <laurent.pinchart+renesas@ideasonboard.com>
> >>>> ---
> >>>> 
> >>>>  arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>> 
> >>>> Ben, would you be able to test this ? I won't have access to my
> >>>> Lager board before Sunday.
> >>> 
> >>> I only have remote access to a Lager at present, so I would need to
> >> pass this on to a colleague.
> >> 
> >> No worries. Worst case I'll try it when I get back home.
> > 
> > Did anyone manage to test this?
> 
> This seems to have fallen through the cracks.

It did indeed. There seems to be many cracks these days, must be the season.

> Laurent, is there any chance you could test this?

Tested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> >>>> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts
> >>>> b/arch/arm/boot/dts/r8a7790-lager.dts index
> >>>> 46f4c56c287c..21782e6b37f7
> >>>> 100644
> >>>> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> >>>> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> >>>> @@ -548,7 +548,7 @@
> >>>>  		compatible = "adi,adv7511w";
> >>>>  		reg = <0x39>;
> >>>>  		interrupt-parent = <&gpio1>;
> >>>> -		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
> >>>> +		interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
> >>>> 
> >>>>  		adi,input-depth = <8>;
> >>>>  		adi,input-colorspace = "rgb";

-- 
Regards,

Laurent Pinchart

