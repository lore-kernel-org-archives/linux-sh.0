From: Simon Horman <horms@verge.net.au>
Date: Thu, 03 Oct 2013 04:12:34 +0000
Subject: Re: [PATCH 1/4 v2] ARM: shmobile: r8a7778: split r8a7778_init_irq_extpin() for DT
Message-Id: <20131003041232.GE7925@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87had0ysye.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87had0ysye.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 02, 2013 at 01:31:40AM -0700, Kuninori Morimoto wrote:
> r8a7778 INTC needs IRL pin mode settings to determine
> behavior of IRQ0 - IRQ3, and r8a7778_init_irq_extpin()
> is controlling it via irlm parameter.
> But this function registers renesas_intc_irqpin driver
> if irlm was set, and this value depends on platform.
> This is not good for DT.
> This patch splits r8a7778_init_irq_extpin() function
> into "mode settings" and "funtion register" parts.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
> 
>  - no change
> 
>  arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 +
>  arch/arm/mach-shmobile/setup-r8a7778.c        |    6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)

Thanks, I have queued this up in the soc3 branch.
It should make it into v3.13 but if not I'll rename the branch
soc after rebasing it on v3.13-rcX which will then be targeted at v3.14.
