From: Greg KH <greg@kroah.com>
Date: Mon, 28 Jan 2008 19:23:45 +0000
Subject: Re: kobject oops with maple bus
Message-Id: <20080128192345.GA5006@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1201377200.6672.10.camel@localhost.localdomain> <20080126204402.GA30867@kroah.com> <26713.85.118.17.158.1201513309.squirrel@newgolddream.dyndns.info>
In-Reply-To: <26713.85.118.17.158.1201513309.squirrel@newgolddream.dyndns.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Mon, Jan 28, 2008 at 09:41:49AM -0000, Adrian McMenamin wrote:
> On Sat, January 26, 2008 8:44 pm, Greg KH wrote:
> > On Sat, Jan 26, 2008 at 07:53:20PM +0000, Adrian McMenamin wrote:
> >> Greg,
> >>
> >> Just updated my git to the latest sources and get these (seemingly
> >> non-fatal) oops with the Dreamcast maple bus. I'll investigate further,
> >> but they may mean something to out out of the box.
> >>
> >> Adrian
> 
> ....
> 
> >> [    0.000000] kobject (8cc2d360): tried to init an initialized object,
> >> something is seriously wrong.
> >
> > The problem is here.  You have possibly already initialized this object,
> > or called 'kobject_get' on it before registering it with the driver
> > core.  This is a new sanity check that has been in the -mm tree for
> > years :)
> >
> > So I think something needs to be fixed in the code.  Do you want me to
> > take a look at it?
> >
> > thanks,
> >
> > greg k-h
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> Greg,
> 
> Have now patched that. But I am trying to hunt down another bug - which
> seems memory related. After N hotplug events (where N is greater than two
> and less than about 100) I get this below - either indicating something
> very wrong in SLUB (unlikely) or a memory leak in my driver (sadly, much
> more likely).
> 
> I cannot see anything obvious and my best guess is that I am freeing up
> the underlying struct device incorrectly - this is allocated currently as
> staticly allocated member of a dynamically allocated struct maple_device.
> It gets hit by the kfree(mdev) - is that going to cause a problem?

Yes, you can not free the struct device on your own, you must let the
release function clean it up for you.

Try enabling CONFIG_KOBJECT_DEBUG as well as CONFIG_DEBUG_DRIVER and see
if that shows you some more clues as to what you are doing wrong here.

And please let me know what you find, in talking to Ingo, I need to find
all the "wrong cases" that this code is being used in to try to make it
easier to prevent this from happening again.

thanks,

greg k-h
