From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 12 Mar 2012 21:30:56 +0000
Subject: Re: [GIT PULL] Renesas SoC updates for v3.4
Message-Id: <201203122230.56595.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201203092155.04731.rjw@sisk.pl> <201203092252.48110.rjw@sisk.pl> <20120312011359.GB9503@linux-sh.org>
In-Reply-To: <20120312011359.GB9503@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, Rob Herring <robherring2@gmail.com>

On Monday, March 12, 2012, Paul Mundt wrote:
> On Fri, Mar 09, 2012 at 10:52:47PM +0100, Rafael J. Wysocki wrote:
> > On Friday, March 09, 2012, Arnd Bergmann wrote:
> > > On Friday 09 March 2012, Rafael J. Wysocki wrote:
> > > > Please pull Renesas SoC updates for v3.4 since commit
> > > > ce8fea7aa4ad9e3b40999a08622ef27c77159659:
> > > > 
> > > >     mmap: EINVAL not ENOMEM when rejecting VM_GROWS
> > > > 
> > > > with top-most commit f57fd2100e8273af3a9d2ff67714903d2dfd1eef
> > > 
> > > Hi Rafael,
> > > 
> > > Please rebase this on an -rc release, otherwise we get a rather
> > > messy history in the arm-soc tree.
> > 
> > Well, OK, I can rebase it on -rc7 if there is one, unless Paul
> > has already pulled from clk_ops-rename.  Paul?
> > 
> Nope, I haven't had a chance yet. Feel free to rebase as necessary and
> I'll grab them afterwards.

Thanks, I've just rebased clk_ops-rename on top of -rc7.

Rafael
