From: Simon Horman <horms@verge.net.au>
Date: Tue, 24 Dec 2013 06:02:28 +0000
Subject: Re: [PATCH 0/3][resend] ARM: shmobile: bockw: add DMAEngine support
Message-Id: <20131224060226.GA23838@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8761qeg8p3.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <8761qeg8p3.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 23, 2013 at 08:43:39PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> HPB-DMAC fixup patches are applied to linus/master branch.
> (renesas-devel-v3.13-rc5-20131223 have these too)
> These are re-send of DMAEngine support for BockW

Hi Morimoto-san,

can I confirm that you are referring to the following patches
which appeared in v3.13-rc4?


commit 5affdeea8fd07f89709d39585ec47fb29f73247c
Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date:   Mon Oct 28 23:52:21 2013 -0700

    rcar-hpbdma: initialise plane information when halted
    
    Plane information should be initialized when halted.
    It may restart from the wrong plane without this patch.
    
    Reviewed-by: Max Filippov <max.filippov@cogentembedded.com>
    Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    Acked-by: Simon Horman <horms+renesas@verge.net.au>
    Signed-off-by: Vinod Koul <vinod.koul@intel.com>

commit b3000cd835a6116c0a7d0f8e3df5be26c2138d86
Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date:   Mon Oct 28 23:52:34 2013 -0700

    rcar-hpbdma: fixup channel busy check for double plane
    
    The device busy check method is different between
    single and double planes.
    It will always return "busy" without this patch
    if channel used as double plane.
    
    Reviewed-by: Max Filippov <max.filippov@cogentembedded.com>
    Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    Acked-by: Simon Horman <horms+renesas@verge.net.au>
    Signed-off-by: Vinod Koul <vinod.koul@intel.com>

commit f1eab074df85a05dabfd368b6f64e7de63070301
Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date:   Mon Oct 28 23:52:01 2013 -0700

    rcar-hpbdma: add max transfer size
    
    shdma_chan_probe() can set max transfer size,
    but it will be PAGE_SIZE with out this patch.
    
    Reviewed-by: Max Filippov <max.filippov@cogentembedded.com>
    Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    Acked-by: Simon Horman <horms+renesas@verge.net.au>
    Signed-off-by: Vinod Koul <vinod.koul@intel.com>

> 
> Kuninori Morimoto (3):
>       ARM: shmobile: bockw: use SSI DMAEngine for sound
>       ARM: shmobile: bockw: use HPBIF DMAEngine for sound
>       ARM: shmobile: bockw: add USB Func DMAEngine support
> 
>  arch/arm/mach-shmobile/board-bockw.c |   24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> Best regards
> ---
> Kuninori Morimoto
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
