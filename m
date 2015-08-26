From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 26 Aug 2015 22:20:33 +0000
Subject: Re: [PATCH 2/2] pinctrl: sh-pfc: r8a7794: add VIN pin groups
Message-Id: <55DE3BB1.5050704@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <13219129.kD4pZSmcAP@wasted.cogentembedded.com>
 <1507074.oEdHYS5Faz@wasted.cogentembedded.com>
 <CAMuHMdV_Dq044iwEUsHs3uc+tV_cWtZmAL2eX14nKys1aFB91Q@mail.gmail.com>
In-Reply-To: <CAMuHMdV_Dq044iwEUsHs3uc+tV_cWtZmAL2eX14nKys1aFB91Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hello.

On 08/25/2015 03:30 PM, Geert Uytterhoeven wrote:

> Hi (Tovaritsj?) Sergei,

    Tovarishch. :-)

> Matsuoka-san,

>> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>>
>> Add VIN0/1 pin groups to R8A7794 PFC driver.
>>
>> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>> [Sergei: rebased, renamed, added changelog.]
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> Thanks for your patch!
>
>> --- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
>> +++ linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
>> @@ -2789,6 +2789,167 @@ static const unsigned int usb1_mux[] = {
>>          USB1_OVC_MARK,
>>   };
>>
>> +union vin_data {
>> +       unsigned int data24[24];
>> +       unsigned int data20[20];
>> +       unsigned int data16[16];
>> +       unsigned int data12[12];
>> +       unsigned int data10[10];
>> +       unsigned int data8[8];
>> +};
>> +
>> +#define VIN_DATA_PIN_GROUP(n, s)                               \
>> +       {                                                       \
>> +               .name = #n#s,                                   \
>> +               .pins = n##_pins.data##s,                       \
>> +               .mux = n##_mux.data##s,                         \
>> +               .nr_pins = ARRAY_SIZE(n##_pins.data##s),        \
>> +       }
>
> As this is the third occurrence of these 2 definitions, perhaps they
> should be moved to sh_pfc.h?

    I'll look into this.

>> +/* - VIN1 ----------------------------------------------------------------- */
>
>> +static const unsigned int vin1_g_b_pins[] = {
>> +       /* G */
>> +       RCAR_GP_PIN(1, 10), RCAR_GP_PIN(1, 11),
>> +       RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 13),
>> +};
>> +static const unsigned int vin1_g_b_mux[] = {
>> +       /* G */
>> +       VI1_DATA8_MARK, VI1_DATA9_MARK,
>> +       VI1_DATA10_MARK, VI1_DATA11_MARK,
>> +};
>
> This is the green channel, to augment red and blue in vin_data8*?

    I have no idea, even after rummaging in the BT.* specs mentioned in the 
manuals. ITU-R BT.656 only describes 8- and 10-bit interfaces. Matsuoka-san, 
any idea?

> If yes, would it make sense to have a separate vin1_data12* section,
> combining them?

    Most probably.

> Gr{oetje,eeting}s,
>
>                          Geert

MBR, Sergei

