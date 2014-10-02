From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 02 Oct 2014 11:40:08 +0000
Subject: Re: [PATCH 1/2] arm: shimobile: r8a7790: add HS-USB device node
Message-Id: <542D3998.7000303@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412237073-1288-1-git-send-email-yoshihiro.shimoda.uh@renesas.com> <1412237073-1288-2-git-send-email-yoshihiro.shimoda.uh@renesas.com> <542D21BD.8020709@cogentembedded.com>
In-Reply-To: <542D21BD.8020709-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello.

(2014/10/02 18:58), Sergei Shtylyov wrote:
> On 10/2/2014 12:04 PM, Yoshihiro Shimoda wrote:
> 
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> ---
>>   arch/arm/boot/dts/r8a7790.dtsi |   10 ++++++++++
>>   1 file changed, 10 insertions(+)
> 
>> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
>> index 2380fd5..fd9fc37 100644
>> --- a/arch/arm/boot/dts/r8a7790.dtsi
>> +++ b/arch/arm/boot/dts/r8a7790.dtsi
>> @@ -1314,4 +1314,14 @@
>>               ssi9: ssi@9 { interrupts = <0 379 IRQ_TYPE_LEVEL_HIGH>; };
>>           };
>>       };
>> +
>> +    hsusb: usb@e6590000 {
>> +        compatible = "renesas,usbhs-r8a7790";
>> +        reg = <0 0xe6590000 0 0x100>;
>> +        interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
> 
>    I don't see where are you handling this prop in the driver...

Thank you for the point. I misunderstood this prop.
Since the driver is using pm_runtime functions, I thought that
this device node needs this prop.

So, I will remove this. And, I will also modify the Documentation.

>> +        renesas,buswait_bwait = <4>;
> 
>    This prop is named "renesas,buswait" now.

Thank you for the point. I will fix it.

Best regards,
Yoshihiro Shimoda

>> " +        phys = <&usb0 1>;
>> +        phy-names = "usb";
>> +    };
>>   };
> 
> WBR, Sergei
> 
