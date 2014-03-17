From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Date: Mon, 17 Mar 2014 11:33:19 +0000
Subject: Re: [Linux-kernel] [RFC 3/6] ARM: shmobile: add sh_pm_runtime_init() to header
Message-Id: <1395055999.12161.116.camel@xylophone>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, 2014-03-17 at 11:15 +0000, Ben Dooks wrote:
> Add definition of sh_pm_runtime_init() to machine header to allow calling

declaration not definition

> the pm_runtime initialisation code.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/mach-shmobile/include/mach/common.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
> index cb8e32d..4727d4f 100644
> --- a/arch/arm/mach-shmobile/include/mach/common.h
> +++ b/arch/arm/mach-shmobile/include/mach/common.h
> @@ -52,4 +52,6 @@ static inline void __init shmobile_init_late(void)
>  	shmobile_cpuidle_init();
>  }
>  
> +extern int sh_pm_runtime_init(void);
> +
>  #endif /* __ARCH_MACH_COMMON_H */

The declaration should include '__init' and need not include 'extern'.

I would fold this into the previous patch.

Ben.


