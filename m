From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 11 Dec 2013 16:52:54 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7778: add SSIx DMAEngine support
Message-Id: <52A89866.8020502@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r49ubr9m.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r49ubr9m.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 11-12-2013 5:40, Simon Horman wrote:

>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[...]

>> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
>> index 81701cf..e786338 100644
>> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
>> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
>> @@ -319,6 +319,29 @@ void __init r8a7778_add_dt_devices(void)
>>   #define HPB_DMAE_ASYNCMDR_ASMD21_SINGLE	BIT(1)	/* SDHI0 */
>>   #define HPB_DMAE_ASYNCMDR_ASMD21_MULTI	0	/* SDHI0 */
>>
>> +#define HPBDMA_SSI(_id)				\
>> +{						\
>> +	.id	= HPBDMA_SLAVE_SSI## _id ##_TX,	\
>> +	.addr	= 0xffd91008 + (_id * 0x40),	\
>> +	.dcr	= HPB_DMAE_DCR_CT |		\
>> +		  HPB_DMAE_DCR_DIP |		\
>> +		  HPB_DMAE_DCR_SPDS_32BIT |	\
>> +		  HPB_DMAE_DCR_DMDL |		\
>> +		  HPB_DMAE_DCR_DPDS_32BIT,	\
>> +	.port   = _id + (_id << 8),		\
>> +	.dma_ch = (28 + _id),			\
>> +}, {						\
>> +	.id	= HPBDMA_SLAVE_SSI## _id ##_RX,	\
>> +	.addr	= 0xffd9100c + (_id * 0x40),	\
>> +	.dcr	= HPB_DMAE_DCR_CT |		\
>> +		  HPB_DMAE_DCR_DIP |		\
>> +		  HPB_DMAE_DCR_SMDL |		\
>> +		  HPB_DMAE_DCR_SPDS_32BIT |	\
>> +		  HPB_DMAE_DCR_DPDS_32BIT,	\
>> +	.port   = _id + (_id << 8),		\
>> +	.dma_ch = (28 + _id),			\
>> +}
>> +

> Unfortunately checkpatch seems unhappy about this.
> I think it wants you to surround _id with () inside the macro.

    No, it wants one to enclose the whole macro body in () in this case (which 
would be wrong). You're right about enclosing '_id' into parens,

> Could you fix it up?

> ERROR: Macros with complex values should be enclosed in parenthesis
> #99: FILE: arch/arm/mach-shmobile/setup-r8a7778.c:322:
> +#define HPBDMA_SSI(_id)				\
> +{						\
> +	.id	= HPBDMA_SLAVE_SSI## _id ##_TX,	\
> +	.addr	= 0xffd91008 + (_id * 0x40),	\
> +	.dcr	= HPB_DMAE_DCR_CT |		\
> +		  HPB_DMAE_DCR_DIP |		\
> +		  HPB_DMAE_DCR_SPDS_32BIT |	\
> +		  HPB_DMAE_DCR_DMDL |		\
> +		  HPB_DMAE_DCR_DPDS_32BIT,	\
> +	.port   = _id + (_id << 8),		\
> +	.dma_ch = (28 + _id),			\
> +}, {						\
> +	.id	= HPBDMA_SLAVE_SSI## _id ##_RX,	\
> +	.addr	= 0xffd9100c + (_id * 0x40),	\
> +	.dcr	= HPB_DMAE_DCR_CT |		\
> +		  HPB_DMAE_DCR_DIP |		\
> +		  HPB_DMAE_DCR_SMDL |		\
> +		  HPB_DMAE_DCR_SPDS_32BIT |	\
> +		  HPB_DMAE_DCR_DPDS_32BIT,	\
> +	.port   = _id + (_id << 8),		\
> +	.dma_ch = (28 + _id),			\
> +}

> total: 1 errors, 0 warnings, 109 lines checked

WBR, Sergei

