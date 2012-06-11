From: Simon Horman <horms@verge.net.au>
Date: Mon, 11 Jun 2012 09:14:44 +0000
Subject: Re: [PATCH 21/27] ARM: shmobile: armadillo800eva: enable DMAEngine on FSI
Message-Id: <20120611091443.GE22966@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87sje2pkjm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sje2pkjm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jun 10, 2012 at 08:57:52PM -0700, Kuninori Morimoto wrote:
> It is possible to reduce CPU load if FSI playback used DMAEngine.
> This patch enabled it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Tested-by: Simon Horman <horms@verge.net.au>

> ---
>  arch/arm/configs/armadillo800eva_defconfig     |    2 ++
>  arch/arm/mach-shmobile/board-armadillo800eva.c |    2 ++
>  2 files changed, 4 insertions(+), 0 deletions(-)
