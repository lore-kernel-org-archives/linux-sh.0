From: Simon Horman <horms@verge.net.au>
Date: Wed, 06 Mar 2013 11:56:05 +0000
Subject: Re: SDHI and MMCIF with kzm9g-reference
Message-Id: <20130306115604.GA11979@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130301110802.GB24364@verge.net.au>
In-Reply-To: <20130301110802.GB24364@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 05, 2013 at 04:11:39PM +0900, Paul Mundt wrote:
> On Tue, Mar 05, 2013 at 03:56:52PM +0900, Simon Horman wrote:
> > clocksource: sh_cmt: Set initcall level to subsys
> > 
> > The reason for this is to ensure that CMT is probed earlier
> > than with its previous initcall level, module init.
> > 
> > This came up as a problem with using kzm9g-reference which does
> > not make use of early timers or devices. In that scenario initialisation
> > of SDHI and MMCIF both stall on msleep() calls due to the absence
> > of a initialised clock source.
> > 
> > Boot tested on: armadillo800eva, mackerel and kzm9g
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> Any change you make for CMT equally applies to TMU and MTU2, and should
> be made at the same time. We do not want these to get out of sync for no
> reason.

Thanks, Magnus also suggested that to me.
I'll send a small series to fix them, CMT and EM_STI.

> Note that mmc is also under subsys, so you are still link order dependent
> there. If you wish to avoid that, it needs to be no later than
> arch_initcall.

It seems that at this time it is the SDHI and MMCIF drivers that are
causing the trouble I described earlier in the thread, not MMC itself. I
have no particular objections to moving the clock sources to arch_initcall.
But subsys_initcall seems sufficient for now.
