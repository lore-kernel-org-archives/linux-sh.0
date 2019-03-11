From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Mon, 11 Mar 2019 16:17:50 +0000
Subject: Re: [PATCH] arch/sh/boards/mach-dreamcast/irq.c: Remove duplicate header
Message-Id: <CAFqt6zY2uWNke8JmyEiS+yiXLC43ZQA_wpv=YgCj-cHbBPXp0A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5c8682ef.1c69fb81.5a1ea.2e7f@mx.google.com>
In-Reply-To: <5c8682ef.1c69fb81.5a1ea.2e7f@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 9:16 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Remove  linux/irq.h which is included more than once.
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Acked-by : Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  arch/sh/boards/mach-dreamcast/irq.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/sh/boards/mach-dreamcast/irq.c b/arch/sh/boards/mach-dreamcast/irq.c
> index 2789647..69fa91c 100644
> --- a/arch/sh/boards/mach-dreamcast/irq.c
> +++ b/arch/sh/boards/mach-dreamcast/irq.c
> @@ -10,7 +10,6 @@
>   */
>  #include <linux/irq.h>
>  #include <linux/io.h>
> -#include <linux/irq.h>
>  #include <linux/export.h>
>  #include <linux/err.h>
>  #include <mach/sysasic.h>
> --
> 2.7.4
>
