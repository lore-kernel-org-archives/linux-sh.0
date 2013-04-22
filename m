From: Simon Horman <horms@verge.net.au>
Date: Mon, 22 Apr 2013 05:24:51 +0000
Subject: Re: [PATCH 3/3 v3] ARM: shmobile: bockw: add SDHI0 support
Message-Id: <20130422052449.GC16026@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8738uwpavc.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738uwpavc.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 18, 2013 at 08:09:32PM -0700, Kuninori Morimoto wrote:
> This patch is directly accessing to PUPR4 register which can
> control SDHI0 CD/WP pin pull-up setting.
> It should be replaced in the future.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v2 -> v3
> 
>  - used new sdhi pinctrl
> 
>  arch/arm/mach-shmobile/board-bockw.c |   35 ++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

I have merged the pinmux branch into the boards-bockw branch
and queued-up this patch for v3.11 there.
