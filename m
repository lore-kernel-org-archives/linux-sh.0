From: Simon Horman <horms@verge.net.au>
Date: Mon, 15 Oct 2012 23:59:46 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779: use __iomem pointers for MMIO
Message-Id: <20121015235944.GD2217@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87391gcg0f.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87391gcg0f.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 15, 2012 at 01:10:28AM -0700, Kuninori Morimoto wrote:
> 0a4b04dc299dfb691827a4001b3d8d7e443b71c9
> (ARM: shmobile: use __iomem pointers for MMIO)
> modified iomem pointers so that IOMEM() macro will be used,
> but clock-r8a7779.c was out of target.
> This patch fixes it up.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/clock-r8a7779.c |   22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Thanks, I have applied this to the fixes branch of my renesas
tree and will endeavour to get it included in 3.7.
