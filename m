From: Jason Cooper <jason@lakedaemon.net>
Date: Thu, 21 Aug 2014 12:45:50 +0000
Subject: Re: [PATCH] irqchip: renesas-intc-irqpin: Add suspend-to-RAM wake up support
Message-Id: <20140821124550.GX12769@titan.lakedaemon.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1408546172-22484-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1408546172-22484-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Geert,

On Wed, Aug 20, 2014 at 04:49:32PM +0200, Geert Uytterhoeven wrote:
> Set the ->irq_enable() and ->irq_disable() methods to NULL to enable
> lazy disable of interrupts, and set IRQCHIP_MASK_ON_SUSPEND to tell the
> core that only IRQs marked as wake-ups need to stay enabled during
> suspend-to-RAM.
> 
> This makes wake-up by gpio-keys from suspend-to-RAM work on
> r8a7740/Armadillo.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Not tested on sh73a0/kzm9g, r8a7778/bock-w, r8a7779/marzen
> 
> Similar changes for gpio-rcar and renesas-irqc went in before, but
> split in two parts:
>   - commit 272012d0f748de2e ("irqchip: renesas-irqc: Use lazy disable")
>   - commit 6a7e3b3007b5396a ("irqchip: renesas-irqc: Enable mask on suspend")
>   - commit fba968a1e6b84be0 ("gpio: rcar: Use lazy disable")
>   - commit 403961120667bed7 ("gpio: rcar: Enable mask on suspend")
> 
> However, I believe it doesn't make much sense to split this:
>   - Enabling lazy disable on its own introduces a regression, as it
>     causes the system to wake-up on IRQs not marked as wake-ups,
>   - Adding IRQCHIP_MASK_ON_SUSPEND on its own doesn't have any impact.
> ---
>  drivers/irqchip/irq-renesas-intc-irqpin.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied to irqchip/core

thx,

Jason.
