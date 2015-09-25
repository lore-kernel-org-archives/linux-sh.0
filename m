From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 25 Sep 2015 17:18:04 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: r8a7791/r8a7793: Correct SCIFB1_B SCK MOD_SEL value
Message-Id: <CACRpkdb5DkxC8_BP425bZ70tPcf1yMjew39vrM8YXUjrT0p13g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441887423-18743-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1441887423-18743-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Thu, Sep 10, 2015 at 5:17 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> When using serial port SCIFB1_B, transmit works, but nothing is
> received.
>
> Receive fails because the SCIFB1_SCK_B settings configure the wrong
> value for the sel_scifb1 field in the Module Select Register (MOD_SEL),
> due to an ambiguity in the R-Car M2-W and M2-N datasheets.
>
> Tested on r8a7791/koelsch using pins 53 (TXD) and 72 (RXD) on EXIO
> Connector A.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Against next-20150910.
>
> s/PINMUX_IPSR_MODSEL_DATA/PINMUX_IPSR_MSEL/ to apply on
> renesas-drivers-2015-09-08-v4.2.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
