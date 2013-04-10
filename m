From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 10 Apr 2013 12:08:28 +0000
Subject: Re: [PATCH v4] dma: sudmac: add support for SUDMAC
Message-Id: <5165563C.3000909@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5163E470.7010107@renesas.com>
In-Reply-To: <5163E470.7010107@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 10-04-2013 5:12, Kuninori Morimoto wrote:

>> diff --git a/include/linux/sudmac.h b/include/linux/sudmac.h
> (snip)
>> +/* Definitions for the sudmac_channel.config */
>> +#define SUDMAC_SENDBUFM	0x1000 /* b12: Transmit Buffer Mode */
>> +#define SUDMAC_RCVENDM	0x0100 /* b8: Receive Data Transfer End Mode */
>> +#define SUDMAC_LBA_WAIT	0x0030 /* b5-4: Local Bus Access Wait */
>> +
>> +/* Definitions for the sudmac_channel.dint_end_bit */
>> +#define SUDMAC_CH1ENDE	0x0002 /* b1: Ch1 DMA Transfer End Int Enable */
>> +#define SUDMAC_CH0ENDE	0x0001 /* b0: Ch0 DMA Transfer End Int Enable */

> I think these are used as register value,
> and it comes from board/platform directly ?

> But it is not good approach for me,
> because it is easy to break driver.

> Can you use like this style ?

> --- xxxx.h ----
> #define SUDMAC_TX_BUFFER_MODE	(1 << 0)
> #define SUDMAC_RV_END_MODE	(1 << 1)
> ...

    Better yet, use the BIT() macro (althought it won't help if you'll have to 
define a bitfield.

WBR, Sergei

