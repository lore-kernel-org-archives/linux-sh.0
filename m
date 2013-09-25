From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Sep 2013 07:11:58 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: r8a7778: cleanup registration of sh_eth
Message-Id: <20130925071156.GK6663@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <871u4esql9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871u4esql9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 23, 2013 at 11:04:21PM -0700, Kuninori Morimoto wrote:
> sh_eth driver which needs platform data at the time of
> registration is used from BockW only.
> Now, ARM/shmobile aims to support DT,
> and the C code base board support will be removed
> if DT support is completed.
> Current driver registration method which needs platform data
> and which is not shared complicates codes.
> This means legacy C code cleanup after DT supporting
> will be more complicated
> This patch registers it on board code as cleanup C code
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/board-bockw.c          |   14 +++++++++++++-
>  arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 -
>  arch/arm/mach-shmobile/setup-r8a7778.c        |   14 --------------
>  3 files changed, 13 insertions(+), 16 deletions(-)

Thanks, queued up for v3.13.
