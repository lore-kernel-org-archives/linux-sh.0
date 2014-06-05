From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 05 Jun 2014 08:22:39 +0000
Subject: Re: [PATCH 03/03] ARM: shmobile: Use shmobile_init_delay() on r7s72100
Message-Id: <CAMuHMdVFOC37o7h_zMvE7jXT3TGMc+-8Ks8qAVTE-xGd6WiTSQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140224073006.3522.95891.sendpatchset@w520>
In-Reply-To: <20140224073006.3522.95891.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Thu, Jun 5, 2014 at 8:47 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Adjust Genmai board support to use shmobile_init_delay() together
> with r7s72100 CPU Frequency settings from the DTS.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>  arch/arm/mach-shmobile/board-genmai-reference.c |    2 +-
>  arch/arm/mach-shmobile/board-genmai.c           |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

The contents of this patch are identical to "[PATCH 02/03] ARM: shmobile:
Use shmobile_init_delay() on Genmai boards"?

I had expected it to touch arch/arm/mach-shmobile/setup-r7s72100.c and
arch/arm/mach-shmobile/include/mach/r7s72100.h.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
