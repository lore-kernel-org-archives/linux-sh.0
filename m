From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 28 Feb 2012 23:59:36 +0000
Subject: Re: [PATCH] mackerel: Do not enable TMU timer in default config
Message-Id: <201202290059.36944.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <1329111377-15676-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1329111377-15676-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tuesday, February 28, 2012, Simon Horman wrote:
> On Tue, Feb 28, 2012 at 03:09:09PM +0900, Paul Mundt wrote:
> > On Tue, Feb 28, 2012 at 02:23:45AM +0100, Rafael J. Wysocki wrote:
> > > However, having looked at both sh_tmu and sh_cmt I don't see why the former
> > > should break things (during boot), while the latter doesn't, so I've done
> > > some more testing and, surprisingly enough, it turns out that disabling runtime
> > > PM in sh-sci makes the boot hang with sh_tmu enabled go away.  So perhaps sh_tmu
> > > is just a messenger here and the real problem is with sh-sci.
> > > 
> > > I think that more investigation is needed.
> > > 
> > Do you see any different behaviour with early printk enabled vs disabled?
> > We did have the ordering issues before with the pm calls hanging or
> > oopsing in the early path, but all of those should have been fixed
> > already. There have been quite a few sh-sci changes though, so if it
> > worked previously it should be bisectable at least.
> 
> Hi Paul, Hi Rafael,
> 
> I asked Hiep-san (CCed) to see if there was any difference booting a
> 3.3-rc3 on a Mackerel without earlyprintk in the kernel commandline.
> I tested 3.3-rc5 as well. There does not seem to be any change in behaviour,
> other than that specificly relating the bootconsole.
> 
> Without earlyprintk
> ...
> SuperH SCI(F) driver initialized
> sh-sci.0: ttySC0 at MMIO 0xe6c40000 (irq = 80) is a scifa
> sh-sci sh-sci.0: start latency exceeded, new value 6916 ns
> console [ttySC0] enabled
> [no more output]
> 
> With earlyprintk
> ...
> SuperH SCI(F) driver initialized
> sh-sci.0: ttySC0 at MMIO 0xe6c40000 (irq = 80) is a scifa
> sh-sci sh-sci.0: start latency exceeded, new value 5917 ns
> console [ttySC0] enabled, bootconsole disabled
> console [ttySC0] enabled, bootconsole disabled
> [no more output]

OK, I know what the problem is.

The enabling of sh_tmu apparently triggers the dev_warn() in
GENPD_DEV_TIMED_CALLBACK() for sh-sci.0, which leads to a deadlock in the
runtime PM core, because synchronous runtime resume for the device is then
run from its own runtime suspend callback.

I have an idea how to fix this, but it's going to take a couple of days
due to my time constraints.

Thanks,
Rafael
