From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 28 Jul 2014 12:08:56 +0000
Subject: Re: [GIT PULL] Renesas rcar-audmapp Driver Updates for v3.17
Message-Id: <20140728115656.GC8181@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1405401560.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1405401560.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 15, 2014 at 07:51:05PM +0900, Simon Horman wrote:
> Hi Vinod
> 
> Please consider pulling these Renesas rcar-audmapp Driver Updates for v3.17
> 
> 
> The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
> 
>   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-rcar-audmapp-for-v3.17

Merged now

Thanks
-- 
~Vinod
> 
> for you to fetch changes up to caf18c27ddb2fb8ae2a7591b908e7efb7484e459:
> 
>   dma: rcar-audmapp: add DT support (2014-07-11 13:35:08 +0200)
> 
> ----------------------------------------------------------------
> Renesas rcar-audmapp Driver Updates for v3.17
> 
> * Add DT support to rcar-audmapp driver
> 
> ----------------------------------------------------------------
> Kuninori Morimoto (3):
>       dma: rcar-audmapp: enable .set_slave
>       dma: rcar-audmapp: don't keep audmapp_slave_config for each channeles
>       dma: rcar-audmapp: add DT support
> 
>  .../devicetree/bindings/dma/rcar-audmapp.txt       |  29 ++++++
>  drivers/dma/sh/rcar-audmapp.c                      | 114 +++++++++++++++------
>  2 files changed, 113 insertions(+), 30 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/rcar-audmapp.txt
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
