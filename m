From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Fri, 28 Nov 2008 05:31:09 +0000
Subject: Re: INTC woes on HP Jornada 600-series
Message-Id: <aec7e5c30811272131k779a11c1rf09243afa94af486@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20081128000604.bd017244.kristoffer.ericson@gmail.com>
In-Reply-To: <20081128000604.bd017244.kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Kristoffer,

Your patch seems to be acknowleding external interrupt sources using
the IRR0 register. The intc code is supposed to handle this already,
but maybe there is some case that's not fully covered. I suggest you
look into how ack_registers[] in setup-sh3.c is being used.

/ magnus

On Fri, Nov 28, 2008 at 8:06 AM, Kristoffer Ericson
<kristoffer.ericson@gmail.com> wrote:
> Greetings,
>
> I recall bugging Magnus about adding this patch.
> Rediscoverd it when I couldn't get the Compact Flash
> going (se earlier mail).
> Anyhow, I'm looking for the correct place to put
> this.
>
> With this patch applied, matt's patch works fine.
>
> diff --git a/drivers/sh/intc.c b/drivers/sh/intc.c
> index 58d24c5..8508f89 100644
> --- a/drivers/sh/intc.c
> +++ b/drivers/sh/intc.c
> @@ -230,6 +230,18 @@ static void intc_disable(unsigned int irq)
>                intc_disable_fns[_INTC_MODE(handle)](addr, handle,intc_reg_fns\
>                                                     [_INTC_FN(handle)], irq);
>        }
> +
> +       #ifdef CONFIG_CPU_SUBTYPE_SH7709
> +       /* We need to unmask IRQ0->IRQ5
> +        * to keep the interrupts coming.
> +        * Otherwise we end up with timeouts
> +        * on PCMCIA/CF devices. */
> +       if ((irq > 31) && (irq < 37)) {
> +               cpu = __raw_readb(0xA4000004); /* IRR0 */
> +               cpu &= ~(1 << (irq - 32));
> +               __raw_writeb(cpu, 0xA4000004);
> +       }
> +       #endif
>  }
>
>  #if defined(CONFIG_CPU_SH3) || defined(CONFIG_CPU_SH4A)
>
>
> --
> Kristoffer Ericson <kristoffer.ericson@gmail.com>
>
