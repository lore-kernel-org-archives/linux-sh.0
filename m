From: Simon Horman <horms@verge.net.au>
Date: Fri, 17 Jun 2011 04:45:37 +0000
Subject: Re: [RFC][PATCH 1/6] dmaengine: shdma: add chcr_write/read function
Message-Id: <20110617044536.GC22265@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <w3ptybpp1n8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3ptybpp1n8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 17, 2011 at 12:39:23PM +0900, Kuninori Morimoto wrote:
> CHCR register position is not same in all DMAC.
> This patch adds new "int chcr_offset" to decide it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviewed-by: Simon Horman <horms@verge.net.au>
