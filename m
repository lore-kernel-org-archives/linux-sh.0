From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Feb 2014 09:44:41 +0000
Subject: Re: [PATCH v2] pinctrl: sh-pfc: r8a7790: Add QSPI pin groups
Message-Id: <CAMuHMdULuOcyQ9J-KLg9Ssm3dZvrQb1=m66Ynyc+Q-G_4OtO=A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1392037257-20607-1-git-send-email-geert+renesas@linux-m68k.org>
	<52F91C31.8060509@codethink.co.uk>
In-Reply-To: <52F91C31.8060509@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Geert Uytterhoeven <geert+renesas@linux-m68k.org>, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Ben,

On Mon, Feb 10, 2014 at 7:36 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> On 10/02/14 13:00, Geert Uytterhoeven wrote:
>>
>> A QSPI function set consists of 3 groups:
>>    - qspi_ctrl (2 control wires)
>>    - qspi_data2 (2 data wires, for Single/Dual SPI)
>>    - qspi_data4 (4 data wires, for Quad SPI)
>
>
> Hi, do you have a branch with all your SPI/QSPI work on that we
> could have a test with please?

https://git.kernel.org/cgit/linux/kernel/git/geert/linux-m68k.git/log/?h=rcar-spi

This is based on renesas-devel-v3.14-rc1-20140207 and spi/for-next,
with accepted pinctrl and clock fixes, and the patches I sent out recently.
I left out the r7s72100/genmai stuff, as that depends on more out-of-tree
patches, and I think you're interested in Lager only?

Have fun!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
