From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 13 Mar 2012 00:15:00 +0000
Subject: Re: [PATCH] PM / shmobile: Mark clocksource devices as "always on" (was: Re: [PATCH] sh_tmu / PM: Pr
Message-Id: <201203130115.00934.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201203122311.03576.rjw@sisk.pl>
In-Reply-To: <201203122311.03576.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tuesday, March 13, 2012, Simon Horman wrote:
> On Tue, Mar 13, 2012 at 12:34:57AM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, March 13, 2012, Simon Horman wrote:
> > > On Mon, Mar 12, 2012 at 11:19:07PM +0100, Rafael J. Wysocki wrote:
> > > > On Monday, March 12, 2012, Rafael J. Wysocki wrote:
> > > > > On Monday, March 12, 2012, Rafael J. Wysocki wrote:
> > > > > > On Monday, March 12, 2012, Simon Horman wrote:
> > > > > > > On Tue, Mar 06, 2012 at 11:13:10PM +0100, Rafael J. Wysocki wrote:
> > > > > > > > On Tuesday, March 06, 2012, Paul Mundt wrote:
> > > > > > > > > On Mon, Mar 05, 2012 at 11:46:08PM +0100, Rafael J. Wysocki wrote:
> > > > > > > > > > On Monday, March 05, 2012, Rafael J. Wysocki wrote:
> > > > > > > > > > > Anyway, to use the same approach in all three drivers we need a flag that
> > > > > > > > > > > will allow a driver to say "don't power down the domain this device belongs to"
> > > > > > > > > > > to the core.  It shouldn't be very difficult to introduce it, but I'm still
> > > > > > > > > > > not sure that will make the "TMU vs system resume" problem mentioned above go
> > > > > > > > > > > away.
> > > > > > > > > > > 
> > > > > > > > > > > I'll try to prepare a patch for that later today anyway.
> > > > > > > > > > 
> > > > > > > > > > Is appended.  Without a changelog for now, because I need to add CMT and
> > > > > > > > > > MTU2 to it still.
> > > > > > > > > > 
> > > > > > > > > The updated version looks much nicer, and the interaction with early
> > > > > > > > > platform entry is quite obvious. If we can reuse this for CMT and MTU2
> > > > > > > > > then that should about take care of it.
> > > > > > > > 
> > > > > > > > I believe that we can.
> > > > > > > > 
> > > > > > > > > Thanks for persisting!
> > > > > > > > 
> > > > > > > > No problem.
> > > > > > > > 
> > > > > > > > Below is a full patch with a changelog and CMT and MTU2 changes too.
> > > > > > > > This has been tested on Mackerel both with and without the TMU driver
> > > > > > > > without causing any visible issues to appear.
> > > > > > > 
> > > > > > > Hi Rafael,
> > > > > > > 
> > > > > > > I apologise for not responding earlier, I returned from a vacation
> > > > > > > (without my Mackerel) last night,
> > > > > > > 
> > > > > > > I have tried the patch below (slightly modified as I have detailed inline)
> > > > > > > on top of 3.3-rc7, however, I am observing that the boot hangs in the
> > > > > > > usual spot when using the default config.
> > > > > > 
> > > > > > First off, the patch applies to 3.3-rc7 without any modifications for me.
> > > > > 
> > > > > Sorry, I was talking about a different patch.
> > > > > 
> > > > > You need this one to fix the boot problem:
> > > > > 
> > > > > http://marc.info/?l=linux-sh&m3073065924863&w=4
> > > > > 
> > > > > (Paul has already taken it).
> > > > > 
> > > > > However, as said in the message, it addresses the boot problem _only_, so
> > > > > you need the other patch to address the possible PM issues after booting.
> > > > > 
> > > > > That other patch really didn't apply on 3.3-rc7, but for a reason different
> > > > > from what you described.  Appended is a fixed version.
> > > > > 
> > > > > Paul, do you want to take it or should I include it in my for-3.4 PM push
> > > > > with a Cc to -stable?
> > > > 
> > > > Sorry, Please disregard it.  I've just found another problem in it that
> > > > needs to be addressed.
> > > > 
> > > > I guess I'll include this patch into my for-3.4 PM push, then,
> > > > if you are OK with the clocksource device changes.
> > > 
> > > Hi Rafael,
> > > 
> > > I am completely confused. Which patches should I test against which tree?
> > 
> > First of all, please test if this patch fixes the boot issue for you:
> > 
> > http://marc.info/?l=linux-sh&m3073065924863&w=4
> 
> Thanks,
> 
> both Heip-san (CCed) and I have independently tested that patch and
> the boot problem is resolved with the default config on Mackerel.
> 
> Tested-by: Simon Horman <horms@verge.net.au>

Great, thanks for the confirmation!

Now, I'll be sending a series of patches that's supposed to address power
management issues appearing with the TMU driver present during system
suspend and/or runtime PM of the LCDC on Mackerel.

I'll send CCs of those patches to you.

Thanks,
Rafael
