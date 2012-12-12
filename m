From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 12 Dec 2012 01:43:24 +0000
Subject: Re: [PATCH v2 00/77] SH pin control and GPIO rework with OF support
Message-Id: <2718519.y0zmq7NeTf@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1353974596-30033-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1353974596-30033-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

On Friday 07 December 2012 19:35:33 Laurent Pinchart wrote:
> On Thursday 06 December 2012 02:34:39 Laurent Pinchart wrote:
> > On Saturday 01 December 2012 23:55:35 Linus Walleij wrote:
> > > On Tue, Nov 27, 2012 at 1:01 AM, Laurent Pinchart wrote:
> > > > Here's the second version of the SH pin control and GPIO rework
> > > > patches.
> > > > I've added OF support for PFC instantiation and GPIO mappings that was
> > > > missing from v1. PINCTRL bindings are still missing and will come
> > > > soon.
> > > 
> > > So I've tried the only way I could to review this by cloning your tree
> > > and actually inspecting the end result ... overall it's looking very
> > > good!
> 
> > > Here are assorted comments:
> [snip]
> 
> > > - You're using the method to add ranges from the pinctrl side of
> > >   things. This is basically deprecated with the changes to gpiolib
> > >   I make in this merge window. If you study the way I changed
> > >   the pinctrl-u300.c and pinctrl-coh901.c to switch the registration
> > >   from being done in the pin controller to being done in the
> > >   gpiolib part, you will get the picture. The big upside is that
> > >   (A) makes the pin and GPIO references to the local GPIO
> > >   chip and pin controller and (B) that this supports adding ranges
> > >   from the device tree, which is probably what you want in the
> > >   end...
> > 
> > OK, I will have a look at the code.
> 
> Do you have a tree with those patches ?

I should have looked myself for the tree before asking, sorry. I'll have a 
look at the changes you've added there and will rework the PFC driver 
accordingly.

I will send a v3 with fixes based on your comments. I might omit the DT 
patches this time and send a pull request, as the patch set is getting too big 
for my taste. Even though the result won't be perfect (yet :-)), it's still an 
improvement, and I'll send additional patches on top of that.

> > > - This stuff in setup_data_regs():
> > >   rp->reg_shadow = gpio_read_raw_reg(drp->mapped_reg, drp->reg_width);
> > >   
> > >   You know, I think shadow registers is just another name for
> > >   regmap-mmio. Please consult drivers/base/regmap/regmap-mmio.c and
> > >   tell me if I'm wrong. It's not like I'm going to require you to
> > >   convert this to regmap from day 1 if this is legacy stuff but it's
> > >   probably the same thing.
> > 
> > I'll have a look at it.
> 
> I've considered regmap but I think it's a bit overkill. True, the reg_shadow
> is a different name for regmap-mmio (or rather for a small subset of it),
> but I already have a data structure instance for each register due to other
> requirements of the driver, so storing the cached value there is pretty
> much free.
> 
> I might end up reworking the data registers related code in which case I
> will try to use regmap.

-- 
Regards,

Laurent Pinchart

