From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 May 2014 07:42:15 +0000
Subject: Re: [PATCH] ARM: shmobile: Use shmobile_init_late() on r8a7740
Message-Id: <CAMuHMdW4-r8khvk-hJcx1OXqwT0nGsVm3zEnmW6TUhyeDRPWdg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140511231050.19908.86623.sendpatchset@w520>
In-Reply-To: <20140511231050.19908.86623.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, May 12, 2014 at 1:10 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Hook up ->init_late for r8a7740 to initialize Suspend-to-RAM
> and CPUIdle in case of C-code less board support for r8a7740.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
