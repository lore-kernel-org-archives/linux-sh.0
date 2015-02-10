From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Feb 2015 08:53:51 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: Add support SOC_BUS to R-Car Gen2
Message-Id: <CAMuHMdWhFVjy2ec=65PDuabfgJaG62U=xdJwJ3LmJ7RgABcHfw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423186389-12861-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1423186389-12861-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Iwamatsu-san,

On Fri, Feb 6, 2015 at 2:33 AM, Nobuhiro Iwamatsu
<nobuhiro.iwamatsu.yj@renesas.com> wrote:
> This provides information through SOC_BUS to sysfs.

Thanks for your patch!

> diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
> index 2230948..0fa3ef8 100644
> --- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
> +++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c

> @@ -204,19 +206,53 @@ void __init rcar_gen2_reserve(void)
>  }
>
>  #define PRR 0xFF000044
> -static unsigned int __init rcar_gen2_get_revision(void)
> +static unsigned int __init rcar_gen2_get_prr(void)
>  {
>         void __iomem *addr = ioremap_nocache(PRR, 4);
>         u32 data = ioread32(addr);
>
>         iounmap(addr);
>
> -       return ((data & 0xF0) >> 4) + 1;
> +       return data;
> +}
> +
> +static unsigned int __init rcar_gen2_get_revision(void)
> +{
> +       return ((rcar_gen2_get_prr() & 0xF0) >> 4) + 1;

As the PRR register value doesn't change, and it's only 32-bit, I would
read it once and store it for later use, to avoid the overhead of repeated
ioremap() calls.

> +}
> +
> +static u32 __init rcar_gen2_get_cpuid(void)
> +{
> +       return (rcar_gen2_get_prr() & 0x7F00) >> 8;

Likewise.

>  }
>
>  void __init rcar_gen2_init_machine(void)
>  {
> +       struct soc_device_attribute *soc_dev_attr;
> +       struct soc_device *soc_dev;
> +       struct device *parent = NULL;
> +
> +       soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> +       if (!soc_dev_attr)
> +               goto out;
> +
>         system_rev = rcar_gen2_get_revision();

The above shows up (in hex) in /proc/cpuinfo as (for ES1.0)

        Revision: 0001

As per the comment on your previous patch, I think it would be better to
have "0010" for ES1.0.

> -       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +       soc_dev_attr->family = kasprintf(GFP_KERNEL, "Renesas R-Car Gen2");
> +       soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d", system_rev);

Likewise:

        soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%u.%u",
system_rev >> 4, system_rev & 0xf);

> +       soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%04x",
> +                                        rcar_gen2_get_cpuid());

On my Koelsch with R-Car M2-W ES1.0, this gives:
        /sys/devices/soc0/family : Renesas R-Car Gen2
        /sys/devices/soc0/revision : 1
        /sys/devices/soc0/soc_id : 0047

Should we fill in the soc_device_attribute.machine field, too?

> +
> +       soc_dev = soc_device_register(soc_dev_attr);
> +       if (IS_ERR(soc_dev)) {
> +               kfree(soc_dev_attr->family);
> +               kfree(soc_dev_attr->revision);
> +               kfree(soc_dev_attr->soc_id);
> +               kfree(soc_dev_attr);
> +               goto out;
> +       }
> +
> +       parent = soc_device_to_device(soc_dev);
> +out:
> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);

The above change moves all on-SoC devices from /sys/devices/platform/
to /sys/devices/soc0/. I think it's worth adding that to the patch description.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
