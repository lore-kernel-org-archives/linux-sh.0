From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 21 Apr 2015 17:55:18 +0000
Subject: Re: [RFC V2 4/4] i2c: mux: demux-pinctrl: add driver
Message-Id: <2330603.85ZELctJ45@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1426576524-22315-5-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1426576524-22315-5-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

On Thursday 19 March 2015 16:53:18 Wolfram Sang wrote:
> >> + * Switching a master currently needs some access to either i2c-2 or
> >> i2c-3.
> >> + * Switching could also be done via sysfs or any other config mechanism.
> >> + * For this proof-of-concept, extra busses have been used since it
> >> simplifies
> >> + * locking a little.
> > 
> > I have mixed feelings to be honest. When using n internal masters muxed on
> > the same pins, with pin muxing used as a selector, I could agree that we
> > are dealing with n+1 busses, with n busses between the masters and the
> > demux, and one external bus. The two extra virtual busses in your example
> > above bother me.
> 
> That was chosen so the access to the "virtual" bus would automatically
> do the pinctrl change. As I said somewhere, this could be handled
> differently.
> 
> > This being said, I see this as an attempt to keep the traditional model of
> > I2C slaves being children of an I2C master while still departing from it
> > at the hardware level. Wouldn't it be better to depart from it from a
> > software point of view as well ? This would allow supporting real
> > multi-master configurations, but would come with a high refactoring cost
> > in kernel code.
> 
> You mean the slaves belong to an i2c-bus and this bus can be connected
> to masters? Yeah, that would be quite a change.

Yes, that's what I meant. I believe it would describe the hardware topology 
better for multi-master systems.

> And I am still not convinced if that would solve the issue that the driver
> model does not support re-parenting but rather suggests to delete and
> recreate the device. From device_add():
> 
>  * Do not call this routine or device_register() more than once for
>  * any device structure.  The driver model core is not designed to work
>  * with devices that get unregistered and then spring back to life.
>  * (Among other things, it's very hard to guarantee that all references
>  * to the previous incarnation of @dev have been dropped.)  Allocate
>  * and register a fresh new struct device instead.

Maybe it's time to implement proper reparenting in the driver core code then ? 
:-) That's opening Pandora's box though...

> > I'm also worried about power management, how do you envision its
> > implementation ?
> 
> Haven't thought about it so far. That is another reason not to break the
> driver model, I guess.
> 
> Thanks for your input!

You're welcome. I'm afraid it has mostly been destructive input, I don't have 
any good solution to the problem for now :-(

-- 
Regards,

Laurent Pinchart

