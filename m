From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Jun 2012 00:50:07 +0000
Subject: Re: [PATCH 19/27 v2] ARM: shmobile: armadillo800eva: enable FSI-WM8978 sound
Message-Id: <20120613005005.GS16686@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87fwa0x3zo.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fwa0x3zo.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 12, 2012 at 02:40:31AM -0700, Kuninori Morimoto wrote:
> This patch enable sound support on CON11
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

As I tested v1 of this patch:

Tested-by: Simon Horman <horms@verge.net.au>

> ---
> v1 -> v2
> 
>  - no change
> 
>  arch/arm/mach-shmobile/Kconfig                 |    1 +
>  arch/arm/mach-shmobile/board-armadillo800eva.c |   85 ++++++++++++++++++++++++
>  2 files changed, 86 insertions(+), 0 deletions(-)
