From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Thu, 17 Jan 2019 17:57:44 +0000
Subject: Re: [PATCH] sh: Remove duplicate header
Message-Id: <CAFqt6zaHuWfVWS1Aa4MQm-qE9Wjj68Bq5ioEWbk+hrg32VNRCw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5c40acf3.1c69fb81.5b02f.880c@mx.google.com>
In-Reply-To: <5c40acf3.1c69fb81.5b02f.880c@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Brajeswar Ghosh <brajeswar.linux@gmail.com>

On Thu, Jan 17, 2019 at 9:57 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Remove linux/irq.h which is included more than once.
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

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
