From: John Stultz <johnstul@us.ibm.com>
Date: Wed, 03 Dec 2008 16:35:29 +0000
Subject: Re: [PATCH 04/10] timer_inc: timer helper code, clockevent only
Message-Id: <1228322129.16665.53.camel@jstultz-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <20081201103300.26620.32206.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081201103300.26620.32206.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, 2008-12-04 at 00:30 +0900, Magnus Damm wrote:
> On Wed, Dec 3, 2008 at 1:04 PM, john stultz <johnstul@us.ibm.com> 
> > I definitely am interesting in trying to figure out if the clockevent
> > and clocksource interfaces need refinement to better adapt to hardware
> > if they are not sufficient. But I'm very hesitant to recommend creating
> > super-interfaces that try to span both.
> 
> The timer_inc interface sure is a something that spans both. Actually,
> that's the only thing it does - keeps track of the aggregated state
> and makes sure the timer is disabled whenever it's unused.
> 
> So maybe it's better to scrap the timer_inc part and just include that
> logic in the cmt driver? We can always go back later on if there is a
> direct need.

I think I'd be happier with this. Hopefully this will make any needed
changes to the clockevent or clocksource code more apparent. 

> > It just seems to me that most of the timer_inc code could be pushed down
> > into the cmt_driver to cut out the middle man. It reduces the number of
> > generic interfaces we have to deal with, and lessens the indirection.
> >
> > Again, I may be missing a subtlety of the timer_inc code, so keep
> > hammering on me if I'm just being thick headed. :)
> 
> You're not so think headed. =) I don't mind either way with timer_inc!
> 
> Regarding read2() patch, the enable()/disable() patch and a future
> unregistration patch - I still like to see that included. Do you see
> any disadvantages with that?

The enable/disable bits seem great. The read2() bit I'm not against, but
would like to see how it ends up being used before we commit to the
interface change. And unregistration is something that's been needed.

Thanks again for dealing with my feedback. I know its not fun to rework
or throwout code and start again. But I think in this case it will help
the amount of future maintenance needed.

thanks
-john

