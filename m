From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 09 Jan 2020 12:56:58 +0000
Subject: Re: [PATCH] sh: sh4a: Remove unused tmu3_device
Message-Id: <CAMuHMdULhY=_GF2MsX-h_j=eLKL+2x3=YcgmFRsAy1_LUOdZ+g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200108194520.3341-1-krzk@kernel.org>
In-Reply-To: <20200108194520.3341-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Hi Krzysztof,

On Wed, Jan 8, 2020 at 8:45 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Remove left-over from previous cleanups to silence the warning:
>
>     arch/sh/kernel/cpu/sh4a/setup-sh7786.c:243:31:
>         warning: ‘tmu3_device’ defined but not used [-Wunused-variable]
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/sh/kernel/cpu/sh4a/setup-sh7786.c | 21 ---------------------
>  1 file changed, 21 deletions(-)
>
> diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
> index 4b0db8259e3d..22d1c38f742f 100644
> --- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
> +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
> @@ -229,27 +229,6 @@ static struct platform_device tmu2_device = {
>         .num_resources  = ARRAY_SIZE(tmu2_resources),
>  };
>
> -static struct sh_timer_config tmu3_platform_data = {
> -       .channels_mask = 7,
> -};
> -
> -static struct resource tmu3_resources[] = {
> -       DEFINE_RES_MEM(0xffde0000, 0x2c),
> -       DEFINE_RES_IRQ(evt2irq(0x7c0)),
> -       DEFINE_RES_IRQ(evt2irq(0x7c0)),
> -       DEFINE_RES_IRQ(evt2irq(0x7c0)),
> -};
> -
> -static struct platform_device tmu3_device = {
> -       .name           = "sh-tmu",
> -       .id             = 3,
> -       .dev = {
> -               .platform_data  = &tmu3_platform_data,
> -       },
> -       .resource       = tmu3_resources,
> -       .num_resources  = ARRAY_SIZE(tmu3_resources),
> -};
> -
>  static const struct sh_dmae_channel dmac0_channels[] = {
>         {
>                 .offset = 0,

Looks like the previous cleanup accidentally removed one too many tmu
device pointers.  The old style used one device per timer, the new style
uses one device per 3 timers, i.e. 4 devices for 12 timers.

So the correct fix would be to re-add "&tmu3_device" to
sh7786_early_devices[].

Fixes: 1399c195ef5009bf ("sh: Switch to new style TMU device")

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
