From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 20 May 2020 01:10:34 +0000
Subject: Re: [PATCH] sh: include linux/time_types.h for sockios
Message-Id: <20200519181034.58c67eb5bea24aae24d33421@linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20200519131327.1836482-1-arnd@arndb.de>
In-Reply-To: <20200519131327.1836482-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 19 May 2020 15:13:13 +0200 Arnd Bergmann <arnd@arndb.de> wrote:

> Using the socket ioctls on arch/sh (and only there) causes build
> time problems when __kernel_old_timeval/__kernel_old_timespec are
> not already visible to the compiler.
> 
> Add an explict include line for the header that defines these
> structures.

I can grab this.

> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Fixes: 8c709f9a0693 ("y2038: sh: remove timeval/timespec usage from headers")
> Fixes: 0768e17073dc ("net: socket: implement 64-bit timestamps")

cc:stable?

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/sh/include/uapi/asm/sockios.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/sh/include/uapi/asm/sockios.h b/arch/sh/include/uapi/asm/sockios.h
> index 3da561453260..ef01ced9e169 100644
> --- a/arch/sh/include/uapi/asm/sockios.h
> +++ b/arch/sh/include/uapi/asm/sockios.h
> @@ -2,6 +2,8 @@
>  #ifndef __ASM_SH_SOCKIOS_H
>  #define __ASM_SH_SOCKIOS_H
>  
> +#include <linux/time_types.h>
> +
>  /* Socket-level I/O control calls. */
>  #define FIOGETOWN	_IOR('f', 123, int)
>  #define FIOSETOWN 	_IOW('f', 124, int)
