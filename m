From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Dec 2014 08:41:57 +0000
Subject: Re: [PATCH v2] gpio: rcar: Add r8a7793 and r8a7794 support
Message-Id: <CAMuHMdXBkhKCJg4D-rLUcid8y8WSe6OQ6Qxp39z4t6SqkybjHw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415361248-24610-1-git-send-email-ykaneko0929@gmail.com>
	<2188270.mR2n2an5Xq@avalon>
	<CANqRtoTA+sPUT8enk_BCzi7Z5xG4Ump29hCAJgm47JgVXoF9WQ@mail.gmail.com>
In-Reply-To: <CANqRtoTA+sPUT8enk_BCzi7Z5xG4Ump29hCAJgm47JgVXoF9WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-gpio <linux-gpio@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Simon Horman <horms@verge.net.au>, SH-Linux <linux-sh@vger.kernel.org>

Hi Magnus,

On Mon, Dec 15, 2014 at 3:03 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Hi Geert,

For the record, it's Laurent who's questioning this...

> On Sat, Dec 13, 2014 at 4:17 AM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:

[...]

>> Seriously, doesn't this call for a "renesas,gpio-rcar-gen2" compatible string
>> ?
>
> Maybe, but only if we had a crystal ball and could predict that the IP
> would be guaranteed not to change inside future Gen2 devices! =)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
