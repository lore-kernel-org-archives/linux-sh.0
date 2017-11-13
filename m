From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 13 Nov 2017 15:26:52 +0000
Subject: Re: [PATCH] sh: select KBUILD_DEFCONFIG depending on ARCH
Message-Id: <CAK7LNATw7iTKy2VLUd0toiKO7q8SuCTVRdSkhceANHuTPj93hw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1509644432-21252-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1509644432-21252-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

2017-11-03 2:40 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> You can not select KBUILD_DEFCONFIG depending on any CONFIG option
> because include/config/auto.conf is not included when building config
> targets.  So, CONFIG_SUPERH32 is never set during the configuration,
> and cayman_defconfig is chosen.
>
> This commit provides a sensible way to choose shx3/cayman_defconfig.
>
> arch/sh/Kconfig sets either SUPERH32 or SUPERH64 depending on ARCH
> environment, like follows:
>
>   config SUPERH32
>           def_bool ARCH = "sh"
>
>           ...
>
>   config SUPERH64
>           def_bool ARCH = "sh64"
>
> It should make sense to choose the default defconfig by ARCH,
> like arch/sparc/Makefile.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Applied to linux-kbuild/kbuild.


> ---
>
>  arch/sh/Makefile | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/sh/Makefile b/arch/sh/Makefile
> index 280bbff..65300193 100644
> --- a/arch/sh/Makefile
> +++ b/arch/sh/Makefile
> @@ -15,6 +15,12 @@ ifneq ($(SUBARCH),$(ARCH))
>    endif
>  endif
>
> +ifeq ($(ARCH),sh)
> +KBUILD_DEFCONFIG       := shx3_defconfig
> +else
> +KBUILD_DEFCONFIG       := cayman_defconfig
> +endif
> +
>  isa-y                                  := any
>  isa-$(CONFIG_SH_DSP)                   := sh
>  isa-$(CONFIG_CPU_SH2)                  := sh2
> @@ -105,14 +111,12 @@ ifdef CONFIG_SUPERH32
>  UTS_MACHINE            := sh
>  BITS                   := 32
>  LDFLAGS_vmlinux                += -e _stext
> -KBUILD_DEFCONFIG       := shx3_defconfig
>  else
>  UTS_MACHINE            := sh64
>  BITS                   := 64
>  LDFLAGS_vmlinux                += --defsym phys_stext=_stext-$(CONFIG_PAGE_OFFSET) \
>                            --defsym phys_stext_shmedia=phys_stext+1 \
>                            -e phys_stext_shmedia
> -KBUILD_DEFCONFIG       := cayman_defconfig
>  endif
>
>  ifdef CONFIG_CPU_LITTLE_ENDIAN
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
