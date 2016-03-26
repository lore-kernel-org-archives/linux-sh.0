From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 26 Mar 2016 09:01:43 +0000
Subject: Re: [PATCH] sh: add support for linking a builtin device tree blob in the kernel
Message-Id: <CAMuHMdVgSAeE7CdqC8mwUkQWqkRwT9pVVhDupcDZRbTz-1Ertg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160326014711.GA29106@brightrain.aerifal.cx>
In-Reply-To: <20160326014711.GA29106@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

CC devicetree

On Sat, Mar 26, 2016 at 2:47 AM, Rich Felker <dalias@libc.org> wrote:
> Signed-off-by: Rich Felker <dalias@libc.org>
> ---
>
> I'd like to add this patch to the new device tree support to ease the
> transition to device tree on legacy hardware where replacing the
> bootloader with a new one that can pass a DTB may be extra work. Since
> I'm not familiar with this kind of build system change, though, I'd
> like some feedback on whether I'm doing it right.

Alternatively, you could append the DTB to the boot image. Cfr.
http://elinux.org/R-Car/Boards/Marzen
http://elinux.org/Dragonboard/APQ8074

>  arch/sh/Kconfig             | 20 ++++++++++++++++++++
>  arch/sh/Makefile            |  2 ++
>  arch/sh/boards/of-generic.c | 15 ++++++++++++---
>  arch/sh/boot/dts/Makefile   |  3 +++
>  arch/sh/kernel/setup.c      |  4 ++++
>  5 files changed, 41 insertions(+), 3 deletions(-)
>  create mode 100644 arch/sh/boot/dts/Makefile
>
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 9dec535..b6db094 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -755,6 +755,26 @@ endmenu
>
>  menu "Boot options"
>
> +config USE_BUILTIN_DTB
> +       bool "Use builtin DTB"
> +       default n
> +       depends on SH_DEVICE_TREE
> +       help
> +         Link a device tree blob for particular hardware into the kernel,
> +         suppressing use of the DTB pointer provided by the bootloader.
> +         This option should only be used with legacy bootloaders that are
> +         not capable of providing a DTB to the kernel, or for experimental
> +         hardware without stable device tree bindings.
> +
> +config BUILTIN_DTB_SOURCE
> +       string "Source file for builtin DTB"
> +       default ""
> +       depends on USE_BUILTIN_DTB
> +       help
> +         Base name (without suffix, relative to arch/sh/boot/dts) for the
> +         a DTS file that will be used to produce the DTB linked into the

drop the first word "a"

> +         kernel.
> +
>  config ZERO_PAGE_OFFSET
>         hex
>         default "0x00010000" if PAGE_SIZE_64KB || SH_RTS7751R2D || \
> diff --git a/arch/sh/Makefile b/arch/sh/Makefile
> index 3566a759..0047666 100644
> --- a/arch/sh/Makefile
> +++ b/arch/sh/Makefile
> @@ -131,6 +131,8 @@ head-y      := arch/sh/kernel/head_$(BITS).o
>  core-y                         += arch/sh/kernel/ arch/sh/mm/ arch/sh/boards/
>  core-$(CONFIG_SH_FPU_EMU)      += arch/sh/math-emu/
>
> +core-$(CONFIG_USE_BUILTIN_DTB) += arch/sh/boot/dts/
> +
>  # Mach groups
>  machdir-$(CONFIG_SOLUTION_ENGINE)              += mach-se
>  machdir-$(CONFIG_SH_HP6XX)                     += mach-hp6xx
> diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
> index bf3a166..57d45dc 100644
> --- a/arch/sh/boards/of-generic.c
> +++ b/arch/sh/boards/of-generic.c
> @@ -126,13 +126,22 @@ static void __init sh_of_time_init(void)
>
>  static void __init sh_of_setup(char **cmdline_p)
>  {
> +       struct device_node *root;
> +
> +#ifdef CONFIG_USE_BUILTIN_DTB
> +       unflatten_and_copy_device_tree();
> +#else
>         unflatten_device_tree();
> +#endif
>
>         board_time_init = sh_of_time_init;
>
> -       sh_mv.mv_name = of_flat_dt_get_machine_name();
> -       if (!sh_mv.mv_name)
> -               sh_mv.mv_name = "Unknown SH model";
> +       sh_mv.mv_name = "Unknown SH model";
> +       root = of_find_node_by_path("/");
> +       if (root) {
> +               of_property_read_string(root, "model", &sh_mv.mv_name);
> +               of_node_put(root);
> +       }
>
>         sh_of_smp_probe();
>  }
> diff --git a/arch/sh/boot/dts/Makefile b/arch/sh/boot/dts/Makefile
> new file mode 100644
> index 0000000..e5ce3a0
> --- /dev/null
> +++ b/arch/sh/boot/dts/Makefile
> @@ -0,0 +1,3 @@
> +obj-$(CONFIG_USE_BUILTIN_DTB) += $(patsubst "%",%,$(CONFIG_BUILTIN_DTB_SOURCE)).dtb.o
> +
> +clean-files := *.dtb.S
> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
> index efb60ce..ec7c99f 100644
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -251,7 +251,11 @@ void __ref sh_fdt_init(phys_addr_t dt_phys)
>         /* Avoid calling an __init function on secondary cpus. */
>         if (done) return;
>
> +#ifdef CONFIG_USE_BUILTIN_DTB
> +       dt_virt = __dtb_start;
> +#else
>         dt_virt = phys_to_virt(dt_phys);
> +#endif
>
>         if (!dt_virt || !early_init_dt_scan(dt_virt)) {
>                 pr_crit("Error: invalid device tree blob"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
