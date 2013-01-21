From: Simon Horman <horms@verge.net.au>
Date: Mon, 21 Jan 2013 00:37:18 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779: scif .irqs used SCIx_IRQ_MUXED()
Message-Id: <20130121003717.GC19062@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <878v7q7rsa.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878v7q7rsa.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 18, 2013 at 01:40:42AM -0800, Kuninori Morimoto wrote:
> This patch tidyup scif .irqs settings by using
> SCIx_IRQ_MUXED() macro.

Thanks.

I have applied this to the soc3 branch and will merge it
into the next branch.

Please be aware that due to the complexity of the pinctl/pinmux
change complexities the branches in the renesas tree
are being rebased often. I recommend developing against the next branch.
