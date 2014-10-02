From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 02 Oct 2014 11:48:49 +0000
Subject: Re: [PATCH 2/3] arm: shmobile: koelsch: enable HS-USB
Message-Id: <542D3BA1.2010902@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412237135-1668-1-git-send-email-yoshihiro.shimoda.uh@renesas.com> <1412237135-1668-3-git-send-email-yoshihiro.shimoda.uh@renesas.com> <542D22D0.4000209@cogentembedded.com>
In-Reply-To: <542D22D0.4000209-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello.

(2014/10/02 19:02), Sergei Shtylyov wrote:
> On 10/2/2014 12:05 PM, Yoshihiro Shimoda wrote:
> 
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> ---
>>   arch/arm/boot/dts/r8a7791-koelsch.dts |    5 +++++
>>   1 file changed, 5 insertions(+)
> 
>> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
>> index 3f55c16..b3dac1a 100644
>> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
>> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
>> @@ -495,3 +495,8 @@
>>           };
>>       };
>>   };
>> +
>> +&hsusb {
>> +    status = "okay";
>> +    renesas,enable-gpio = <&gpio5 18 GPIO_ACTIVE_LOW>;
> 
>    I think it's GP5_31 on Koelsch instead, i.e. the ID output from MAX3355.

Thank you for the point. I will fix this.

Best regards,
Yoshihiro Shimoda

> WBR, Sergei
> 
