From: Pavel Machek <pavel@ucw.cz>
Date: Sat, 18 Jul 2009 11:49:48 +0000
Subject: Re: [linux-pm] [PATCH 00/04][RFC] PM: Runtime platform device PM
Message-Id: <20090718114947.GG1433@ucw.cz>
List-Id: <linux-sh.vger.kernel.org>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

> > Sure, conditions may have changed while the system was asleep.  They might
> > also change while the system is awake.  In general, whether or not the system
> > was asleep shouldn't make any difference -- to as great an extent as possible
> > we should strive to pretend that the entire sleep took no time at all (or
> > simply didn't happen).
> > 
> > So: Suppose the system had been awake when the access point
> > disappeared.  What would the wireless adapter driver do then?  It
> > should try to do exactly the same thing if the access point disappears
> > while the system is asleep.
> 
> Not really.  Namely, when the access point _vanishes_ at run time, this is an
> error condition from which we have to recover, while if it's _not_ _present_
> after a resume, it's a normal situation and we shouldn't be recovering from
> that (the user might have changed the physical location while
> suspended).

I disagree here. User can just walk away with powered notebook.


> > You see?  The sleep should be transparent.
> 
> In some cases it won't be, because the hardware state changes while sleeping.
> For example, a laptop battery may be depleted while suspended, so that after
> resume it's in the 'low' condition, while it was in the 'good' condition before
> the preceding suspend.  Arguably, you can't drain a battery from 90% to 10%,
> for example, momentarily.  Also, a CPU fan might be 100% on before
> suspend,

Actually... going 90%->10% immediately is common behaviour of old
li-ion batteries.

> because the CPU was hot at that time, but that doesn't mean the fan should be
> 100% on after the subsequent resume, because it's likely that the CPU will be
> cold (on some systems trying to make the fan spin too fast may lead to
> general problems with thermal management afterwards).

100% is indeed sane default for fan. Yes you should slow the fan down
when you read the real temperature. And yes some systems play it safe
and do 100% fan during boot.

(Otherwise you may have heat problems if you suspend and immediately
resume).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
