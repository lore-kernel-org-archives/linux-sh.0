From: Rich Felker <dalias@libc.org>
Date: Wed, 18 Dec 2019 16:49:01 +0000
Subject: Re: [PATCH] y2038: sh: remove timeval/timespec usage from headers
Message-Id: <20191218164901.GN1666@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20191218164527.542823-1-arnd@arndb.de>
In-Reply-To: <20191218164527.542823-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 05:45:11PM +0100, Arnd Bergmann wrote:
> This header file escaped my earlier cleanups for removing
> the in-kernel usage of timeval and timespec structs.
> 
> Replace them with the corresponding __kernel_old_* types.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Rich Felker <dalias@libc.org>

> ---
>  arch/sh/include/uapi/asm/sockios.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/include/uapi/asm/sockios.h b/arch/sh/include/uapi/asm/sockios.h
> index ef18a668456d..3da561453260 100644
> --- a/arch/sh/include/uapi/asm/sockios.h
> +++ b/arch/sh/include/uapi/asm/sockios.h
> @@ -10,7 +10,7 @@
>  #define SIOCSPGRP	_IOW('s', 8, pid_t)
>  #define SIOCGPGRP	_IOR('s', 9, pid_t)
>  
> -#define SIOCGSTAMP_OLD	_IOR('s', 100, struct timeval) /* Get stamp (timeval) */
> -#define SIOCGSTAMPNS_OLD _IOR('s', 101, struct timespec) /* Get stamp (timespec) */
> +#define SIOCGSTAMP_OLD	_IOR('s', 100, struct __kernel_old_timeval) /* Get stamp (timeval) */
> +#define SIOCGSTAMPNS_OLD _IOR('s', 101, struct __kernel_old_timespec) /* Get stamp (timespec) */
>  
>  #endif /* __ASM_SH_SOCKIOS_H */
> -- 
> 2.20.0
