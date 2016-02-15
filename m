From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Feb 2016 18:39:00 +0000
Subject: Re: [PATCH 0/4] pinctrl: sh-pfc: More PINMUX_SINGLE() conversions
Message-Id: <CAMuHMdWuMLd+xah5H8a7XY2WY1QcCus+x+jcju2p9Mw4Q1yGVg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1448890865-1856-1-git-send-email-geert+renesas@glider.be>
	<CACRpkdZp8n_QMa+X36VNqn4Vueh60nwD4=6HuEWjJvnV4g_KEw@mail.gmail.com>
In-Reply-To: <CACRpkdZp8n_QMa+X36VNqn4Vueh60nwD4=6HuEWjJvnV4g_KEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hi Linus,

On Mon, Feb 15, 2016 at 7:26 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Nov 30, 2015 at 2:41 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> This patch series converts pin control data for a few more Renesas SoCs
>> to the recently-introduced PINMUX_SINGLE() macro.
>> As such this series depends on "[PATCH/RFC 0/4] pinctrl: sh-pfc: Add
>> PINMUX_SINGLE()".
>
> Looks good to me (TM)
> Please queue them and send with a pull request incl. Laurent's ACKs.

Been there, done that. This series is already in v4.5-rc1 ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
