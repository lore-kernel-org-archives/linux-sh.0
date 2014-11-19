From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Nov 2014 13:07:23 +0000
Subject: Re: [PATCH] i2c: sh_mobile: use proper device for mapping DMA memory
Message-Id: <CAMuHMdX66NgfNvgHYo6uArqzTNrSBGSMv54Amc8vz11JCgnQ2g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1416401002-18128-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1416401002-18128-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Arnd Bergmann <arnd@arndb.de>

On Wed, Nov 19, 2014 at 1:43 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> It should be the DMA device, not the platform device.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
