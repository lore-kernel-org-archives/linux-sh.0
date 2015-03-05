From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Thu, 05 Mar 2015 04:23:15 +0000
Subject: Re: [PATCH 1/5] ARM: shmobile: r8a7794 SYSC setup code
Message-Id: <54F7DA33.6040008@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <54F50C56.5030605@bp.renesas.com>
In-Reply-To: <54F50C56.5030605@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert-san,

On 2015/03/04 17:41, Geert Uytterhoeven wrote:
> Hi Inami-san,
>
> On Wed, Mar 4, 2015 at 5:46 AM, Gaku Inami <gaku.inami.xw@bp.renesas.com> wrote:
>>>> +static void __init r8a7794_sysc_init(void)
>>>> +{
>>>> +    void __iomem *base = rcar_sysc_init(0xe6180000);
>>>> +
>>>> +    /* enable all interrupt sources, but do not use interrupt handler */
>>>> +    iowrite32(0x00310060, base + SYSCIER);
>>> Is it intentional that 0x00310060 differs from
>>> the value of 0x0131000e used on the r8a7790 and r8a7791?
>> Yes. According to R-CAR Gen2 HW manual, interrupt bits are
>> different in each SoC. Therefore, I think the setting value
>> of SYSCIER should be set to a different value in each SoC.
>>
>> *Setting value of SYSCIER
>>  r8a7790 : 0x013111EF
>>  r8a7791 : 0x00111003
>>  r8a7794 : 0x00310060
>>
>> I don't know why the value of 0x0131000e is used on the r8a7790
>> and the r8a7791. (maybe wrong value)
> This value was most probably just copied from pm-r8a7779.c
> R-Car H1 has 4 four ARM cores, but there's no interrupt bit for ARM0,
> hence the 0xe value for the lowest nibble.
>
Thank you for your comment. That make sense.

Regards,
Inami

