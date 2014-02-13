From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 13 Feb 2014 18:18:15 +0000
Subject: Re: [PATCH 2/5] ARM: shmobile: r8a7790: add dmac0 dmac1 nodes
Message-Id: <52FD0C67.4030802@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1375892397-5822-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375892397-5822-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 12/02/14 20:55, Sergei Shtylyov wrote:
> On 02/12/2014 08:59 PM, Ben Dooks wrote:
>
>     No signoff but that's again intentional?
>
>> ---
>>   arch/arm/boot/dts/r8a7790.dtsi | 89
>> ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 89 insertions(+)
>
>> diff --git a/arch/arm/boot/dts/r8a7790.dtsi
>> b/arch/arm/boot/dts/r8a7790.dtsi
>> index 700e0a1..ae65270 100644
>> --- a/arch/arm/boot/dts/r8a7790.dtsi
>> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> [...]
>> @@ -79,6 +80,94 @@
>>           };
>>       };
>>
>> +#define CHCR_RX_32BIT    SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_32BIT)
>> +#define CHCR_TX_32BIT    SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_32BIT)
>> +#define CHCR_RX_256BIT    SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_256BIT)
>> +#define CHCR_TX_256BIT    SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_256BIT)
>> +
>> +    dma0: dma-mux@0 {
>> +        compatible = "renesas,shdma-mux";
>> +        #dma-cells = <1>;
>> +        dma-channels = <20>;
>> +                dma-requests = <256>;
>> +                #address-cells = <2>;
>> +                #size-cells = <2>;
>> +                ranges;
>
>     The above 4 lines are indented with spaces instead of tabs.
>
> WBR, Sergei

Missed indentation, will fix thanks.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
