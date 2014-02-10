From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 10 Feb 2014 13:24:02 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7791: add Ether DT support
Message-Id: <52F8D2F2.7080703@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201402070112.48304.sergei.shtylyov@cogentembedded.com>
 <52F8CBFB.5060707@codethink.co.uk>
In-Reply-To: <52F8CBFB.5060707@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 10-02-2014 16:54, Ben Dooks wrote:

>> Define the generic R8A7791 part of the Ether device node.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>>   arch/arm/boot/dts/r8a7791.dtsi |   15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)

>> Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
>> =================================>> --- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
>> +++ renesas/arch/arm/boot/dts/r8a7791.dtsi
>> @@ -2,7 +2,8 @@
>>    * Device Tree Source for the r8a7791 SoC
>>    *
>>    * Copyright (C) 2013 Renesas Electronics Corporation
>> - * Copyright (C) 2013 Renesas Solutions Corp.
>> + * Copyright (C) 2013-2014 Renesas Solutions Corp.
>> + * Copyright (C) 2014 Cogent Embedded Inc.
>>    *
>>    * This file is licensed under the terms of the GNU General Public License
>>    * version 2.  This program is licensed "as is" without any warranty of any
>> @@ -366,6 +367,18 @@
>>           status = "disabled";
>>       };
>>
>> +    ether: ethernet@ee700000 {
>> +        compatible = "renesas,ether-r8a7791";
>> +        reg = <0 0xee700000 0 0x400>;
>> +        interrupt-parent = <&gic>;
>> +        interrupts = <0 162 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&mstp8_clks R8A7791_CLK_ETHER>;
>> +        phy-mode = "rmii";
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        status = "disabled";
>> +    };

> Is the device only capable of doing RMII?

    Yes.

WBR, Sergei

