From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 11 Aug 2012 09:39:55 +0000
Subject: Re: [PATCH 14/15] sh: MTU2: Basic runtime PM support
Message-Id: <CAMuHMdUFeS6HNFuKVDLrFEo0f5=jrufa4QoD+aeZJHJD1Q1xCQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201207291612.43138.rjw@sisk.pl>
	<201208060138.03950.rjw@sisk.pl>
	<201208060149.37972.rjw@sisk.pl>
In-Reply-To: <201208060149.37972.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>

On Mon, Aug 6, 2012 at 1:49 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> @@ -341,8 +346,19 @@ static int __devinit sh_mtu2_probe(struc
>         if (ret) {
>                 kfree(p);
>                 platform_set_drvdata(pdev, NULL);
> +               pm_runtime_idle(&pdev->dev);
> +               return ret;
>         }
> -       return ret;
> +       if (is_early_platform_device(pdev))
> +               return 0;
> +
> + out:
> +       if (cfg->clockevent_rating)

drivers/clocksource/sh_mtu2.c:356:6: error: 'cfg' undeclared (first
use in this function)
http://kisskb.ellerman.id.au/kisskb/buildresult/6883515/

Presumably there's a

        struct sh_timer_config *cfg = p->pdev->dev.platform_data;

missing at the top of sh_mtu2_probe()

> +               pm_runtime_irq_safe(&pdev->dev);
> +       else
> +               pm_runtime_idle(&pdev->dev);
> +
> +       return 0;
>  }
>
>  static int __devexit sh_mtu2_remove(struct platform_device *pdev)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
