From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 Apr 2014 22:39:17 +0000
Subject: Re: [PATCH 5/6] i2c: sh_mobile: devm conversion, low hanging fruits
Message-Id: <CAMuHMdW08XLKtWeSCtUPnuqR4Etz=CiYCDfqYUnCqAZjEsN7wQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398896470-24663-1-git-send-email-wsa@the-dreams.de>
	<1398896470-24663-6-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1398896470-24663-6-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

On Thu, May 1, 2014 at 12:21 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Convert the easy parts to devm. irqs will be converted in a seperate
> patch to keep diffs readable.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
