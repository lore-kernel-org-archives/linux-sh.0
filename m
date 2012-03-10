From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 10 Mar 2012 21:26:00 +0000
Subject: Re: [GIT PULL] Renesas SoC updates for v3.4
Message-Id: <201203102226.00687.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201203092155.04731.rjw@sisk.pl> <201203092327.00228.rjw@sisk.pl> <201203101053.42926.arnd@arndb.de>
In-Reply-To: <201203101053.42926.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Mundt <lethal@linux-sh.org>, LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, Rob Herring <robherring2@gmail.com>

On Saturday, March 10, 2012, Arnd Bergmann wrote:
> On Friday 09 March 2012, Rafael J. Wysocki wrote:
> > On Friday, March 09, 2012, Arnd Bergmann wrote:
> > > On Friday 09 March 2012, Rafael J. Wysocki wrote:
> > > > Hi,
> > > > 
> > > > On Friday, March 09, 2012, Arnd Bergmann wrote:
> > > > > On Friday 09 March 2012, Rafael J. Wysocki wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > Please pull Renesas SoC updates for v3.4 since commit
> > > > > > ce8fea7aa4ad9e3b40999a08622ef27c77159659:
> > > > > > 
> > > > > >     mmap: EINVAL not ENOMEM when rejecting VM_GROWS
> > > > > > 
> > > > > > with top-most commit f57fd2100e8273af3a9d2ff67714903d2dfd1eef
> > > > > 
> > > > > Hi Rafael,
> > > > > 
> > > > > Please rebase this on an -rc release, otherwise we get a rather
> > > > > messy history in the arm-soc tree.
> > > > 
> > > > Well, OK, I can rebase it on -rc7 if there is one, unless Paul
> > > > has already pulled from clk_ops-rename.  Paul?
> > > 
> > > Why not rebase back to -rc6?
> > 
> > Well, I can do that too, if I have to, but still I'd like to be sure that
> > Paul hasn't pulled from the clk_ops-rename branch yet.
> 
> The point is that there might not be an -rc7 any more.

Yes, I'm aware of that. :-)

> I'd suggest that you rebase on -rc6 if Paul has not yet pulled them,

I'm still waiting for a word from Paul.

> otherwise we will merge them in the current state and put an explanation
> into the merge changeset.

Well, if there's no -rc7 (which means that the final v3.3 is released tomorrow)
or there's no information from Paul within the next few days, I'm afraid
rebasing won't be very safe.

Thanks a lot and sorry for the trouble (I think I didn't understand you
correctly when you said you wanted things to be based on -rc, I thought you
meant the Linus' tree in general and not specific commits).

Rafael
