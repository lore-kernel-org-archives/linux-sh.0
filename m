From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 May 2014 07:50:23 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: r8a7740 without PM domains prototype
Message-Id: <CAMuHMdWFOsQ2Os=wqtkH-ykkzteXQ6FzJM_-FnPydDttvQ9n+g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140511231652.19926.53110.sendpatchset@w520>
In-Reply-To: <20140511231652.19926.53110.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Mon, May 12, 2014 at 1:16 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> This is a prototype patch to allow building r8a7740 for
> multiplatform when CONFIG_PM_GENERIC_DOMAINS is unset.
>
> It may perhaps be better to simply select PM_GENERIC_DOMAINS
> for r8a7740 in case of multiplatform. Same applies to sh73a0.

Samsung S3C64XX, Exynos4, and Exynos 5250/5420 do something similar.

> -#ifdef CONFIG_PM
> +#if defined(CONFIG_PM) && defined(CONFIG_PM_GENERIC_DOMAINS)

Doesn't PM_GENERIC_DOMAINS depend on PM, so you can just test
for PM_GENERIC_DOMAINS here?

Ah, you must have some additional changes to your Kconfig files to
enable PM_GENERIC_DOMAINS?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
