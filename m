From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 10 Mar 2013 20:21:53 +0000
Subject: Re: [PATCH/RFC 11/12] ARM: shmobile: r8a7779: Register GPIO devices
Message-Id: <8467975.JttTFoc9XY@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1362941928-18115-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362941928-18115-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Monday 11 March 2013 00:06:39 Sergei Shtylyov wrote:
> Hello.
> 
> On 10-03-2013 22:58, Laurent Pinchart wrote:
> > Move GPIOs handling from the PFC device to separate GPIO devices.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >   arch/arm/mach-shmobile/setup-r8a7779.c | 58
> >   ++++++++++++++++++++++++++++++---- 1 file changed, 52 insertions(+), 6
> >   deletions(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c
> > b/arch/arm/mach-shmobile/setup-r8a7779.c index c54ff9b..1580605 100644
> > --- a/arch/arm/mach-shmobile/setup-r8a7779.c
> > +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> 
> [...]
> 
> > @@ -80,9 +76,59 @@ static struct platform_device r8a7779_pfc_device = {
> >   	.num_resources	= ARRAY_SIZE(r8a7779_pfc_resources),
> >   };
> > 
> > +#define R8A7779_GPIO(idx, npins) \
> > +static struct resource r8a7779_gpio##idx##_resources[] = {		\
> > +	[0] = {								\
> > +		.start	= 0xffc40000 + 0x1000 * (idx),			\
> > +		.end	= 0xffc4002b + 0x1000 * (idx),			\
> > +		.flags	= IORESOURCE_MEM,				\
> > +	},								\
> > +	[1] = {								\
> > +		.start	= gic_spi(141 + (idx)),				\
> 
> This file uses gic_iid() now instead.

Thanks. I found the gic_spi() macro pretty weird, I'm glad to know it wasn't 
just me :-)

-- 
Regards,

Laurent Pinchart

