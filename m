From: Simon Horman <horms@verge.net.au>
Date: Mon, 11 Jun 2012 09:15:56 +0000
Subject: Re: [PATCH 22/27] ARM: shmobile: armadillo800eva: enable DMAEngine on SDHI
Message-Id: <20120611091555.GF22966@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87r4tmpkj6.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r4tmpkj6.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jun 10, 2012 at 08:58:09PM -0700, Kuninori Morimoto wrote:
> It is possible to reduce CPU load if SDHI used DMAEngine.
> This patch enabled it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Tested-by: Simon Horman <horms@verge.net.au>

> ---
>  arch/arm/mach-shmobile/board-armadillo800eva.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
