From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 06 Jan 2016 14:26:28 +0000
Subject: Re: [RFC v2 1/4] of: make of_mutex public
Message-Id: <CAMuHMdXBPV09UMRLWuFWA0x7OxPT=DCAH8VsCGoa1+bgvoNK_g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452088285-6427-1-git-send-email-wsa@the-dreams.de>
	<1452088285-6427-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452088285-6427-2-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Jan Luebbe <jlu@pengutronix.de>

Hi Wolfram,

On Wed, Jan 6, 2016 at 2:51 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> If we want to use OF_DYNAMIC features outside the of framework, we need
> to access this lock.

As I2C_DEMUX_PINCTRL is tristate, you want to add an EXPORT_SYMBOL_GPL(), too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
