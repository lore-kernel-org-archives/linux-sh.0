From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sun, 30 Mar 2014 19:51:14 +0000
Subject: Re: [PATCH 8/9] ARM: shmobile: lager.dts: add usbphy reference
Message-Id: <533875B2.9030806@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk> <1394128887-4197-9-git-send-email-ben.dooks@codethink.co.uk> <5338704C.2030501@cogentembedded.com>
In-Reply-To: <5338704C.2030501-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org, magnus.damn-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org, horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On 30/03/14 20:28, Sergei Shtylyov wrote:
> Hello.
>
> On 03/06/2014 09:01 PM, Ben Dooks wrote:
>
>> Enable the usbphy node so that the phy driver is available.
>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
>> ---
>> Cc: linux-sh@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: Simon Horman <horms@verge.net.au>
>> ---
>>   arch/arm/boot/dts/r8a7790-lager.dts | 4 ++++
>>   1 file changed, 4 insertions(+)
>
>> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts
>> b/arch/arm/boot/dts/r8a7790-lager.dts
>> index fd6851f..63d58d6 100644
>> --- a/arch/arm/boot/dts/r8a7790-lager.dts
>> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
>> @@ -246,3 +246,7 @@
>>       pinctrl-0 = <&usb2_pins>;
>>       pinctrl-names = "default";
>>   };
>> +
>> +&usbphy {
>> +    status = "okay";
>> +};
>
>     I don't see why we need this patch. Why not make USB PHY always
> enabled?

I have a current setup where we do not want the kernel to try
and probe the phy device.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
