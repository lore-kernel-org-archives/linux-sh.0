From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Sep 2017 08:31:01 +0000
Subject: Re: [PATCH v2 resend 0/4] sh: sh7722/sh7757i/sh7264/sh7269: Fix pinctrl registration
Message-Id: <CAMuHMdXwq_X2iqQHQRxzHVf+prAkDELjm2RzH_NS6h6-HcqFOA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1505205657-18012-1-git-send-email-geert+renesas@glider.be> <CACRpkdYfbUvpLSZnTan+P5pBYKomEK0gEaQor8YjtxE9Y2riSg@mail.gmail.com>
In-Reply-To: <CACRpkdYfbUvpLSZnTan+P5pBYKomEK0gEaQor8YjtxE9Y2riSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Andrew Morton <akpm@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Linus,

On Tue, Sep 19, 2017 at 10:19 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Tue, Sep 12, 2017 at 10:40 AM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> I'm resending this to you due to unresponsiveness from the SuperH
>> maintainers (v2 sent before on May 11, pinged on June 30 and August 14).
>
> I'm happy to take this into the pinctrl tree if need be.
>
> It is pinctrl related so it makes sense to carry it there if SH
> maintainers are not responding.
>
> Just send a separate pull request and indicate if it needs to
> go in for fixes or devel.

In the mean time, Andrew took it (thanks!), so it's now in linux-next.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
