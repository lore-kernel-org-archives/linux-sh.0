From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 03 Jun 2009 03:39:13 +0000
Subject: Re: [PATCH] sched: sched_clock() clocksource handling.
Message-Id: <20090603033913.GB31488@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090602071718.GA17710@linux-sh.org> <1243927502.23657.5619.camel@twins> <20090602073515.GB17710@linux-sh.org> <1243928495.23657.5642.camel@twins> <alpine.LFD.2.00.0906022216230.3419@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.0906022216230.3419@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@fifo99.com>, Linus Walleij <linus.ml.walleij@gmail.com>, Andrew Victor <linux@maxim.org.za>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Andrew Morton <akpm@linux-foundation.org>, John Stultz <johnstul@linux.vnet.ibm.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 02, 2009 at 10:17:23PM +0200, Thomas Gleixner wrote:
> On Tue, 2 Jun 2009, Peter Zijlstra wrote:
> 
> > On Tue, 2009-06-02 at 16:35 +0900, Paul Mundt wrote:
> > > 
> > > We already do via select_clocksource(), if we are unregistering the
> > > current one then a new one with the flag set is selected. Before that,
> > > the override is likewise given preference, and we fall back on jiffies if
> > > there is nothing else. I suppose we could try and find the "best" one,
> > > but I think the override and manual clocksource selection should be fine
> > > for this.
> > 
> > Ah, ok. So unregister calls select_clocksource again? That does leave us
> > a small window with jiffies, but I guess that's ok.
> > 
> > > Now that you mention it though, the sched_clocksource() assignment within
> > > select_clocksource() happens underneath the clocksource_lock, but is not
> > > using rcu_assign_pointer().
> > 
> > Right, that would want fixing indeed.
> > 
> > >  If the assignment there needs to use
> > > rcu_assign_pointer() then presumably all of the unlock paths that do
> > > select_clocksource() will have to synchronize_rcu()?
> > 
> > No, you only have to do sync_rcu() when stuff that could have referenced
> > is going away and you cannot use call_rcu().
> > 
> > So when selecting a new clocksource, you don't need synchonization
> > because stuff doesn't go away (I think :-)
> 
> Hmm, no. In the unregister case stuff _IS_ going away. That's why you
> unregister in the first place, right ?
> 
sched_clocksource will be updated in the unregister path, the clocksource
being unregistered will go away, and we use RCU synchronization to handle
the case where the current clocksource assigned to sched_clocksource is
being unregistered. So while the clocksource is going away,
sched_clocksource is not.
