From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Jan 2014 08:05:10 +0000
Subject: Re: [PATCH 0/10] ARM: shmobile: enable CONFIG_DEVTMPFS in defconfig
Message-Id: <CAMuHMdUOtUi_qzJp6DetdUL6c5uBP=KcQhnHF33usoE4ryGcrQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhxyi90a.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87lhxyi90a.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 30, 2014 at 1:55 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
> These patches enable DEVTMPFS for all Renesas board
> on defconfig
>
> Kuninori Morimoto (10):
>       ARM: shmobile: marzen: enable CONFIG_DEVTMPFS in defconfig
>       ARM: shmobile: mackerel: enable CONFIG_DEVTMPFS in defconfig
>       ARM: shmobile: lager: enable CONFIG_DEVTMPFS in defconfig
>       ARM: shmobile: kzm9g: enable CONFIG_DEVTMPFS in defconfig
>       ARM: shmobile: kzm9d: enable CONFIG_DEVTMPFS in defconfig
>       ARM: shmobile: koelsch: enable CONFIG_DEVTMPFS in defconfig
>       ARM: shmobile: genmai: enable CONFIG_DEVTMPFS in defconfig
>       ARM: shmobile: bockw: enable CONFIG_DEVTMPFS in defconfig
>       ARM: shmobile: armadillo: enable CONFIG_DEVTMPFS in defconfig
>       ARM: shmobile: ape6evm: enable CONFIG_DEVTMPFS in defconfig

For all above but koelsch, where it's already set:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
