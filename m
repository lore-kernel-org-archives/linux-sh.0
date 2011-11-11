From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 11 Nov 2011 07:47:51 +0000
Subject: Re: [PATCH 04/20] ARM: mach-shmobile: sh73a0: add MMC data pin pull-up
Message-Id: <20111111074751.GH29807@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87vcqr9y4b.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vcqr9y4b.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 10, 2011 at 06:44:24PM -0800, Kuninori Morimoto wrote:
> This patch adds MMC data pin pull-up option for pfc-sh73a0.c,
> and select it on ag5evm board.
> The MMC read/write will be error without this patch.
> 
> Cc: Takashi YOSHII <takashi.yoshii.zj@renesas.com>
> Tested-by: Simon Horman <horms@verge.net.au>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Thu, Nov 10, 2011 at 06:44:43PM -0800, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/board-kota2.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)

On Thu, Nov 10, 2011 at 06:45:02PM -0800, Kuninori Morimoto wrote:
> it is not necessary to have sh7372_xxxx index on static variable

On Thu, Nov 10, 2011 at 06:45:12PM -0800, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/board-ap4evb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

On Thu, Nov 10, 2011 at 06:45:23PM -0800, Kuninori Morimoto wrote:
> This patch move PORT_DATA_xx helper macro to sh_pfc.h.
> and pfc-sh7372.c used it

On Thu, Nov 10, 2011 at 06:45:33PM -0800, Kuninori Morimoto wrote:
> This patch moves PORT_xx helper macro to sh_pfc.h,
> and it expects CPU_ALL_PORT() macro for each CPU

On Thu, Nov 10, 2011 at 06:45:43PM -0800, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/pfc-sh7367.c |   16 ----------------
>  arch/arm/mach-shmobile/pfc-sh7372.c |   16 ----------------
>  arch/arm/mach-shmobile/pfc-sh7377.c |   17 -----------------
>  arch/arm/mach-shmobile/pfc-sh73a0.c |   12 ------------
>  include/linux/sh_pfc.h              |   17 +++++++++++++++++
>  5 files changed, 17 insertions(+), 61 deletions(-)

All applied, thanks.
