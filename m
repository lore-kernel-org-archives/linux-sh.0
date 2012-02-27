From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 27 Feb 2012 22:30:24 +0000
Subject: Re: [PATCH] mackerel: Do not enable TMU timer in default config
Message-Id: <201202272330.24390.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <1329111377-15676-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1329111377-15676-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Monday, February 27, 2012, Paul Mundt wrote:
> On Sun, Feb 26, 2012 at 11:57:01PM +0100, Rafael J. Wysocki wrote:
> > On Thursday, February 23, 2012, Simon Horman wrote:
> > > I have discussed this a little with Magnus Damm and he is of
> > > the opinion that this problem likely relates to an interaction
> > > between TMU and power domains and that a full fix would be difficult
> > > within the 3.3 time-frame.
> > 
> > From my inspection of the sh_tmu driver it looks like that driver doesn't
> > support power management and the device it handles isn't taken into account
> > in our PM domains configuration (it belongs to the A4R domain, so that
> > domain can't be powered off while the driver is present).
> > 
> > For this reason, I propose to apply the appended change (which reflects the
> > current status of the driver AFAICS) for now and revisit the driver at one
> > point in future.
> > 
> This is just more band-aiding, and is functionally no different from
> disabling the TMU driver in the defconfig.
> 
> No, the TMU driver doesn't support power management, as support was never
> added. Presently none of the sh clocksource/clockevent drivers do, and
> we're certainly not going to be doing a !PM dependency for those, either.
> 
> At present we do have the clock framework interaction, but there are also
> fundamental ordering issues there with regards to use as an early timer
> (something I don't expect the power domains code has any concept of,
> either). If the device needs to be included in the A4R domain then patches to
> setup-sh7372.c doing that are fine, but I'm not interested in symptom
> patches that only attempt to sweep the problem under the rug.
> 
> Note that none of the MTU2/CMT/TMU drivers have been touched in ages, so
> the idea that regressions were introduced by any of them or that they're
> doing something wrong now is utterly absurd. If the power domain code
> wants to change the rules, that's fine, but disabling stuff randomly that
> you or Magnus failed to take in to account at the time is not.

I'm not talking about the power domains code, but of the PM code in general.

Actually, I can make it work with runtime PM (to some extent at least),
but that won't be enough, because it doesn't handle system suspend/resume
correctly.

> The options as I see it are any of:
> 
> 	- Fix the driver(s) (possibly not much time left now, due to all
> 	  of the time wasted on trying to fix the symptoms instead of the
> 	  problem).

That is clearly the way to go, but not before 3.3 is out.  And it is not
sufficient, because the TMU bits have to be represented in the appropriate
PM domain as you correctly noted below.

> 	- Ensure the TMU bits are represented in the appropriate power
> 	  domain.

The two above together.

> 	- Revert whatever change prevented PM && TMU from booting when it
> 	  was something that always worked before.

That's changes that were merged a couple of kernel releases before, so I don't
think we can do that realistically.  If you can give me some advice we can
actually use, I'll appreciate that very much.

And it boots along with PM if the early_platform_init part is removed from it
just fine, but then it doesn't work with PM, so it's not very useful when PM
is enabled anyway.

> 	  It can be re-applied when the change is done in less of a half-assed
> 	  fashion.

Well, I think the technical discussion ends here.

Thank you for your kind response.

Rafael
