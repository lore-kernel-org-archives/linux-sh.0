From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 May 2018 09:30:49 +0000
Subject: Re: [PATCH] media: arch: sh: migor: Fix TW9910 PDN gpio
Message-Id: <CAMuHMdVsV9k0OjFMkQSiKCenxfEHgcZxrMU3a5eXRaCDdeA5-A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1527671604-18768-1-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1527671604-18768-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hans.verkuil@cisco.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Jacopo,

On Wed, May 30, 2018 at 11:13 AM, Jacopo Mondi
<jacopo+renesas@jmondi.org> wrote:
> The TW9910 PDN gpio (power down) is listed as active high in the chip
> manual. It turns out it is actually active low as when set to physical
> level 0 it actually turns the video decoder power off.

So the picture "Typical TW9910 External Circuitry" in the datasheet, which
ties PDN to GND permanently, is wrong?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
