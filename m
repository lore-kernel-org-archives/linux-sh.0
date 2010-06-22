From: Pekka Enberg <penberg@cs.helsinki.fi>
Date: Tue, 22 Jun 2010 08:11:24 +0000
Subject: Re: [PATCH] mm: kmemleak: Change kmemleak default buffer size
Message-Id: <4C20702C.1080405@cs.helsinki.fi>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTimb7rP0rS0OU8nan5uNEhHx_kEYL99ImZ3c8o0D@mail.gmail.com> <1277189909-16376-1-git-send-email-sankar.curiosity@gmail.com>
In-Reply-To: <1277189909-16376-1-git-send-email-sankar.curiosity@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sankar P <sankar.curiosity@gmail.com>
Cc: linux-kernel@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org, lrodriguez@atheros.com, catalin.marinas@arm.com, rnagarajan@novell.com, teheo@novell.com, linux-mm@kvack.org

Sankar P wrote:
> If we try to find the memory leaks in kernel that is
> compiled with 'make defconfig', the default buffer size
> seem to be inadequate. Change the buffer size from
> 400 to 1000, which is sufficient in most cases.
> 
> Signed-off-by: Sankar P <sankar.curiosity@gmail.com>
> ---
>  arch/sh/configs/sh7785lcr_32bit_defconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/sh/configs/sh7785lcr_32bit_defconfig b/arch/sh/configs/sh7785lcr_32bit_defconfig
> index 71f39c7..b02e5ae 100644
> --- a/arch/sh/configs/sh7785lcr_32bit_defconfig
> +++ b/arch/sh/configs/sh7785lcr_32bit_defconfig
> @@ -1710,7 +1710,7 @@ CONFIG_SCHEDSTATS=y
>  # CONFIG_DEBUG_OBJECTS is not set
>  # CONFIG_DEBUG_SLAB is not set
>  CONFIG_DEBUG_KMEMLEAK=y
> -CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE@0
> +CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE00
>  # CONFIG_DEBUG_KMEMLEAK_TEST is not set
>  CONFIG_DEBUG_PREEMPT=y
>  # CONFIG_DEBUG_RT_MUTEXES is not set

I'm pretty sure you want to do this change in lib/Kconfig.debug.
