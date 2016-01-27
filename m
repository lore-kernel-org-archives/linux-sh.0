From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 27 Jan 2016 14:09:16 +0000
Subject: Re: [PATCH 1/2] pinctrl: sh-pfc: r8a7795: Rename SSI_{WS,SCK}0129 to SSI_{WS,SCK}01239
Message-Id: <CACRpkdbOVka1+se86B9Sg3oCZDt65BgmagqwbSc89GABAAmcLg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452856024-10793-1-git-send-email-geert+renesas@glider.be>
	<1452856024-10793-2-git-send-email-geert+renesas@glider.be>
	<CACRpkda7w6A48Bk2szWmAo1mor-VQGxMjPv6bwaFfoBzhm-DVQ@mail.gmail.com>
	<CAMuHMdX7HkkXDdvMDPANbHyB5P0k-cgKfj8k84AvXkFLGrdPgw@mail.gmail.com>
In-Reply-To: <CAMuHMdX7HkkXDdvMDPANbHyB5P0k-cgKfj8k84AvXkFLGrdPgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Wed, Jan 20, 2016 at 2:17 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Linus,
>
> On Wed, Jan 20, 2016 at 2:04 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Fri, Jan 15, 2016 at 12:07 PM, Geert Uytterhoeven
>> <geert+renesas@glider.be> wrote:
>>
>>> Cfr. Manual Errata for Rev 0.50 of the R-Car Gen3 datasheet.
>>>
>>> This has no user-visible impact, as the string used for configuration
>>> ("ssi01239_ctrl") was already correct.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> Are these regressions that need to go in as fixes?
>
> No, I plan to queue them on a branch for v4.6.

Excellent, Acked-by.

Yours,
Linus Walleij
