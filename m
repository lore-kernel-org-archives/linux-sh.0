From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Mon, 19 Mar 2012 00:57:44 +0000
Subject: Re: [PATCH 2/2] sh: dma: Collect up CHCR of SH7763, SH7764, SH7780 and SH7785
Message-Id: <4F668488.5040808@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1331865086-20880-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1331865086-20880-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hi,

Simon Horman さんは書きました:
> Hi Iwamatsu-san,
> 
> On Fri, Mar 16, 2012 at 11:31:26AM +0900, Nobuhiro Iwamatsu wrote:
>> CHCR of SH7763, SH7764, SH7780 and SH7785 is constitution same as SH7757.
> 
> Is it intentional that this patch changes the definition of
> CHCR_TS_HIGH_MASK and CHCR_TS_HIGH_SHIFT for sh7763, sh7764, sh7780 and
> sh7785 ?
> 

Yes, I checked this change with manual of Japanese and English.

Best regards,
   Nobuhiro

> Is it also intentional that there is no longer a default case?
> 
>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>> ---
>>  arch/sh/include/cpu-sh4/cpu/dma-register.h |   22 +++++-----------------
>>  1 files changed, 5 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/sh/include/cpu-sh4/cpu/dma-register.h b/arch/sh/include/cpu-sh4/cpu/dma-register.h
>> index 1af4a95..02788b6 100644
>> --- a/arch/sh/include/cpu-sh4/cpu/dma-register.h
>> +++ b/arch/sh/include/cpu-sh4/cpu/dma-register.h
>> @@ -30,27 +30,15 @@
>>  #define CHCR_TS_LOW_SHIFT	3
>>  #define CHCR_TS_HIGH_MASK	0x00300000
>>  #define CHCR_TS_HIGH_SHIFT	(20 - 2)	/* 2 bits for shifted low TS */
>> -#elif defined(CONFIG_CPU_SUBTYPE_SH7763) || \
>> -	defined(CONFIG_CPU_SUBTYPE_SH7764)
>> -#define CHCR_TS_LOW_MASK	0x00000018
>> -#define CHCR_TS_LOW_SHIFT	3
>> -#define CHCR_TS_HIGH_MASK	0
>> -#define CHCR_TS_HIGH_SHIFT	0
>> -#elif defined(CONFIG_CPU_SUBTYPE_SH7757)
>> +#elif defined(CONFIG_CPU_SUBTYPE_SH7757) || \
>> +	defined(CONFIG_CPU_SUBTYPE_SH7763) || \
>> +	defined(CONFIG_CPU_SUBTYPE_SH7764) || \
>> +	defined(CONFIG_CPU_SUBTYPE_SH7780) || \
>> +	defined(CONFIG_CPU_SUBTYPE_SH7785)
>>  #define CHCR_TS_LOW_MASK	0x00000018
>>  #define CHCR_TS_LOW_SHIFT	3
>>  #define CHCR_TS_HIGH_MASK	0x00100000
>>  #define CHCR_TS_HIGH_SHIFT	(20 - 2)	/* 2 bits for shifted low TS */
>> -#elif defined(CONFIG_CPU_SUBTYPE_SH7780)
>> -#define CHCR_TS_LOW_MASK	0x00000018
>> -#define CHCR_TS_LOW_SHIFT	3
>> -#define CHCR_TS_HIGH_MASK	0
>> -#define CHCR_TS_HIGH_SHIFT	0
>> -#else /* SH7785 */
>> -#define CHCR_TS_LOW_MASK	0x00000018
>> -#define CHCR_TS_LOW_SHIFT	3
>> -#define CHCR_TS_HIGH_MASK	0
>> -#define CHCR_TS_HIGH_SHIFT	0
>>  #endif
>>  
>>  /* Transmit sizes and respective CHCR register values */
>> -- 
>> 1.7.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 

