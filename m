From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sat, 20 Dec 2008 16:07:27 +0000
Subject: Re: [PATCH] sh: maple: add support for Maple controller as a
Message-Id: <1229789248.6502.4.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1229728542.1441.6.camel@localhost.localdomain>
	 <20081220151511.GA6528@console-pimps.org>
In-Reply-To: <20081220151511.GA6528@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matt Fleming <matt@console-pimps.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-sh <linux-sh@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>

On Sat, 2008-12-20 at 15:16 +0000, Matt Fleming wrote:
> On Fri, Dec 19, 2008 at 11:15:42PM +0000, Adrian McMenamin wrote:
> > 
> > Add support for the SEGA Dreamcast Maple controller as a joystick
> > 
> 
> [snip]
> 
> > +	struct dc_pad *pad = maple_get_drvdata(mapledev);
> > +	struct input_dev *dev = pad->dev;
> > +	unsigned char *res = mq->recvbuf;
> > +
> > +	buttons = ~cpu_to_le16(*(unsigned short *)(res + 8));
> > +
> 
> I may be wrong but shouldn't this use the I/O accessor functions?
> 

It's not iomemory, so I don't think so. The maple bus writes to a buffer
in the physical RAM.


> > +
> > +	pad = kzalloc(sizeof(struct dc_pad), GFP_KERNEL);
> > +	idev = input_allocate_device();
> > +	if (!pad || !idev){
> > +		error = ENOMEM;
> > +		goto fail;
> > +	}
> 
> [snip]
> 
> > +fail:
> > +	input_free_device(pad->dev);
> 
> Possible NULL pointer dereference?

No, because input_free_device is:

void input_free_device(struct input_dev *dev)
{
        if (dev)
               input_put_device(dev);
}
EXPORT_SYMBOL(input_free_device);

