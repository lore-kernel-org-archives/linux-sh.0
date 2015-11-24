From: Jason Cooper <jason@lakedaemon.net>
Date: Tue, 24 Nov 2015 16:56:55 +0000
Subject: Re: [PATCH] irqchip/renesas-intc-irqpin: Improve clock error handling and reporting
Message-Id: <20151124165655.GX6520@io.lakedaemon.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1448377693-19597-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448377693-19597-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Geert,

On Tue, Nov 24, 2015 at 04:08:13PM +0100, Geert Uytterhoeven wrote:
> If the Renesas External IRQ Pin driver cannot find a functional clock,
> it prints a warning, .e.g.
> 
>     renesas_intc_irqpin fe78001c.interrupt-controller: unable to get clock
> 
> and continues, as the clock is optional, depending on the SoC type.
> This warning may confuse users.
> 
> To fix this, add a flag to indicate that the clock is mandatory or
> optional, and add a few more compatible entries:
>   - If the clock is mandatory (on R-Mobile A1 or SH-Mobile AG5), a
>     missing clock is now treated as a fatal error,
>   - If the clock is optional (on R-Car Gen1, or using the generic
>     "renesas,intc-irqpin" compatible value), the warning is no longer
>     printed.
> 
> This requires making struct intc_irqpin_irlm_config more generic by
> renaming it to intc_irqpin_config, and adding a flag to indicate if IRLM
> is needed.
> The new clock flag is merged with the existing shared_irqs boolean into
> a bitfield to save space.
> 
> Suggested-by: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Tested on
>   - r8a7779/marzen (no functional clock),
>   - r8a7740/armadillo (with and without mandatory functional clock),
>   - sh73a0/kzm9g (with and without mandatory functional clock).
> 
>  drivers/irqchip/irq-renesas-intc-irqpin.c | 45 ++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 12 deletions(-)

Applied to irqchip/core.

thx,

Jason.
