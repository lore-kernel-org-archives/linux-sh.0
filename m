From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 28 Feb 2012 01:23:45 +0000
Subject: Re: [PATCH] mackerel: Do not enable TMU timer in default config
Message-Id: <201202280223.45948.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <1329111377-15676-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1329111377-15676-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Monday, February 27, 2012, Simon Horman wrote:
> On Sun, Feb 26, 2012 at 11:57:01PM +0100, Rafael J. Wysocki wrote:
> > On Thursday, February 23, 2012, Simon Horman wrote:
> > > This allows the mackerel to boot using a kernel compiled
> > > using the mackerel default config. Without this change
> > > the kernel boot hangs during or immediately after SCIF
> > > initialisation.
> > > 
> > > SuperH SCI(F) driver initialized
> > > sh-sci.0: ttySC0 at MMIO 0xe6c40000 (irq = 80) is a scifa
> > > sh-sci sh-sci.0: start latency exceeded, new value 5416 ns
> > > console [ttySC0] enabled, bootconsole disabled
> > > console [ttySC0] enabled, bootconsole disabled
> > > 
> > > Signed-off-by: Simon Horman <horms@verge.net.au>
> > > 
> > > ---
> > > 
> > > Hi Rafael,
> > > 
> > > I would appreciate it if you could consider this change for 3.3.
> > > 
> > > It is a band-aid solution, however, it resolves a regression -
> > > the boot or lack thereof of a mackerel board using the default config -
> > > since 3.2.
> > > 
> > > I have discussed this a little with Magnus Damm and he is of
> > > the opinion that this problem likely relates to an interaction
> > > between TMU and power domains and that a full fix would be difficult
> > > within the 3.3 time-frame.
> > 
> > >From my inspection of the sh_tmu driver it looks like that driver doesn't
> > support power management and the device it handles isn't taken into account
> > in our PM domains configuration (it belongs to the A4R domain, so that
> > domain can't be powered off while the driver is present).
> > 
> > For this reason, I propose to apply the appended change (which reflects the
> > current status of the driver AFAICS) for now and revisit the driver at one
> > point in future.
> 
> Hi Rafael,
> 
> thanks for taking time to look into this.
> Your proposal seems good to me.
> 
> Tested-by: Simon Horman <horms@verge.net.au>

However, having looked at both sh_tmu and sh_cmt I don't see why the former
should break things (during boot), while the latter doesn't, so I've done
some more testing and, surprisingly enough, it turns out that disabling runtime
PM in sh-sci makes the boot hang with sh_tmu enabled go away.  So perhaps sh_tmu
is just a messenger here and the real problem is with sh-sci.

I think that more investigation is needed.

Thanks,
Rafael
