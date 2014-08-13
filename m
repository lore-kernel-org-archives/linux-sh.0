From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Aug 2014 07:19:43 +0000
Subject: Re: ARM: shmobile: "i2c<m>" vs. "iic<n>" DT nodes and pinmux
Message-Id: <CAMuHMdVVKOS=o-KSx1q05y_sRx5RcOMiUg8mN4fGM=UyGv1uog@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWqnMZQcRURufCxiGpbkK7ocjH8KnECxdWVPcxN-68J4g@mail.gmail.com>
	<20140812214723.GA3443@katana>
In-Reply-To: <20140812214723.GA3443@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>

Hi Wolfram,

On Tue, Aug 12, 2014 at 11:47 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Tue, Aug 12, 2014 at 03:11:18PM +0200, Geert Uytterhoeven wrote:
>> On r8a7790, DT device nodes and C/DT pinmux data for IIC<n> are called
>> "iic<n>", with DT aliases from "i2c<m>" to the "iic<n>" DT nodes.
>> On r8a7791, DT device nodes and C/DT pinmux data for IIC<n> are called
>> "i2c<m>", with DT aliases from "i2c<m>" to the "i2c<m>" DT nodes.
>>
>> In light of the proliferation of other members of the R-Car Gen 2 families, is
>> there a plan to make this consistent?
>
> The 'i2c'-prefix describes the IP core handled by the rcar driver. This
> core is named i2c in the datasheets.
>
> The 'iic'-prefix describes the IP core handled by the sh-mobile-driver.
> This core is named iic(b) in the datasheets.

I know the difference between i2c and iic(b).

However, the DT device nodes and C/DT pinmux data for iic(b) on r8a7791
are called i2c, too, instead of iic.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
