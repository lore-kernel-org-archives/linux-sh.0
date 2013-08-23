From: Simon Horman <horms@verge.net.au>
Date: Fri, 23 Aug 2013 00:16:12 +0000
Subject: Re: [PATCH] ARM: shmobile: lager: Fix Display Unit platform data
Message-Id: <20130823001612.GF9254@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1377186908-30428-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1377186908-30428-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 22, 2013 at 05:55:08PM +0200, Laurent Pinchart wrote:
> The DU device erroneously receives the DU resources array as platform
> data instead of the DU platform data structure. Fix it.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/mach-shmobile/board-lager.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Hi Simon,
> 
> This patch fixes a bug introduced by
> 
> commit f631fa0e380a76504bd65545ed094f04b5c6559a
> Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Date:   Tue Apr 16 12:39:11 2013 +0200
> 
>     ARM: shmobile: lager: Add Display Unit support
>     
>     Only the VGA output is currently supported.
>     
>     Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>     Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>     Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Can you squash it into the faulty commit, or push it on top and make sure it
> will got to mainline at the same time ?

Hi Laurent,

I will push the following and include it in the same pull request as
the patch that introduced the problem.

commit 8034dc4a1d615c84932c74633b7399603f7cc2a4
Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date:   Thu Aug 22 17:55:08 2013 +0200

    ARM: shmobile: lager: Fix Display Unit platform data
    
    The DU device erroneously receives the DU resources array as platform
    data instead of the DU platform data structure. Fix it.
    
    This problem was introduced by f631fa0 ("ARM: shmobile: lager: Add Display
    Unit support").
    
    Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
    Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 5facfc9..bfca58b 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -87,8 +87,8 @@ static void __init lager_add_du_device(void)
 		.id = -1,
 		.res = du_resources,
 		.num_res = ARRAY_SIZE(du_resources),
-		.data = &du_resources,
-		.size_data = sizeof(du_resources),
+		.data = &lager_du_pdata,
+		.size_data = sizeof(lager_du_pdata),
 		.dma_mask = DMA_BIT_MASK(32),
 	};
 

