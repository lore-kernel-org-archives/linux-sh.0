From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Jun 2012 02:11:20 +0000
Subject: Re: [PATCH 3/6] ARM: mach-shmobile: armadillo800eva: Add backlight support
Message-Id: <20120618021119.GB17850@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87lima4lxy.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lima4lxy.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 15, 2012 at 05:17:04PM +0200, Laurent Pinchart wrote:
> The flat panel backlight on the Armadillo 800 EVA board is driven by the
> TPU PWM output.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Tested-by: Simon Horman <horms@verge.net.au>

> ---
>  arch/arm/mach-shmobile/board-armadillo800eva.c |   51 ++++++++++++++++++++++--
>  1 files changed, 47 insertions(+), 4 deletions(-)
