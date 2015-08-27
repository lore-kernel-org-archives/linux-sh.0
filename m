From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 27 Aug 2015 01:16:07 +0000
Subject: Re: [PATCH 16/25 v7][RFC] arm64: renesas: salvator-x: add pfc node and subnodes for usb 2.0
Message-Id: <55DE64D7.3070600@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <876145776m.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <876145776m.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert-san,

(2015/08/26 23:26), Geert Uytterhoeven wrote:
> Hi Shimoda-san, Morimoto-san, Kihara-san,
> 
> On Mon, Aug 24, 2015 at 4:30 AM, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
>> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
>> --- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
>> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
>> @@ -38,6 +38,23 @@
>>         };
>>  };
>>
>> +&pfc {
>> +       usb0_pins: usb0 {
>> +               renesas,groups = "usb0";
>> +               renesas,function = "usb0";
>> +       };
>> +
>> +       usb1_pins: usb1 {
>> +               renesas,groups = "usb1";
>> +               renesas,function = "usb1";
>> +       };
>> +
>> +       usb2_pins: usb2 {
>> +               renesas,groups = "usb2";
>> +               renesas,function = "usb2";
>> +       };
>> +};
> 
> If CONFIG_PINCTRL=y:
> 
> | sh-pfc e6060000.pfc: cannot locate data/mark enum_id for mark 2253
> | phy_rcar_gen3_usb2 ee080200.usb-phy: Error applying setting, reverse
> things back
> 
> mark 2253 = USB0_PWEN_MARK
> 
> I believe this is due to the IPSR16 section in the pinmux_data[] array in
> drivers/pinctrl/sh-pfc/pfc-r8a7795.c lacking data for IP16_11_8.
> Data for usb1 (IP16_19_16) and usb2 (IP15_3_0) is present.
> 
> Unfortunately my pinctrl foo is not strong enough to fill in the missing
> pieces...

Thank you very much for the point.
I have ignored the error message because usb0 worked on my environment :)
However, we should fix it. And then, I found missing pieces for usb0 part as you mentioned.
If I applied the following patch, the error message disappeared and usb0 also worked.

So, Morimoto-san, if possible, would you merge this patch in v8?

Best regards,
Yoshihiro Shimoda

---
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 9437e87..1f60f4c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -1335,6 +1335,19 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_DATA(IP15_31_28, SCK5),

 	/* IPSR16 */
+	PINMUX_IPSR_DATA(IP16_11_8, USB0_PWEN),
+	PINMUX_IPSR_MODSEL_DATA(IP16_11_8, SIM0_RST_C, SEL_SIMCARD_2),
+	PINMUX_IPSR_MODSEL_DATA(IP16_11_8, TS_SCK1_D, SEL_TSIF1_3),
+	PINMUX_IPSR_MODSEL_DATA(IP16_11_8, STP_ISCLK_1_D, SEL_SSP1_1_3),
+	PINMUX_IPSR_MODSEL_DATA(IP16_11_8, BPFCLK_B, SEL_FM_1),
+	PINMUX_IPSR_MODSEL_DATA(IP16_11_8, RIF3_CLK_B, SEL_DRIF3_1),
+
+	PINMUX_IPSR_DATA(IP16_15_12, USB0_OVC),
+	PINMUX_IPSR_MODSEL_DATA(IP16_15_12, SIM0_D_C, SEL_SIMCARD_2),
+	PINMUX_IPSR_MODSEL_DATA(IP16_15_12, TS_SDAT1_D, SEL_TSIF1_3),
+	PINMUX_IPSR_MODSEL_DATA(IP16_15_12, STP_ISD_1_D, SEL_SSP1_1_3),
+	PINMUX_IPSR_MODSEL_DATA(IP16_15_12, RIF3_SYNC_B, SEL_DRIF3_1),
+
 	PINMUX_IPSR_DATA(IP16_19_16, USB1_PWEN),
 	PINMUX_IPSR_MODSEL_DATA(IP16_19_16, SIM0_CLK_C, SEL_SIMCARD_2),
 	PINMUX_IPSR_MODSEL_DATA(IP16_19_16, SSI_SCK1_A, SEL_SSI_0),
