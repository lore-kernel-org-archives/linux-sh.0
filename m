From: Mukesh Ojha <mojha@codeaurora.org>
Date: Thu, 28 Mar 2019 06:50:56 +0000
Subject: Re: [PATCH] arch:sh:mach-sh03/rtc.c : Remove duplicate header
Message-Id: <b85268d2-939f-f012-ce3d-b6689dffe254@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1553721642-38293-1-git-send-email-jagdsh.linux@gmail.com>
In-Reply-To: <1553721642-38293-1-git-send-email-jagdsh.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jagdsh.linux@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org, paul.burton@mips.com, arnd@arndb.de
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


On 3/28/2019 2:50 AM, jagdsh.linux@gmail.com wrote:
> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
>
> Remove duplicate header which is included twice.
>
> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh


> ---
>   arch/sh/boards/mach-sh03/rtc.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/sh/boards/mach-sh03/rtc.c b/arch/sh/boards/mach-sh03/rtc.c
> index 8b23ed7..165e2cc 100644
> --- a/arch/sh/boards/mach-sh03/rtc.c
> +++ b/arch/sh/boards/mach-sh03/rtc.c
> @@ -14,7 +14,6 @@
>   #include <linux/rtc.h>
>   #include <linux/spinlock.h>
>   #include <linux/io.h>
> -#include <linux/rtc.h>
>   #include <linux/platform_device.h>
>   
>   #define RTC_BASE	0xb0000000
