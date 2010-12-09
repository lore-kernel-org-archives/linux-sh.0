From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 09 Dec 2010 00:25:12 +0000
Subject: Re: [PATCH] rfc v2: ARM: mach-shmobile: mackerel: Add zboot support
Message-Id: <20101209002512.GB13412@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1291850087-11388-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1291850087-11388-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Dec 09, 2010 at 08:14:47AM +0900, Simon Horman wrote:
> * Use head-mackerel.txt for Mackerel.
>   head-ap4evb.txt was used by mistake.
> 
...

> diff --git a/arch/arm/mach-shmobile/include/mach/zboot.h b/arch/arm/mach-shmobile/include/mach/zboot.h
> index 3ad86b7..994b891 100644
> --- a/arch/arm/mach-shmobile/include/mach/zboot.h
> +++ b/arch/arm/mach-shmobile/include/mach/zboot.h
> @@ -13,6 +13,9 @@
>  #ifdef CONFIG_MACH_AP4EVB
>  #define MACH_TYPE	MACH_TYPE_AP4EVB
>  #include "mach/head-ap4evb.txt"
> +#elif CONFIG_MACH_MACKEREL
> +#define MACH_TYPE	MACH_TYPE_MACKEREL
> +#include "mach/head-ap4evb.txt"
>  #else
>  #error "unsupported board."
>  #endif

Looks like it still does?
