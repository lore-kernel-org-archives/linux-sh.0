From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Jun 2012 00:48:34 +0000
Subject: Re: [PATCH 10/27 v2] ARM: shmobile: r8a7740: add MERAM work-around
Message-Id: <20120613004833.GQ16686@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87sje0x46l.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sje0x46l.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 12, 2012 at 02:36:21AM -0700, Kuninori Morimoto wrote:
> r8a7740 chip has lasting errata on MERAM buffer, and this patch adds
> its work-around on setup-r8a7740.c
> It solved CEU/VIO6C/2D-DMAC/VCP1/VPU5F/JPU/DISP memroy access error.
> 
> But MERAM driver can't control this issue,
> since this work-around requires access to non-MERAM register address.
> So, This it will be called as board specific code at this point.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

As I tested v1 of this patch:

Tested-by: Simon Horman <horms@verge.net.au>

> ---
> v1 -> v2
> 
>  - no change
> 
>  arch/arm/mach-shmobile/board-armadillo800eva.c |    1 +
>  arch/arm/mach-shmobile/include/mach/common.h   |    1 +
>  arch/arm/mach-shmobile/setup-r8a7740.c         |   18 ++++++++++++++++++
>  3 files changed, 20 insertions(+), 0 deletions(-)
