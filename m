From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 05 Apr 2013 00:02:01 +0000
Subject: Re: [PATCH v2 1/2] ARM: mach-shmobile: r8a7779: Add DU support
Message-Id: <2405796.5ubkezlbZP@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1364412073-12322-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1364412073-12322-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Thursday 04 April 2013 23:17:59 Sergei Shtylyov wrote:
> On 03/27/2013 10:21 PM, Laurent Pinchart wrote:
> > Add a function to register the DU device with board-specific platform
> > data.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> [...]
> 
> > diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c
> > b/arch/arm/mach-shmobile/setup-r8a7779.c index a460ba3..2f817d8 100644
> > --- a/arch/arm/mach-shmobile/setup-r8a7779.c
> > +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> 
> [...]
> 
> > @@ -428,6 +451,13 @@ void __init r8a7779_add_standard_devices(void)
> >   			    ARRAY_SIZE(r8a7779_late_devices));
> >   }
> > 
> > +void __init r8a7779_add_du_device(void *pdata)
> 
> Just to repeat the criticism that your patch have somehow eluded (but mine
> 2, with analogous approach, has not :-), you can't have 'void *' here -- you
> should declare the function with the actual platform data type pointer as an
> argument.

OK I'll fix that.

> > +{
> > +	du_device.dev.platform_data = pdata;
> > +
> > +	platform_device_register(&du_device);
> 
> That function should also be avoided like plague (according to Greg KH and
> Arnd Bergmann). I suggest you use
> 
> platform_device_register_resndata() instead, it's more preferable along with
> all the platform_device_register_*() family.

OK.

-- 
Regards,

Laurent Pinchart

