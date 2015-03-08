From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 08 Mar 2015 10:07:02 +0000
Subject: Re: [PATCH 05/11] ARM: shmobile: r8a7793: add power management support
Message-Id: <CAMuHMdU9-DjXbkVCkbh-WvTFUvtza439hgDPf-MPvv=9qH6ZQQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-6-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-6-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 6, 2015 at 6:09 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> +#ifdef CONFIG_PM
> +
> +#define CPG_BASE 0xe6150000
> +#define CPG_LEN 0x1000

[...]

> +static void r8a7793_init_pm_domain(struct r8a7793_pm_domain *r8a7793_pd)
> +{
> +       struct generic_pm_domain *genpd = &r8a7793_pd->genpd;
> +
> +       pm_genpd_init(genpd, NULL, true);
> +       genpd->dev_ops.stop = pm_clk_suspend;
> +       genpd->dev_ops.start = pm_clk_resume;
> +       genpd->dev_ops.active_wakeup = pd_active_wakeup;
> +       genpd->power_off = pd_power_down;
> +       genpd->power_on = pd_power_up;
> +
> +       bus_register_notifier(&platform_bus_type, &platform_nb);
> +}
> +
> +static struct r8a7793_pm_domain r8a7793_pm_domains[] = {
> +       {
> +               .genpd.name = "pvrsrvkm",
> +               .ch = {
> +                       .chan_offs = 0xc0,      /* PWRSR2 .. PWRER2 */
> +                       .isr_bit = 20,          /* SGX */
> +               },
> +       },
> +};
> +
> +void __init r8a7793_init_pm_domains(void)
> +{
> +       int j;
> +
> +       for (j = 0; j < ARRAY_SIZE(r8a7793_pm_domains); j++)
> +               r8a7793_init_pm_domain(&r8a7793_pm_domains[j]);
> +}

[...]

> +static struct notifier_block platform_nb = {
> +       .notifier_call = r8a7793_pm_notifier_call,
> +};

This PM domain implementation definitely needs to be converted to DT before
it can be accepted upstream.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
