From: Jason Cooper <jason@lakedaemon.net>
Date: Tue, 24 Nov 2015 16:56:13 +0000
Subject: Re: [PATCH v2 0/2] irqchip/renesas-intc-irqpin: Remove obsolete platform data support
Message-Id: <20151124165613.GW6520@io.lakedaemon.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1448376581-9202-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448376581-9202-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

Hi Geert,

On Tue, Nov 24, 2015 at 03:49:39PM +0100, Geert Uytterhoeven wrote:
> 	Hi Thomas, Jason, Marc,
> 
> Since commit 4baadb9e05c68962 ("ARM: shmobile: r8a7778: remove obsolete
> setup code"), which is now in v4.4-rc1, all Renesas SoCs with a
> renesas-intc-irqpin module are only supported in generic DT-only ARM
> multi-platform builds.  The driver doesn't need to use platform data anymore,
> hence this series removes platform data configuration, and does a small
> cleanup.
> 
> Changes since v1:
>   - Add Acked-by,
>   - Platform dependency has entered mainline.
> 
> Thanks for applying!
> 
> Geert Uytterhoeven (2):
>   irqchip/renesas-intc-irqpin: Remove obsolete platform data support
>   irqchip/renesas-intc-irqpin: Remove intc_irqpin_priv.number_of_irqs
> 
>  drivers/irqchip/irq-renesas-intc-irqpin.c          | 51 ++++++++--------------
>  .../linux/platform_data/irq-renesas-intc-irqpin.h  | 29 ------------
>  2 files changed, 18 insertions(+), 62 deletions(-)
>  delete mode 100644 include/linux/platform_data/irq-renesas-intc-irqpin.h

Applied to irqchip/core

thx,

Jason.
