From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 22 Jun 2015 09:45:30 +0000
Subject: Re: [PATCH 02/08] clocksource: sh_cmt: Use 0x3f mask for SH_CMT_48BIT case
Message-Id: <CANqRtoRs_uiBGCTa=+M0turFpyyf1kAfohzyqoRBvgKmo1eg=Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150621080903.10187.20998.sendpatchset@little-apple>
	<20150621080927.10187.98007.sendpatchset@little-apple>
	<CAMuHMdVgEh3d_OU1NVTHuP2gYrHf6mj36FQaTjMKBzqn6JA_cw@mail.gmail.com>
In-Reply-To: <CAMuHMdVgEh3d_OU1NVTHuP2gYrHf6mj36FQaTjMKBzqn6JA_cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Simon Horman <horms+renesas@verge.net.au>, Thomas Gleixner <tglx@linutronix.de>

On Mon, Jun 22, 2015 at 6:43 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sun, Jun 21, 2015 at 10:09 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Always use 0x3f as channel mask for the SH_CMT_48BIT type of devices.
>> Once this patch is applied the "renesas,channels-mask" property will
>> be ignored by the driver for older devices matching SH_CMT_48BIT. In
>> the future when all CMT types store channel mask in the driver then
>> we will be able to deprecate and remove "renesas,channels-mask" from DTS.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> ---
>>
>>  drivers/clocksource/sh_cmt.c |   14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> --- 0001/drivers/clocksource/sh_cmt.c
>> +++ work/drivers/clocksource/sh_cmt.c   2015-06-20 15:25:54.302366518 +0900
>
>> @@ -969,9 +972,14 @@ static int sh_cmt_setup(struct sh_cmt_de
>>                 id = of_match_node(sh_cmt_of_table, pdev->dev.of_node);
>>                 cmt->info = id->data;
>>
>> -               ret = sh_cmt_parse_dt(cmt);
>> -               if (ret < 0)
>> -                       return ret;
>> +               /* prefer in-driver channel configuration over DT */
>> +               if (cmt->info->channels_mask) {
>> +                       cmt->hw_channels = cmt->info_channels_mask;
>
> drivers/clocksource/sh_cmt.c: In function 'sh_cmt_setup':
> drivers/clocksource/sh_cmt.c:996:26: error: 'struct sh_cmt_device' has
> no member named 'info_channels_mask'
>     cmt->hw_channels = cmt->info_channels_mask;
>                           ^
>
> "cmt->info->channels_mask"

Ouch, will fix. Thanks!

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
