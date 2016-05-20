From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 May 2016 08:08:14 +0000
Subject: Re: [PATCH v2 08/12] irqchip: add J-Core AIC driver
Message-Id: <CAMuHMdV_Sg24SqAWnjHtTbbQTSOpf=zWXZ3T6dtM0yKDz8CJkg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
	<2afd392ff334c996970e3a9eacdd5ec5d839b608.1463708766.git.dalias@libc.org>
In-Reply-To: <2afd392ff334c996970e3a9eacdd5ec5d839b608.1463708766.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On Fri, May 20, 2016 at 4:53 AM, Rich Felker <dalias@libc.org> wrote:
> --- /dev/null
> +++ b/drivers/irqchip/irq-jcore-aic.c
> @@ -0,0 +1,95 @@

> +struct aic_data {

static?

> +       unsigned char __iomem *base;
> +       u32 cpu_offset;
> +       struct irq_chip chip;
> +       struct irq_domain *domain;
> +       struct notifier_block nb;
> +} aic_data;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
