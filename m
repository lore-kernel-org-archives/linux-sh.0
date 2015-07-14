From: Simon Horman <horms@verge.net.au>
Date: Tue, 14 Jul 2015 07:35:47 +0000
Subject: Re: [PATCH] ARM: shmobile: apmu: silence build warnings
Message-Id: <20150714073547.GB1945@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1436561296-29141-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1436561296-29141-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 13, 2015 at 10:58:07AM +0200, Wolfram Sang wrote:
> On Mon, Jul 13, 2015 at 10:04:06AM +0900, Simon Horman wrote:
> > Hi Wolfram,
> > 
> > On Fri, Jul 10, 2015 at 10:48:16PM +0200, Wolfram Sang wrote:
> > > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > 
> > > With shmobile_defconfig but SMP=n && SUSPEND=n, I get:
> > > 
> > > arch/arm/mach-shmobile/platsmp-apmu.c:49:12: warning: 'apmu_power_off' defined but not used [-Wunused-function]
> > > arch/arm/mach-shmobile/platsmp-apmu.c:70:12: warning: 'apmu_wrap' defined but not used [-Wunused-function]
> > > 
> > > Annotate those functions like the functions around it.
> > 
> > thanks for noticing this.
> > 
> > I'm not familiar with when it is appropriate to use __maybe_unused but does
> > anything speak against using #if as per the conditional compilation of the
> > callers in platsmp-apmu.c of the above functions?
> 
> I did my approach for consistency reasons. It looked to me that the
> *_on/off functions wanted to be grouped at the beginning.
> 
> Your approach works but looks fragile to me as soon as the ifdeffery of
> the callers change. So, we could move the code into the callers ifdef
> block, but we should do this consistently, even for the functions
> currently marked __maybe_unused. That would scatter them a little,
> though. apmu_wrap needs its own ifdeffery in any case.
> 
> Do you have a preference?

Less fragile sounds good. I have queued up your patch.

