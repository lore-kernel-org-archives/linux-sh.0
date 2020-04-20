From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Apr 2020 14:45:35 +0000
Subject: Re: [PATCH 2/2] sh: remove unused sh5 files
Message-Id: <CAMuHMdVpMP1NrXSO=4MJRpkXVgbuahvbZGVaAy3YJ2Oew9kGAQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200420123844.3998746-1-arnd@arndb.de> <20200420123844.3998746-2-arnd@arndb.de>
In-Reply-To: <20200420123844.3998746-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Magnus Damm <magnus.damm@gmail.com>

Hi Arnd,

On Mon, Apr 20, 2020 at 2:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
> None of these files are used now that sh5 has been
> disabled, so they can be completely removed.

Thanks a lot!

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

The following can be removed, too:
    arch/sh/boot/compressed/head_64.S
    arch/sh/mm/extable_64.c
    arch/sh/mm/tlbex_64.c
    arch/sh/mm/tlbflush_64.c

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
