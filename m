From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 10 Aug 2019 06:58:53 +0000
Subject: Re: [PATCH v2] sh: kernel: disassemble: Mark expected switch fall-throughs
Message-Id: <CAMuHMdWsu56u_HmwMSTy3N0_uKN0ngi4pmuXoX0y5iU7Y=L=6g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190810052442.GA21354@embeddedor>
In-Reply-To: <20190810052442.GA21354@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Joe Perches <joe@perches.com>

On Sat, Aug 10, 2019 at 7:26 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Remove logically dead code and mark switch cases where we are expecting
> to fall through.
>
> Fix the following warnings (Building: defconfig sh):
>
> arch/sh/kernel/disassemble.c:478:8: warning: this statement may fall
> through [-Wimplicit-fallthrough=]
> arch/sh/kernel/disassemble.c:487:8: warning: this statement may fall
> through [-Wimplicit-fallthrough=]
> arch/sh/kernel/disassemble.c:496:8: warning: this statement may fall
> through [-Wimplicit-fallthrough=]
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
