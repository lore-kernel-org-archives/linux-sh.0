From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Aug 2015 08:06:48 +0000
Subject: Re: [PATCH 16/25 v7][RFC] arm64: renesas: salvator-x: add pfc node and subnodes for usb 2.0
Message-Id: <CAMuHMdX+Ekgx=La8vmhowk2=YhLonzKuawTKVP4CWojVvst3Yw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <876145776m.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <876145776m.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Shimoda-san,

On Thu, Aug 27, 2015 at 5:13 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
>> index 9437e87..1f60f4c 100644
>> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
>> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
>> @@ -1335,6 +1335,19 @@ static const u16 pinmux_data[] = {
>>       PINMUX_IPSR_DATA(IP15_31_28, SCK5),
>>
>>       /* IPSR16 */
>> +     PINMUX_IPSR_DATA(IP16_11_8, USB0_PWEN),
>> +     PINMUX_IPSR_MODSEL_DATA(IP16_11_8, SIM0_RST_C, SEL_SIMCARD_2),
>> +     PINMUX_IPSR_MODSEL_DATA(IP16_11_8, TS_SCK1_D, SEL_TSIF1_3),
>> +     PINMUX_IPSR_MODSEL_DATA(IP16_11_8, STP_ISCLK_1_D, SEL_SSP1_1_3),
>> +     PINMUX_IPSR_MODSEL_DATA(IP16_11_8, BPFCLK_B, SEL_FM_1),
>> +     PINMUX_IPSR_MODSEL_DATA(IP16_11_8, RIF3_CLK_B, SEL_DRIF3_1),
>> +
>> +     PINMUX_IPSR_DATA(IP16_15_12, USB0_OVC),
>> +     PINMUX_IPSR_MODSEL_DATA(IP16_15_12, SIM0_D_C, SEL_SIMCARD_2),
>> +     PINMUX_IPSR_MODSEL_DATA(IP16_15_12, TS_SDAT1_D, SEL_TSIF1_3),
>> +     PINMUX_IPSR_MODSEL_DATA(IP16_15_12, STP_ISD_1_D, SEL_SSP1_1_3),
>> +     PINMUX_IPSR_MODSEL_DATA(IP16_15_12, RIF3_SYNC_B, SEL_DRIF3_1),
>> +
>>       PINMUX_IPSR_DATA(IP16_19_16, USB1_PWEN),
>>       PINMUX_IPSR_MODSEL_DATA(IP16_19_16, SIM0_CLK_C, SEL_SIMCARD_2),
>>       PINMUX_IPSR_MODSEL_DATA(IP16_19_16, SSI_SCK1_A, SEL_SSI_0),
>
> Thank you for the point locally :)
> Even if I don't add all the "PINMUX_IPSR_MODSEL_DATA" of usb0, it works correctly.

Because usb0 is the default function after bootup?

> Since I didn't test the pins except USB0_{OVC,PWEN),
> all the "PINMUX_IPSR_MODSEL_DATA" of usb0 should be removed.

You still want to describe the full pinctrl. Else dynamic reconfiguration
(e.g. by loading a DT overlay) from another function to usb0 will not work.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
