From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Wed, 28 Mar 2012 04:41:43 +0000
Subject: Re: [PATCH] sh/next: Fix build fail by asm/system.h in asm/bitops.h
Message-Id: <4F729687.9030606@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1331010429-29574-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1331010429-29574-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Guennadi Liakhovetski さんは書きました:
> On Fri, 9 Mar 2012, Nobuhiro Iwamatsu wrote:
> 
>> Paul Mundt さんは書きました:
>>> On Tue, Mar 06, 2012 at 02:07:09PM +0900, Nobuhiro Iwamatsu wrote:
>>>> Other files are not done include definitely by asm/system.h made
>>>> include in asm/bitops.h.
>>>> This patch remove asm/system.h from asm/bitops.h.
>>>>
>>> Which defconfig were you using that hit this? asm/system.h is usually
>>> included for a reason, although I can't remember off the top of my head
>>> what's used out of it and on what CPU configuration, but I would be
>>> rather hesitant to yank it out on an N of 1 build test.
>>>
>> Sorry, I checked sh7785lcr and ap325rxa and other.
>> We can confirm this problem in linux-next.
> 
> This breakage is now in the mainline too, please, fix. Paul, if you're 
> concerned about removing asm/system.h, the below diff preserves it in 
> asm/bitops.h, but is much uglier, so, I hope the original patch gets 
> applied.
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 
> diff --git a/arch/sh/include/asm/bitops.h b/arch/sh/include/asm/bitops.h
> index 90fa3e4..53323fc 100644
> --- a/arch/sh/include/asm/bitops.h
> +++ b/arch/sh/include/asm/bitops.h
> @@ -7,7 +7,6 @@
>  #error only <linux/bitops.h> can be included directly
>  #endif
>  
> -#include <asm/system.h>
>  /* For __swab32 */
>  #include <asm/byteorder.h>
>  
> @@ -100,6 +99,8 @@ static inline unsigned long ffz(unsigned long word)
>  #include <asm-generic/bitops/__fls.h>
>  #include <asm-generic/bitops/fls64.h>
>  
> +static unsigned fls_long(unsigned long l);
> +#include <asm/system.h>
>  #endif /* __KERNEL__ */
>  
>  #endif /* __ASM_SH_BITOPS_H */
> 

Tested-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
