From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Jun 2012 00:52:33 +0000
Subject: Re: [PATCH 26/27 v2] ARM: shmobile: kzm9g: enable FSI-AK4648
Message-Id: <20120613005231.GY16686@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8762awx3ts.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8762awx3ts.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 12, 2012 at 02:44:03AM -0700, Kuninori Morimoto wrote:
> This patch enable sound playback/capture on CN9/CN10.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

As I tested v1 of this patch:

Tested-by: Simon Horman <horms@verge.net.au>

> ---
> v1 -> v2
> 
>  - no change
> 
>  arch/arm/mach-shmobile/Kconfig       |    1 +
>  arch/arm/mach-shmobile/board-kzm9g.c |   79 ++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+), 0 deletions(-)
