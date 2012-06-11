From: Simon Horman <horms@verge.net.au>
Date: Mon, 11 Jun 2012 07:58:52 +0000
Subject: Re: [PATCH 25/27] ARM: shmobile: sh73a0: add FSI clock
Message-Id: <20120611075850.GD30048@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87mx4apkhn.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mx4apkhn.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jun 10, 2012 at 08:59:04PM -0700, Kuninori Morimoto wrote:
> This patch is required from FSI sound driver
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Tested-by: Simon Horman <horms@verge.net.au>

> ---
>  arch/arm/mach-shmobile/clock-sh73a0.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
