From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Jun 2015 07:30:20 +0000
Subject: Re: [PATCH 2/2] PM / Domains: Avoid infinite loops in attach/detach code
Message-Id: <CAMuHMdVoHM=K-hgide0-2gpuAZgTkEqLAzhCGuGLHtEMtpAgyw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1434622954-26747-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1434622954-26747-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 18, 2015 at 12:22 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> If pm_genpd_{add,remove}_device() keeps on failing with -EAGAIN, we end
> up with an infinite loop in genpd_dev_pm_{at,de}tach().
>
> This may happen due to a genpd.prepared_count imbalance.  This is a bug
> elsewhere, but it will result in a system lock up, possibly during
> reboot of an otherwise functioning system.
>
> To avoid this, put a limit on the maximum number of loop iterations,
> including a simple back-off mechanism.  If the limit is reached, the
> operation will just fail.  An error message is already printed.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/base/power/domain.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index cdd547bd67df8218..aa06f60b98b8af35 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c

> @@ -2218,10 +2226,13 @@ int genpd_dev_pm_attach(struct device *dev)
>
>         dev_dbg(dev, "adding to PM domain %s\n", pd->name);
>
> -       while (1) {
> +       for (i = 0; i < GENPD_RETRIES; i++) {

Sorry, there's a declaration of "i" missing.

>                 ret = pm_genpd_add_device(pd, dev);
>                 if (ret != -EAGAIN)
>                         break;
> +
> +               if (i > GENPD_RETRIES / 2)
> +                       udelay(GENPD_DELAY_US);
>                 cond_resched();
>         }
>
> --
> 1.9.1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
