From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 05 Dec 2013 05:49:17 +0000
Subject: Re: [PATCH 3/4] ARM: shmobile: r8a7790: add I2C support
Message-Id: <1926652.IR5XrQRWax@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0752rz.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li0752rz.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Thursday 05 December 2013 12:12:43 Simon Horman wrote:
> On Mon, Dec 02, 2013 at 12:38:54PM +0100, Laurent Pinchart wrote:
> > On Sunday 01 December 2013 17:32:37 Kuninori Morimoto wrote:
> > > Hi Laurent
> > > 
> > > > > @@ -76,6 +97,10 @@ void __init r8a7790_pinmux_init(void)
> > > > > 
> > > > >  	r8a7790_register_gpio(3);
> > > > >  	r8a7790_register_gpio(4);
> > > > >  	r8a7790_register_gpio(5);
> > > > > 
> > > > > +	r8a7790_register_i2c(0);
> > > > > +	r8a7790_register_i2c(1);
> > > > > +	r8a7790_register_i2c(2);
> > > > > +	r8a7790_register_i2c(3);
> > > > > 
> > > > >  }
> > > > 
> > > > I might be wrong, but I believe we have been requested to add new
> > > > devices directly to the board-*.c files, not to the setup-*.c files.
> > > 
> > > It depends on device.
> > > I2C host doesn't request board/platform information,
> > > so, setup-xxxx.c is fine.
> > > Please check other setup-xxx.c
> > 
> > Sure, that's how it's currently done for other SoCs, but I thought we were
> > asked to change that for new patches. I might be wrong, Magnus, Simon,
> > could you please comment on this ?
> 
> I think that if the device can be initialised entirely
> in the setup- file then its clean enough to put it there.
> However, if any part of the initialisation should
> go in the board- code then all of it should go there.
> 
> This is different to how we previously handled things
> where board- code may call some setup- code.
> That made a lot of sense in terms of the hardware.
> But it added some complexity.
> 
> As we would like to ultimately move to DT it seems that there
> is little point in adding such complexity now to legacy code. So the
> idea is just to completely initialise the devices in one file
> or another.
> 
> At least, that is my understanding :)

Thank you for the clarification.

-- 
Regards,

Laurent Pinchart

