From: Simon Horman <horms@verge.net.au>
Date: Fri, 12 Apr 2013 08:36:31 +0000
Subject: Re: [PATCH v2] ARM: shmobile: r8a7778: use fixed ratio clock
Message-Id: <20130412083626.GA10632@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87ppy0np49.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ppy0np49.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 12, 2013 at 01:13:14AM -0700, Kuninori Morimoto wrote:
> R-Car M1 has many clocks, and it is possible to
> read/use clock ratio of these clocks from FRQMRx.
> But, these ratio are fixed value and
> these are decided by MD pin status.
> 
> This patch reads MD pin status,
> and used fixed ratio clock for other clocks.
> It was tesed on bock-w board.

Thanks, queued-up for v3.11 in the soc-r8a7778 branch.
