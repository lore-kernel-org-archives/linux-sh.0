From: Simon Horman <horms@verge.net.au>
Date: Thu, 26 Nov 2015 02:22:19 +0000
Subject: Re: [PATCH 0/12] arm64: renesas: r8a7795: sound support
Message-Id: <20151126022215.GB30297@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8737vu8ucv.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8737vu8ucv.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Nov 25, 2015 at 06:35:17AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> These are r8a7795/salvator-x sound support for latest branch.
> (These are posted few month ago and were queued on Simon's branch)
> 
> I could have sound by this order
> 
> 	> git checkout renesas-devel-20151123-v4.4-rc2
> 	> git merge  geert/topic/cpg-mssr-v6
> 	> git am -3 ${THESE-PATCH-SET}
> 
> These supports 44.1kHz sound only. 48kHz sound needs cs2000 driver
> which is posted to ML (clk maintainer accepted ?)
> I can send cs2000 support if it was accepted.

Thanks Morimoto-san,

I have queued this up for v4.5.
