From: Rob Herring <robherring2@gmail.com>
Date: Fri, 13 Jan 2012 22:02:47 +0000
Subject: Re: [RFC PATCH 04/10] ARM: it8152: explicitly include mach/irqs.h
Message-Id: <4F10AA07.8010803@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
 <1326472451-9002-5-git-send-email-robherring2@gmail.com>
In-Reply-To: <1326472451-9002-5-git-send-email-robherring2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 01/13/2012 10:34 AM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> In preparation to make mach/irqs.h optional, directly include mach/irq.h
> to get IRQ_BOARD_START.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/include/asm/hardware/it8152.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/hardware/it8152.h b/arch/arm/include/asm/hardware/it8152.h
> index 43cab49..73f84fa 100644
> --- a/arch/arm/include/asm/hardware/it8152.h
> +++ b/arch/arm/include/asm/hardware/it8152.h
> @@ -9,6 +9,9 @@
>  
>  #ifndef __ASM_HARDWARE_IT8152_H
>  #define __ASM_HARDWARE_IT8152_H
> +
> +#include <mach/irqs.h>
> +

This include is needed for IRQ_BOARD_START which could also be
problematic outside a single mach dir. The IT8152 is only used on 1
family of pxa2xx boards. The part and board with it are EOL as well, so
we're not going to see new users of this code. Perhaps the it8152 code
should just be moved into mach-pxa?

Rob
