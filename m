From: Mukesh Ojha <mojha@codeaurora.org>
Date: Wed, 27 Mar 2019 12:21:57 +0000
Subject: Re: [PATCH] sh:mach-dreamcast/irq.c : Remove duplicate header
Message-Id: <91dc8844-f660-b3e6-a38e-94abc1a5b4db@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1553288536-14470-1-git-send-email-jagdsh.linux@gmail.com>
In-Reply-To: <1553288536-14470-1-git-send-email-jagdsh.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jagdsh.linux@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org, akpm@linux-foundation.org, horms+renesas@verge.net.au, kuninori.morimoto.gx@renesas.com
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


On 3/23/2019 2:32 AM, jagdsh.linux@gmail.com wrote:
> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
>
> Remove duplicate header which is included twice.
>
> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>


> ---
>   arch/sh/boards/mach-dreamcast/irq.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/sh/boards/mach-dreamcast/irq.c b/arch/sh/boards/mach-dreamcast/irq.c
> index a929f76..cc06e4c 100644
> --- a/arch/sh/boards/mach-dreamcast/irq.c
> +++ b/arch/sh/boards/mach-dreamcast/irq.c
> @@ -10,7 +10,6 @@
>    */
>   #include <linux/irq.h>
>   #include <linux/io.h>
> -#include <linux/irq.h>
>   #include <linux/export.h>
>   #include <linux/err.h>
>   #include <mach/sysasic.h>
