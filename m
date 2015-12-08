From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 08 Dec 2015 13:06:16 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: r8a7791: add EtherAVB pin groups
Message-Id: <CAMuHMdV_-LYJMrZJG+zP4M2Y7TVHgtdoSqjP=Af-XENWcu7frw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <13219129.kD4pZSmcAP@wasted.cogentembedded.com>
	<1512650.VUqGxiAB2A@wasted.cogentembedded.com>
	<CAMuHMdX5d90NS0btT28yAUD3iNSDdV_GLPOwDMAt9PcTvU4dMA@mail.gmail.com>
	<5666CD4A.8030903@cogentembedded.com>
In-Reply-To: <5666CD4A.8030903@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hi Sergei,

On Tue, Dec 8, 2015 at 1:30 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 12/8/2015 3:12 PM, Geert Uytterhoeven wrote:
>>> Add the EtherAVB pin groups to the R8A7791 PFC driver.
>>
>> Thanks for your patch!
>>
>>> +static const unsigned int avb_mii_pins[] = {
>>> +       RCAR_GP_PIN(5, 18), RCAR_GP_PIN(5, 19), RCAR_GP_PIN(5, 20),
>>> +       RCAR_GP_PIN(5, 21),
>>> +
>>> +       RCAR_GP_PIN(5, 0), RCAR_GP_PIN(5, 1), RCAR_GP_PIN(5, 2),
>>> +       RCAR_GP_PIN(5, 3),
>>> +
>>> +       RCAR_GP_PIN(5, 8), RCAR_GP_PIN(5, 13), RCAR_GP_PIN(5, 10),
>>> +       RCAR_GP_PIN(5, 15), RCAR_GP_PIN(5, 26), RCAR_GP_PIN(5, 28),
>>> +       RCAR_GP_PIN(5, 29),
>>> +};
>>> +static const unsigned int avb_mii_mux[] = {
>>> +       AVB_TXD0_MARK, AVB_TXD1_MARK, AVB_TXD2_MARK,
>>> +       AVB_TXD3_MARK,
>>> +
>>> +       AVB_RXD0_MARK, AVB_RXD1_MARK, AVB_RXD2_MARK,
>>> +       AVB_RXD3_MARK,
>>> +
>>> +       AVB_RX_ER_MARK, AVB_RX_CLK_MARK, AVB_RX_DV_MARK,
>>> +       AVB_CRS_MARK, AVB_TX_EN_MARK, AVB_TX_CLK_MARK,
>>> +       AVB_COL_MARK,
>>> +};
>>
>> The MII pin list include RX_ER, but not TX_ER...
>
>    Wikipedia tells me TX_ER is optional for MII.

OK. So it may make sense to have a separate pinmux group for it.

BTW, I've just noticed the R-Car Gen2 sh_eth Ethernet (which does 10/100 only)
doesn't have the pin.

>> ... while the GMII pin list includes both RX_ER and TX_ER. Is that
>> correct?
>> Should it be the other way around?
>>
>> Section "45A.3.13.1 MII Frame Transmission/Reception Timing" of the R-Car
>> Gen2
>> datasheet shows timing diagrams for both AVB_TX_ER and AVB_RX_ER, so I'd
>> expect
>> both pins to be needed for MII.
>
>
>    Hm, interesting...
>
>> Unfortunately Section "45A.3.13.2 GMII Frame Reception Timing" shows
>> timing
>> diagrams for receive only (thus involving AVB_RX_ER only), so I'm not sure
>> the
>> AVB_TX_ER pin is actually needed for GMII.
>
>    It is.

OK.

>> I don't have schematics for any R-Car Gen2 board that has AVB support, so
>> I
>> can't check myself how the MII/GMII is really wired.
>
>    The standard Lager/Porter boards require some modification to use an an
> AVB daughter board, AFAIK.

Do you have schematics for those?

>> Note that this also applies to the existing AVB pinmux data in
>> pfc-r8a7790.c.
>
>    And we haven't really tested MII, only GMII.

So I guess the daughterboard uses both RX_ER and TX_ER?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
