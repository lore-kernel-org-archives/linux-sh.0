From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Apr 2013 04:41:02 +0000
Subject: Re: APE6EVM and Runtime PM
Message-Id: <20130404044101.GG28297@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130404020019.GA7163@verge.net.au>
 <87wqsjdlhv.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wqsjdlhv.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Apr 03, 2013 at 08:26:39PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > in the course of looking look at consolidating our defconfigs I
> > noticed that SMSC ethernet and rcar_thermal seem seem to not work when
> > runtime PM is enabled.
> > 
> > I'm wondering if you have any ideas of what might be the cause of this
> > or if you could give me some guidance on investigating this problem.
> > 
> > I assume that it relates to a clock or clocks not being enabled.
> 
> About rcar_thermal, it needs my patch which was sent to PM ML.
> I got email from Zhang that he accepted my patch (pm_runtime support for thermal).
> But it seems he didn't push his branch yet...
> I guess I explained this on my [PATCH 0/x] email.

Thanks, sorry for missing that.

I guess we are down to just SMSC then.
