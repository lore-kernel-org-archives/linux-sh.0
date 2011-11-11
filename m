From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 11 Nov 2011 11:58:46 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 A4R suspend/resume order fix
Message-Id: <201111111258.46999.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20110927085408.27727.59395.sendpatchset@w520>
In-Reply-To: <20110927085408.27727.59395.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Friday, November 11, 2011, Magnus Damm wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: PM / shmobile: Avoid restoring the INTCS state during initialization
> >
> > The SH7372 PM domain initialization routine calls pd_power_up()
> > that executes the domain's .resume() callback, if present, and for
> > the A4R domain this callback attepmts to restore the INTCS state from
> > uninitialized data.  To avoid that, introduce __pd_power_up() that
> > will only execute the domain's .resume() callback if its second
> > argument is 'true' and make the SH7372 PM domain initialization
> > use it with 'false' as its second argument.  Redefine pd_power_up()
> > as a wrapper around __pd_power_up().
> >
> > Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Looks fine to me, from my point of view your implementation is better
> than the other alternatives.
> 
> It is correct that Guennadi reported this issue, and the Signed-off
> clearly shows that this specific implementation is coming from you. I
> suppose there are more important things in life than git attribution,
> but I do feel that I did spend a significant amount of time tracking
> down this issue, writing the initial patch and then also communicating
> with you guys. I may be wrong, but I suspect that if didn't do this
> then this issue wouldn't have been fixed.
> 
> Unfortunately there does not seem to be any tag for that kind of work,
> but if it existed then I would prefer to add this in between you and
> Guennadi:
> 
> Tracked-down-by: Magnus Damm <damm@opensource.se>

OK

I'll add your ack too, if you don't mind. :-)

Thanks,
Rafael
