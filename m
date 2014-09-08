From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 08 Sep 2014 08:18:33 +0000
Subject: Re: [PATCH] mmc: tmio: enable odd number size transfer
Message-Id: <CAMuHMdWmGOZ-4p4R92hNX5XftavfsmXB_wKoMw-mSFopMP4Hgw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wq9eohuc.wl%kuninori.morimoto.gx@gmail.com>
	<CAMuHMdUJK1Mmd_S+-hGFoshgRbpHKG5OH2w7AFHNaQG5qyvNaw@mail.gmail.com>
	<87r3zmo969.wl%kuninori.morimoto.gx@gmail.com>
	<CAMuHMdVqFvgPBVenEnoRfpDyMSc_z+9EEF19VHM8CESXmBwFMQ@mail.gmail.com>
	<87ppf6o7sw.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87ppf6o7sw.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

Hi Morimoto-san,

On Mon, Sep 8, 2014 at 10:06 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
> About endianness / byte access, it requires byte access
> especially "read" case.
> Because if count was odd number,
> using shift with u16 will might be buffer overflow

Of course the buffer must be accessed using byte accesses.
But sd_ctrl_read16() returns u16, and sd_ctrl_write16() takes u16.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
