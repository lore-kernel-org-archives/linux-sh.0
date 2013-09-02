From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 02 Sep 2013 14:05:10 +0000
Subject: Re: [PATCH 1/4] ARM: shmobile: r8a7778: add Ether DT support
Message-Id: <52249B16.8010409@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehb8th3c.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehb8th3c.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 09/02/2013 05:14 PM, Laurent Pinchart wrote:

>> Define the generic R8A777x part of the Ether device node.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>>   arch/arm/boot/dts/r8a7778.dtsi |   11 +++++++++++
>>   1 file changed, 11 insertions(+)

>> Index: renesas/arch/arm/boot/dts/r8a7778.dtsi
>> =================================>> --- renesas.orig/arch/arm/boot/dts/r8a7778.dtsi
>> +++ renesas/arch/arm/boot/dts/r8a7778.dtsi
>> @@ -98,4 +98,15 @@
>>   		reg = <0xfffc000 0x118>;
>>   		#gpio-range-cells = <3>;
>>   	};
>> +
>> +	ether: ethernet@fde00000 {
>> +		device_type = "network";

> Documentation/devicetree/bindings/net/sh_eth.txt from "[PATCH 2/2] sh_eth: add
> device tree support" doesn't document this property, should you update it ?

    It's a standard property but completely optional for non-OF systems. I've 
not seen anybody document it but I should grep for it...

WBR, Sergei

