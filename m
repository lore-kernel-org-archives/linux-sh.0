From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Aug 2014 13:50:20 +0000
Subject: Re: [PATCH 01/06] ARM: shmobile: Consolidate GPIOLIB Kconfig bits
Message-Id: <CAMuHMdVrBLapt_Wmg9sKVmBiSCOT7oKMOjHAFjv75eb1ZWnZ=g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140820133134.808.38907.sendpatchset@w520>
In-Reply-To: <20140820133134.808.38907.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Wed, Aug 20, 2014 at 3:31 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Consolidate ARCH_WANT_OPTIONAL_GPIOLIB under ARCH_SHMOBILE
> so it can be shared by Legacy and Multiplatform.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>  arch/arm/mach-shmobile/Kconfig |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> --- 0001/arch/arm/mach-shmobile/Kconfig
> +++ work/arch/arm/mach-shmobile/Kconfig 2014-08-19 21:46:43.000000000 +0900
> @@ -1,5 +1,6 @@
>  config ARCH_SHMOBILE
>         bool
> +       select ARCH_WANT_OPTIONAL_GPIOLIB

This is already selected by ARCH_MULTIPLATFORM, so perhaps it's best
to just move it ARCH_SHMOBILE_LEGACY instead?

>  menuconfig ARCH_SHMOBILE_MULTI
>         bool "Renesas ARM SoCs" if ARCH_MULTI_V7

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
