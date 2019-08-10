From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 10 Aug 2019 06:53:48 +0000
Subject: Re: [PATCH] sh: kernel: hw_breakpoint: Fix missing break in switch statement
Message-Id: <CAMuHMdVF8qoqR2EkCe8ND-SDMRf8tiEDdbZ0fJCL+eziiXBKBg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190810045944.GA13815@embeddedor>
In-Reply-To: <20190810045944.GA13815@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>

On Sat, Aug 10, 2019 at 6:59 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Add missing break statement in order to prevent the code from
> erroneously falling through to case SH_BREAKPOINT_WRITE.
>
> Fixes: 09a072947791 ("sh: hw-breakpoints: Add preliminary support for SH-4A UBC.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
