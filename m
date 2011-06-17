From: Simon Horman <horms@verge.net.au>
Date: Fri, 17 Jun 2011 04:45:59 +0000
Subject: Re: [RFC][PATCH 2/6] dmaengine: shdma: add chcr_ie_bit
Message-Id: <20110617044558.GD22265@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <w3psjr9p1mu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3psjr9p1mu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 17, 2011 at 12:39:37PM +0900, Kuninori Morimoto wrote:
> IE bit position on CHCR register is not same in all DMAC.
> This patch adds new "int chcr_ie_bit" to decide it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviewed-by: Simon Horman <horms@verge.net.au>
