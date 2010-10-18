From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 18 Oct 2010 08:56:13 +0000
Subject: Re: [PATCH 3/3] ARM: mach-shmobile: clock-sh7372: Add FSIDIV clock support
Message-Id: <20101018085612.GB5809@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pk4lk11gd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pk4lk11gd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 18, 2010 at 12:49:44PM +0900, Kuninori Morimoto wrote:
> > On Fri, Oct 15, 2010 at 06:39:23PM +0900, Paul Mundt wrote:
> > Oops, the first r->arg needs to be changed to r or you'll blow up on the
> > table rounding. I've got all of these in my sh/clkfwk topic branch if you
> > simply wish to test that.
> 
> Thank you.
> These patches are based on genesis tree + sh/clkfwk.
> 
> Kuninori Morimoto (2):
>       sh: clkfwk: modify for_each_frequency end condition
>       ARM: mach-shmobile: clock-sh7372: Add FSIDIV clock support
> 
> I think 1st patch is needef to solve off-by-one issue.
> 
I'll take the first one in the sh/clkfwk topic branch and merge it in to
HEAD. The remaining FSIDIV patch I'll then roll in to the genesis tree
once the clock bits have hit mainline. Hopefully this will all be sorted
by late -rc1 or -rc2. Thanks for testing!
