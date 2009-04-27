From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 27 Apr 2009 08:53:18 +0000
Subject: Re: [PATCH 1/1] r2dplus: add cfi flash support and enable it
Message-Id: <20090427085318.GA26521@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1240764162-24117-1-git-send-email-plagnioj@jcrosoft.com>
In-Reply-To: <1240764162-24117-1-git-send-email-plagnioj@jcrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 27, 2009 at 08:19:57AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 09:32 Mon 27 Apr     , Paul Mundt wrote:
> > On Sun, Apr 26, 2009 at 06:42:42PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > +static struct resource flash_resource = {
> > > +	.start		= 0x00000000,
> > > +	.end		= 0x02000000,
> > > +	.flags		= IORESOURCE_MEM,
> > > +};
> > > +
> > > +static struct platform_device flash_device = {
> > > +	.name		= "physmap-flash",
> > > +	.id		= -1,
> > > +	.resource	= &flash_resource,
> > > +	.num_resources	= 1,
> > > +	.dev		= {
> > > +		.platform_data = &flash_data,
> > > +	},
> > > +};
> > > +
> > >  static struct platform_device *rts7751r2d_devices[] __initdata = {
> > >  	&sm501_device,
> > >  	&heartbeat_device,
> > >  	&spi_sh_sci_device,
> > > +	&flash_device,
> > >  };
> > >  
> > On RTS7751R2D-1 this is at least pretty bogus. By default the platform
> > has a socket-mounted MBM29F040 that is precisely 1MB, shadowed all the
> > way up to 0x04000000, with a fixed 16-bit bus width. There is the
> > possibility to hook up a larger flash to CN8 which will map directly over
> > top of that chip select space, but at least on RTS7751R2D-1, that is not
> > the default configuration.
> > 
> on the R2dplus it's a s29gl256p
> 
Ok, I've added this just for r2d+ boards. It's not worth special casing
the r2d_1 flash.
