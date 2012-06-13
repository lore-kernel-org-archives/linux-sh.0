From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Jun 2012 00:52:52 +0000
Subject: Re: [PATCH 27/27 v2] ARM: shmobile: kzm9g: enable DMAEngine on FSI
Message-Id: <20120613005250.GZ16686@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <874nqgx3tb.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nqgx3tb.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 12, 2012 at 02:44:20AM -0700, Kuninori Morimoto wrote:
> It is possible to reduce CPU load if FSI playback used DMAEngine.
> This patch enabled it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

As I tested v1 of this patch:

Tested-by: Simon Horman <horms@verge.net.au>

> ---
> v1 -> v2
> 
>  - no change
> 
>  arch/arm/mach-shmobile/board-kzm9g.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
