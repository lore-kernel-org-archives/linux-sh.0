From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 08 Apr 2014 13:58:49 +0000
Subject: Re: [PATCH 6/9] ARM: shmobile: r8a7790: add audio dmac node
Message-Id: <53440099.5010002@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1396901229-29117-1-git-send-email-ben.dooks@codethink.co.uk> <1396901229-29117-7-git-send-email-ben.dooks@codethink.co.uk> <53430CFC.7000107@cogentembedded.com>
In-Reply-To: <53430CFC.7000107@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, horms@verge.net.au, g.liakhovetski@gmx.d, kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org

On 07/04/14 21:39, Sergei Shtylyov wrote:
> Hello.
>
> On 04/08/2014 12:07 AM, Ben Dooks wrote:
>
>> Add initial audio dmac node and resources.
>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>   arch/arm/boot/dts/r8a7790.dtsi | 68
>> ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 68 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/r8a7790.dtsi
>> b/arch/arm/boot/dts/r8a7790.dtsi
>> index 2c8cbbd..6032783 100644
>> --- a/arch/arm/boot/dts/r8a7790.dtsi
>> +++ b/arch/arm/boot/dts/r8a7790.dtsi
>> @@ -176,6 +176,74 @@
>>           };
>>       };
>>
>> +    dma1: dma-mux@1 {
>> +        compatible = "renesas,shdma-mux";
>> +        #dma-cells = <1>;
>> +        dma-channels = <20>;
>> +        dma-requests = <256>;
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        ranges;
>> +
>> +        audiodma0: dmac@ec700000 {
>
>     According to the ePARR standard [1], the node name should be
> "dma-controller", not just "dmac".
>
>> +            compatible = "renesas,dma-r8a7790", "renesas,dma-arm";
>> +            clocks = <&mstp5_clks R8A7790_CLK_AUDIO_DMAC0>;
>> +            dma-channels = <13>;
>> +            status = "disabled";
>> +            reg = <0 0xec700020 0 0xffc0>;
>> +            interrupt-parent = <&gic>;
>
>     Shouldn't it be just inherited from the top level node?

Thanks, it should be in this case and forgot to remove it.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
