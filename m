From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Mar 2014 13:21:15 +0000
Subject: Re: [PATCH] ARM: shmobile: Add DTS gpio-keys support for SW2 on Koelsch
Message-Id: <CAMuHMdVqCk+VRiwbC5BLjFyqfg1YXMAhUGbzdDc0ZMKn7JPrcw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140318125748.21994.38046.sendpatchset@w520>
In-Reply-To: <20140318125748.21994.38046.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 18, 2014 at 2:01 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Add DTS gpio-keys support for SW2 on the Koelsch board.
> This makes the DT code match the legacy board code. Also
> update the existing gpio-keys nodes to make use of KEY_n.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
