From: Simon Horman <horms@verge.net.au>
Date: Sat, 16 Apr 2011 00:38:01 +0000
Subject: Re: [PATCH 2/2] sh: update SDHI configuration symbols in defconfigs
Message-Id: <20110416003801.GB25864@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1104152003190.18593@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1104152003190.18593@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 15, 2011 at 08:04:12PM +0200, Guennadi Liakhovetski wrote:
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <damm@opensource.se>
> ---
>  arch/sh/configs/ecovec24_defconfig  |    2 +-
>  arch/sh/configs/sh7757lcr_defconfig |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

MMC_TMIO is also present in arch/arm/configs/eseries_pxa_defconfig
Should that also be updated?
