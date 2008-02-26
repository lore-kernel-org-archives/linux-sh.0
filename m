From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 26 Feb 2008 05:24:19 +0000
Subject: Re: [PATCH] sh: convert dreamcast irq code to ctrl_in/out
Message-Id: <20080226052419.GG19814@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080220110336.7583.79505.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080220110336.7583.79505.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 20, 2008 at 08:03:36PM +0900, Magnus Damm wrote:
> This patch converts the dreamcast irq code to ctrl_in/out operations. There
> is no point in depending on the value of generic_io_base for code like this.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> Acked-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> ---
> 
>  arch/sh/boards/dreamcast/irq.c |   19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> --- 0001/arch/sh/boards/dreamcast/irq.c
> +++ work/arch/sh/boards/dreamcast/irq.c	2008-02-18 17:02:08.000000000 +0900
> @@ -12,6 +12,7 @@
>  #include <linux/irq.h>
>  #include <asm/io.h>
>  #include <asm/irq.h>
> +#include <asm/addrspace.h>
>  #include <asm/dreamcast/sysasic.h>
>  
>  /* Dreamcast System ASIC Hardware Events -
> @@ -40,8 +41,8 @@
>  
>  */
>  
> -#define ESR_BASE 0x005f6900    /* Base event status register */
> -#define EMR_BASE 0x005f6910    /* Base event mask register */
> +#define ESR_BASE P2SEGADDR(0x005f6900)    /* Base event status register */
> +#define EMR_BASE P2SEGADDR(0x005f6910)    /* Base event mask register */
>  
>  /* Helps us determine the EMR group that this event belongs to: 0 = 0x6910,
>     1 = 0x6920, 2 = 0x6930; also determine the event offset */

ioremap please. P2SEGADDR is going away, so no new code should be using
it.
