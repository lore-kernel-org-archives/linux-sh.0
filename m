From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 04 Sep 2014 06:31:45 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7740: Cleanup PM Kconfig usage
Message-Id: <CAMuHMdXjm8WeA_iQx0hodBRS=T-TPT0SQor4cgcgu6LqqiuDEA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140904033942.22881.84361.sendpatchset@w520>
In-Reply-To: <20140904033942.22881.84361.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Thu, Sep 4, 2014 at 5:39 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> @@ -58,7 +58,9 @@ void __init r8a7740_init_pm_domains(void
>         rmobile_init_domains(r8a7740_pm_domains, ARRAY_SIZE(r8a7740_pm_domains));
>         pm_genpd_add_subdomain_names("A4S", "A3SP");
>  }
> -#endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
> +#else
> +void r8a7740_init_pm_domains(void) {}
> +#endif
>
>  #ifdef CONFIG_SUSPEND
>  static int r8a7740_enter_suspend(suspend_state_t suspend_state)
> --- 0001/arch/arm/mach-shmobile/r8a7740.h
> +++ work/arch/arm/mach-shmobile/r8a7740.h       2014-09-04 12:29:12.000000000 +0900
> @@ -52,11 +52,6 @@ extern void r8a7740_add_standard_devices
>  extern void r8a7740_clock_init(u8 md_ck);
>  extern void r8a7740_pinmux_init(void);
>  extern void r8a7740_pm_init(void);
> -
> -#if defined(CONFIG_PM) && !defined(CONFIG_ARCH_MULTIPLATFORM)
> -extern void __init r8a7740_init_pm_domains(void);
> -#else
> -static inline void r8a7740_init_pm_domains(void) {}
> -#endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
> +extern void r8a7740_init_pm_domains(void);
>
>  #endif /* __ASM_R8A7740_H__ */

Why do you make r8a7740_init_pm_domains() out-of-line in the
!CONFIG_PM_RMOBILE case?
It increases code size (call to an empty function that cannot be optimized
away), and prevents us from building pm-r8a7740.c conditionally on
CONFIG_PM_RMOBILE and CONFIG_ARCH_R8A7740 in the future.

For the latter, we can turn pm-rmobile into a library, and do something
like

pm-rmobile-objs-$(CONFIG_ARCH_R8A7740)      += pm-r8a7740.o

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
