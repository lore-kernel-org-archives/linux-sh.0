From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Fri, 30 May 2014 02:23:45 +0000
Subject: Re: [PATCH 3/7] ARM: shmobile: Disable DVS support for r8a7790
Message-Id: <5387EBB1.5060406@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5386E66D.3020502@bp.renesas.com>
In-Reply-To: <5386E66D.3020502@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei

>> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
>> index ab73ed0..9becef7 100644
>> --- a/arch/arm/boot/dts/r8a7790-lager.dts
>> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
>> @@ -317,7 +317,3 @@
>>   	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
>>   	status = "okay";
>>   };
>> -
>> -&cpu0 {
>> -	cpu0-supply = <&vdd_dvfs>;
>> -};
>    Why enable it in the first place (patch #1)?
>

patch #1 is created by Benoit. At the first, I thought better to
create a separate patch without changing his code. After that,
I understand that this method was wrong.

I will re-post by changing the patch #1. (disable DVS)


