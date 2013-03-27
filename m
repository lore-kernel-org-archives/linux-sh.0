From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 27 Mar 2013 19:18:26 +0000
Subject: Re: [PATCH 0/2] Add R-Car Display Unit support for the Marzen board
Message-Id: <2147090.G3zcvJnIjL@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1364407550-30652-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1364407550-30652-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Wednesday 27 March 2013 23:07:31 Sergei Shtylyov wrote:
> Hello.
> 
> On 03/27/2013 09:05 PM, Laurent Pinchart wrote:
> > Per Simon's request, here are r8a7779 and marzen patches that add support
> > for the display unit, based on the pinctrl API.
> > 
> > The patches are not meant to be merged yet, they will be submitted with
> > the next version of the DU driver.
> > 
> > Sergei, is this more in line with how you want SoC devices to be declared
> > ?
> 
> Yes, it seems exactly how it's done by e.g. arch/arm/mach-davinci/, however
> I thought it was kind of tradition here to register the platform devices
> from array. I.e. you could separate setting the platform data ptr and
> registering the device... I don't have a strong opinion on either approach,
> so I will just follow your example when I'll have to submit an Ether SoC
> device.

The issue with keeping the device in the devices array is that it would get 
registered even if the board doesn't provide any platform data, which is 
probably something we want to avoid.

-- 
Regards,

Laurent Pinchart

