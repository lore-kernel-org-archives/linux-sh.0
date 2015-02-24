From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Feb 2015 10:00:10 +0000
Subject: Re: [PATCH 3/4][resend] ARM: shmobile: r8a7790: tidyup SDHI register size on DTSI
Message-Id: <CAMuHMdVjRf+LesPuhjxYVj+9hwMTPKTH_thEDjiH28iq0Rghpw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87y4noyrp4.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y4noyrp4.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 24, 2015 at 3:20 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> r8a7790 SDHI ch0/ch1 has SD_DMACR which is located in 0x324.
> This patch updates register size
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Before Simon reverted it again, this one (and patch 4) had:

    Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
