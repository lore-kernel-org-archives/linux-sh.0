From: Bastian Hecht <hechtb@googlemail.com>
Date: Sun, 19 Feb 2012 10:34:44 +0000
Subject: Re: [PATCH v2 1/7] mtd: sh_flctl: Expand FLCMNCR register bit field
Message-Id: <CABYn4swJxi_30duDZnYzBTU8uR0bsVd-9XDEEQDsuL8xiiHypA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1328960705-18699-1-git-send-email-hechtb@gmail.com>
 <1328960705-18699-2-git-send-email-hechtb@gmail.com>
 <1554023.Gzzuis43Tg@avalon>
In-Reply-To: <1554023.Gzzuis43Tg@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

Hello Laurent,

thanks for reviewing this patch.

2012/2/18 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> Hi Bastian,
>
> Thanks for the patch.
>
> On Saturday 11 February 2012 12:44:59 Bastian Hecht wrote:
>> Add support for a new hardware generation. The meaning of some bits
>> of the FLCMNCR register changed, so some new defines are added
>> parallel to the existing ones to keep backward compatibility.
>>
>> The defines allow to choose an appropriate clocking scheme.
>>
>> Signed-off-by: Bastian Hecht <hechtb@gmail.com>
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
>> ---
>> changelog: code stays the same, just the description is slightly correct=
ed.
>>
>> =A0include/linux/mtd/sh_flctl.h | =A0 24 ++++++++++++++++++++++++
>> =A01 files changed, 24 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
>> index 9cf4c4c..e66c393 100644
>> --- a/include/linux/mtd/sh_flctl.h
>> +++ b/include/linux/mtd/sh_flctl.h
>> @@ -67,6 +67,30 @@
>> =A0#define =A0 =A0 =A0CE0_ENABLE =A0 =A0 =A0(0x1 << 3) =A0 =A0 =A0/* Chi=
p Enable 0 */
>> =A0#define =A0 =A0 =A0TYPESEL_SET =A0 =A0 (0x1 << 0)
>>
>> +/*
>> + * Clock settings using the PULSEx registers from FLCMNCR
>> + *
>> + * Some hardware uses bits called PULSEx instead of FCKSEL_E and QTSEL_E
>> + * to control the clock divider used between the High-Speed Peripheral
>> Clock + * and the FLCTL internal clock. If so, use CLK_8_BIT_xxx for
>> connecting 8 bit + * and CLK_16_BIT_xxx for connecting 16 bit bus bandwi=
th
>> NAND chips. For the 16 + * bit version the divider is seperate for the
>> pulse width of high and low + * signals.
>> + */
>> +#define PULSE3 =A0 =A0 =A0 (0x1 << 27)
>> +#define PULSE2 =A0 =A0 =A0 (0x1 << 17)
>> +#define PULSE1 =A0 =A0 =A0 (0x1 << 15)
>> +#define PULSE0 =A0 =A0 =A0 (0x1 << 9)
>> +#define CLK_8_BIT_0_5HP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PULS=
E1
>> +#define CLK_8_BIT_1HP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0
>> +#define CLK_8_BIT_1_5HP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(PUL=
SE1 | PULSE2)
>> +#define CLK_8_BIT_2HP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PU=
LSE0
>> +#define CLK_8_BIT_3HP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(P=
ULSE0 | PULSE1 | PULSE2)
>> +#define CLK_8_BIT_4HP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(P=
ULSE0 | PULSE2)
>> +#define CLK_16_BIT_6HP_LOW_2HP_HIGH =A0PULSE0
>> +#define CLK_16_BIT_9HP_LOW_3HP_HIGH =A0(PULSE0 | PULSE1 | PULSE2)
>> +#define CLK_16_BIT_12HP_LOW_4HP_HIGH (PULSE0 | PULSE2)
>> +
>
> This is nitpicking, but you could shorten the names to something like
> CLK_16B_12L_4P (at the expense of readability though). Feel free to ignore
> this.

Well yeah - I felt a bit unsure about the verbosity too, so I'll take
your suggestion, thanks.

>> =A0/* FLCMDCR control bits */
>> =A0#define ADRCNT2_E =A0 =A0(0x1 << 31) =A0 =A0 /* 5byte address enable =
*/
>> =A0#define ADRMD_E =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1 << 26) =A0 =A0 /* Sec=
tor address access */
> --
> Regards,
>
> Laurent Pinchart

thanks,

 Bastian
