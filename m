From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 19 Feb 2015 17:02:56 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7794: add MMCIF DT support
Message-Id: <54E61740.8030708@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <29687119.ELU9MoH02q@wasted.cogentembedded.com>
 <4040756.88Rqm1nt32@wasted.cogentembedded.com>
 <20150219161012.GA3864@verge.net.au>
In-Reply-To: <20150219161012.GA3864@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 02/19/2015 07:10 PM, Simon Horman wrote:

>> Define the generic R8A7794 part of the MMCIF0 device node.

>> Based on the orginal patch by Shinobu Uehara <shinobu.uehara.xc@renesas.com>.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>>   arch/arm/boot/dts/r8a7794.dtsi |   11 +++++++++++
>>   1 file changed, 11 insertions(+)

>> Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
>> =================================>> --- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
>> +++ renesas/arch/arm/boot/dts/r8a7794.dtsi
>> @@ -346,6 +346,17 @@
>>   		status = "disabled";
>>   	};
>>
>> +	mmcif0: mmc@ee200000 {
>> +		compatible = "renesas,mmcif-r8a7794", "renesas,sh-mmcif";

> Please submit a patch to add "renesas,mmcif-r8a7794" to
> Documentation/devicetree/bindings/mmc/renesas,mmcif.txt.
> I looked and I couldn't find such a change in-tree or in-flight.

    That file doesn't match the reality at all. It says:

<<
- compatible: must contain one of the following
         - "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
         - "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
         - "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
         - "renesas,sh-mmcif" for the generic MMCIF
 >>

while in reality, the driver only matches on the latter string and doesn't 
care for the SoC specific strings.

WBR, Sergei

