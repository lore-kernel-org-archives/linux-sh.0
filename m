From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 18 Apr 2011 20:08:10 +0000
Subject: Re: [PATCH/RFC] ARM: mach-shmobile: sh7372 power domain prototype
Message-Id: <201104182208.10677.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20110411194911.7991.79950.sendpatchset@t400s>
In-Reply-To: <20110411194911.7991.79950.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Monday, April 18, 2011, Magnus Damm wrote:
> Hi Rafael,
> 
> 2011/4/12 Rafael J. Wysocki <rjw@sisk.pl>:
> > Hi,
> >
> > To start with, I think we'll need to do that a bit differently, because
> > apparently some clock management code may be shared with OMAP.
> >
> > Most imprtantly, the PM core is going to be changed so that power domain
> > callbacks will be executed instead of and not in addition to the bus type
> > callbacks, so platform_pm_runtime_suspend() and platform_pm_runtime_resume()
> > will have to be replaced by the power domain callbacks entirely.
> >
> > I'm working on those changes right now, but I'd like to make the core
> > changes first and get everybody involved to agree with them.
> 
> Thanks for your help!
> 
> > Some more comments below.
> 
> [snip]
> 
> > The above things don't look quite right.  I think the connections between
> > device objects and power domain objects should be set up in the board file.
> 
> Yes, no doubt about that!!!
> 
> > This doesn't look nice to me.
> 
> I have to agree with you on that one. =)
> 
> This prototype code is rather filthy and can easily be seen as one big
> layering violation.
> 
> However, just so you understand the reason behind this:
> 
> I simply posted the patch to publish _some_ code that exercises the
> Runtime PM callbacks in combination with a bit of power domain code.
> This so anyone with sh7372 can do some simple testing of drivers using
> Runtime PM.
> 
> I'd like to see the drivers hardened in parallel with Runtime PM power
> domain support. When we have something nicer we will of course switch
> to using that. Feel free to post a better version that is properly
> abstracted. =)

Will do, on top of my patches clarifying the existing runtime PM code:
https://lkml.org/lkml/2011/4/16/129

Thanks,
Rafael
