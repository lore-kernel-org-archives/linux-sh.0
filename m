From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Jan 2017 10:24:43 +0000
Subject: Re: [PATCH 1/3] sh/intc: Use kcalloc() in register_intc_controller()
Message-Id: <CAMuHMdUKmu1BUE7EhAsg7a4Gn+RJAFgp-1-Pc=Weh7dXEbwdaA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4d37c4d8-d28b-bd98-968b-f544d6a213eb@users.sourceforge.net> <6f6f99f6-26f0-d002-ca85-d974d71aa518@users.sourceforge.net>
In-Reply-To: <6f6f99f6-26f0-d002-ca85-d974d71aa518@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, LKML <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>

Hi Markus,

On Fri, Jan 13, 2017 at 10:48 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> --- a/drivers/sh/intc/core.c
> +++ b/drivers/sh/intc/core.c

> @@ -253,7 +253,8 @@ int __init register_intc_controller(struct intc_desc *desc)
>         }
>
>         if (hw->prio_regs) {
> -               d->prio = kzalloc(hw->nr_vectors * sizeof(*d->prio),
> +               d->prio = kcalloc(hw->nr_vectors,
> +                                 sizeof(*d->prio),

Please don't split lines without a good reason.

>                                   GFP_NOWAIT);

In this particular case, I'd even use the opportunity to merge the above line
with the previous one instead, now it fits in 80 characters ;-)

>                 if (!d->prio)
>                         goto err4;
> @@ -269,7 +270,8 @@ int __init register_intc_controller(struct intc_desc *desc)
>         }
>
>         if (hw->sense_regs) {
> -               d->sense = kzalloc(hw->nr_vectors * sizeof(*d->sense),
> +               d->sense = kcalloc(hw->nr_vectors,
> +                                  sizeof(*d->sense),

Likewise

>                                    GFP_NOWAIT);
>                 if (!d->sense)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
