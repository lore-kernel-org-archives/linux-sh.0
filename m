From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 May 2015 08:40:22 +0000
Subject: Re: [PATCH v3] sh-sci: Get register size from platform device
Message-Id: <CAMuHMdWAir2Ob-YaQNwgJN68dQX_nmMeuc2E1UPu2uMB6LqF5w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1431925027-13257-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1431925027-13257-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 18, 2015 at 6:57 AM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> There is much SCI of SoC having within,
> and the register size is also different in everyone.
> So get from platform device.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Acked-by: by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
