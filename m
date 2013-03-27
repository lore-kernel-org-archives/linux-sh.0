From: Simon Horman <horms@verge.net.au>
Date: Wed, 27 Mar 2013 10:44:26 +0000
Subject: Re: [PATCH v2 3/3] ARM: shmobile: marzen: Add Display Unit support
Message-Id: <20130327104426.GB413@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1363271746-9806-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1363271746-9806-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20130327040143.GD25431@verge.net.au>
 <1881729.5FAEJzRRH0@avalon>
In-Reply-To: <1881729.5FAEJzRRH0@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org

On Wed, Mar 27, 2013 at 10:49:10AM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Wednesday 27 March 2013 13:01:43 Simon Horman wrote:
> > On Thu, Mar 14, 2013 at 03:35:46PM +0100, Laurent Pinchart wrote:
> > > Only the DU0 VGA output is currently supported. Support for the DU0 LVDS
> > > and DU1 LVDS outputs will require information about the panels that will
> > > be connected to those outputs.
> > > 
> > > Signed-off-by: Laurent Pinchart 
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > ---
> > > 
> > >  arch/arm/configs/marzen_defconfig     |  2 ++
> > >  arch/arm/mach-shmobile/board-marzen.c | 65 ++++++++++++++++++++++++++++++
> > >  2 files changed, 67 insertions(+)
> 
> [snip]
> 
> > > diff --git a/arch/arm/mach-shmobile/board-marzen.c
> > > b/arch/arm/mach-shmobile/board-marzen.c index cdcb799..0020506 100644
> > > --- a/arch/arm/mach-shmobile/board-marzen.c
> > > +++ b/arch/arm/mach-shmobile/board-marzen.c
> 
> [snip]
> 
> > > @@ -363,6 +397,37 @@ static void __init marzen_init(void)
> > >  	gpio_request(GPIO_FN_HSPI_TX0,	NULL);
> > >  	gpio_request(GPIO_FN_HSPI_RX0,	NULL);
> > > 
> > > +	/* Display Unit 0 (CN10: ARGB0) */
> > > +	gpio_request(GPIO_FN_DU0_DR7, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DR6, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DR5, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DR4, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DR3, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DR2, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DR1, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DR0, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DG7, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DG6, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DG5, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DG4, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DG3, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DG2, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DG1, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DG0, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DB7, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DB6, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DB5, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DB4, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DB3, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DB2, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DB1, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DB0, NULL);
> > > +	gpio_request(GPIO_FN_DU0_EXVSYNC_DU0_VSYNC, NULL);
> > > +	gpio_request(GPIO_FN_DU0_EXHSYNC_DU0_HSYNC, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DOTCLKOUT0, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DOTCLKOUT1, NULL);
> > > +	gpio_request(GPIO_FN_DU0_DISP, NULL);
> > > +
> > >  	/* USB (CN21) */
> > >  	gpio_request(GPIO_FN_USB_OVC0, NULL);
> > >  	gpio_request(GPIO_FN_USB_OVC1, NULL);
> > 
> > Hi Laurent,
> > 
> > do you have a version of this patch that will work in conjunction with
> > recent pinctrl changes and adds an entry/entries to marzen_pinctrl_map[]
> > instead of calling gpio_request?
> 
> I'm working on that, the next version will use the pinctrl API. Do you need an 
> early patch ?

If possible that would be very helpful.
