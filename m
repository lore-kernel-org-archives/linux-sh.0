From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Jun 2014 08:00:17 +0000
Subject: Re: [PATCH] ARM: shmobile: Enable genmai board in multiplatform defconfig
Message-Id: <20140625080017.GB10050@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1402915783-25444-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1402915783-25444-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 16, 2014 at 07:49:43PM +0900, Simon Horman wrote:
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/configs/shmobile_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> index 291b1c2..afe8f46 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -10,9 +10,11 @@ CONFIG_PERF_EVENTS=y
>  CONFIG_SLAB=y
>  CONFIG_ARCH_SHMOBILE_MULTI=y
>  CONFIG_ARCH_EMEV2=y
> +CONFIG_ARCH_R7S72100=y
>  CONFIG_ARCH_R8A7779=y
>  CONFIG_ARCH_R8A7790=y
>  CONFIG_ARCH_R8A7791=y
> +CONFIG_MACH_GENMAI=y
>  CONFIG_MACH_KOELSCH=y
>  CONFIG_MACH_LAGER=y
>  CONFIG_MACH_MARZEN=y
> -- 
> 2.0.0.rc2
> 

I have queued this up.
