From: "Luis R. Rodriguez" <lrodriguez@atheros.com>
Date: Tue, 22 Jun 2010 16:55:09 +0000
Subject: Re: [PATCH] mm: kmemleak: Change kmemleak default buffer size
Message-Id: <20100622165509.GB11336@tux>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTimb7rP0rS0OU8nan5uNEhHx_kEYL99ImZ3c8o0D@mail.gmail.com>
 <1277189909-16376-1-git-send-email-sankar.curiosity@gmail.com>
In-Reply-To: <1277189909-16376-1-git-send-email-sankar.curiosity@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sankar P <sankar.curiosity@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lethal@linux-sh.org" <lethal@linux-sh.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Luis Rodriguez <Luis.Rodriguez@Atheros.com>, "penberg@cs.helsinki.fi" <penberg@cs.helsinki.fi>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "rnagarajan@novell.com" <rnagarajan@novell.com>, "teheo@novell.com" <teheo@novell.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>

On Mon, Jun 21, 2010 at 11:58:29PM -0700, Sankar P wrote:
> If we try to find the memory leaks in kernel that is
> compiled with 'make defconfig', the default buffer size
> seem to be inadequate. Change the buffer size from
> 400 to 1000, which is sufficient in most cases.
> 
> Signed-off-by: Sankar P <sankar.curiosity@gmail.com>

What's your full name? Please read the "Developer's Certificate of Origin 1.1"
It says:

then you just add a line saying

        Signed-off-by: Random J Developer <random@developer.example.org>

using your real name (sorry, no pseudonyms or anonymous contributions.)


Also you may want to post on a new thread instead of using this old thread
unless the maintainer is reading this and wants to pick it up.

  Luis

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
> -- 
> 1.6.4.2
> 
