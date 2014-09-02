From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 02 Sep 2014 16:02:40 +0000
Subject: Re: [PATCH] sh: Fix build error caused by missing dependencies
Message-Id: <CAMuHMdXbKqcm1H3F6ML++XSjkWQzOSbzMQnb5aVwe8W2ohr0fw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1409668745-31693-1-git-send-email-bobby.prani@gmail.com>
In-Reply-To: <1409668745-31693-1-git-send-email-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, Magnus Damm <damm@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Mark Salter <msalter@redhat.com>, Kees Cook <keescook@chromium.org>, Geert Uytterhoeven <geert+renesas@glider.be>, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, Robert Graffham <psquid@psquid.net>, Paul Bolle <pebolle@tiscali.nl>, "open list:SUPERH" <linux-sh@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Hi Pranith,

On Tue, Sep 2, 2014 at 4:39 PM, Pranith Kumar <bobby.prani@gmail.com> wrote:
> Fix a sh4-randconfig build failure which has the following splat:
>
> arch/sh/mm/cache-sh4.c:99:17: error: 'cached_to_uncached' undeclared (first use in this function)
> arch/sh/mm/cache-sh4.c:192:2: error: implicit declaration of function 'cpu_context' [-Werror=implicit-function-declaration]
>
> These errors are caused by missing dependencies on UNCACHED_MAPPING and MMU.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  arch/sh/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 244fb4c..619d5eb 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -194,6 +194,8 @@ config CPU_SH4
>         select SH_INTC
>         select SYS_SUPPORTS_SH_TMU
>         select SYS_SUPPORTS_HUGETLBFS if MMU
> +       select UNCACHED_MAPPING
> +       select MMU

Selecting MMU is never the correct solution, as it's a platform feature.
Making something depend on MMU is something different, but I doubt
SH4 can only work with a MMU, cfr. the "if MMU" in the line above.

Back to the drawing board...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
