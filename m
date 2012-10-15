From: Simon Horman <horms@verge.net.au>
Date: Mon, 15 Oct 2012 01:23:39 +0000
Subject: Re: [PATCH 1/2 v2] ARM: shmobile: armadillo800eva: __io abuse cleanup
Message-Id: <20121015012338.GB20403@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87lifcb80v.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lifcb80v.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 11, 2012 at 09:59:17PM -0700, Kuninori Morimoto wrote:
> a2a47ca36642e3995e982957bc42678cf11ca6ac
> (ARM: __io abuse cleanup) cleanuped __io() -> IOMEM(),
> but armadillo800eva was a outside of a target,
> since "merge window" timing issue.
> This patch cleanup it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> >> Simon
> 
> I guess this patch should go to v3.7 fixup branch

Thanks, applied to fixes. I'll try and get this included in 3.7.
