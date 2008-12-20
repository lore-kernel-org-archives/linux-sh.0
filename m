From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 20 Dec 2008 20:19:12 +0000
Subject: Re: [PATCH] sh: maple: add support for Maple controller as a joystick
Message-Id: <200812201219.12511.dmitry.torokhov@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1229728542.1441.6.camel@localhost.localdomain> <20081220151511.GA6528@console-pimps.org> <1229789248.6502.4.camel@localhost.localdomain>
In-Reply-To: <1229789248.6502.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Matt Fleming <matt@console-pimps.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>

On Saturday 20 December 2008 08:07:27 Adrian McMenamin wrote:
> On Sat, 2008-12-20 at 15:16 +0000, Matt Fleming wrote:
> > On Fri, Dec 19, 2008 at 11:15:42PM +0000, Adrian McMenamin wrote:
> > > Add support for the SEGA Dreamcast Maple controller as a joystick
> >
> > [snip]
> >
> > > +	struct dc_pad *pad = maple_get_drvdata(mapledev);
> > > +	struct input_dev *dev = pad->dev;
> > > +	unsigned char *res = mq->recvbuf;
> > > +
> > > +	buttons = ~cpu_to_le16(*(unsigned short *)(res + 8));
> > > +
> >
> > I may be wrong but shouldn't this use the I/O accessor functions?
>
> It's not iomemory, so I don't think so. The maple bus writes to a buffer
> in the physical RAM.
>

Hmm, but why we are going _from_ cpu order to le16??? I'd expect we
wanted to do conversion the other way around. I pulled it out of 'next'
for now.

> > > +
> > > +	pad = kzalloc(sizeof(struct dc_pad), GFP_KERNEL);
> > > +	idev = input_allocate_device();
> > > +	if (!pad || !idev){
> > > +		error = ENOMEM;
> > > +		goto fail;
> > > +	}
> >
> > [snip]
> >
> > > +fail:
> > > +	input_free_device(pad->dev);
> >
> > Possible NULL pointer dereference?
>
> No, because input_free_device is:
>
> void input_free_device(struct input_dev *dev)
> {
>         if (dev)
>                input_put_device(dev);
> }
> EXPORT_SYMBOL(input_free_device);

But we need to be freeing idev, not pad->dev because pad might
be NULL.

-- 
Dmitry
