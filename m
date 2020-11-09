From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 09 Nov 2020 12:13:33 +0000
Subject: Re: [PATCH v1] sh: Drop ARCH_NR_GPIOS definition
Message-Id: <20201109121333.GC4077@smile.fi.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20201012154050.68039-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201012154050.68039-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-gpio <linux-gpio@vger.kernel.org>

On Mon, Oct 12, 2020 at 06:40:50PM +0300, Andy Shevchenko wrote:
> The default by generic header is the same, hence drop unnecessary definition.

Any comment on this?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/sh/include/asm/gpio.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/sh/include/asm/gpio.h b/arch/sh/include/asm/gpio.h
> index 351918894e86..d643250f0a0f 100644
> --- a/arch/sh/include/asm/gpio.h
> +++ b/arch/sh/include/asm/gpio.h
> @@ -16,7 +16,6 @@
>  #include <cpu/gpio.h>
>  #endif
>  
> -#define ARCH_NR_GPIOS 512
>  #include <asm-generic/gpio.h>
>  
>  #ifdef CONFIG_GPIOLIB
> -- 
> 2.28.0
> 

-- 
With Best Regards,
Andy Shevchenko
