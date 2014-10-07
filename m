From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 07 Oct 2014 09:42:47 +0000
Subject: Re: [PATCH 2/2] arm: shmobile: lager: enable HS-USB
Message-Id: <5433B597.6030509@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412237073-1288-1-git-send-email-yoshihiro.shimoda.uh@renesas.com> <1412237073-1288-3-git-send-email-yoshihiro.shimoda.uh@renesas.com> <54330BC4.2050501@cogentembedded.com> <543331C4.90608@renesas.com>
In-Reply-To: <543331C4.90608-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org" <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, "magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hello.

On 10/7/2014 4:20 AM, Yoshihiro Shimoda wrote:

>>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>> ---
>>>    arch/arm/boot/dts/r8a7790-lager.dts |    5 +++++
>>>    1 file changed, 5 insertions(+)

>>> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
>>> index 1698591..4badd0a 100644
>>> --- a/arch/arm/boot/dts/r8a7790-lager.dts
>>> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
>>> @@ -445,3 +445,8 @@
>>>    		};
>>>    	};
>>>    };
>>> +
>>> +&hsusb {
>>> +	status = "okay";
>>> +	renesas,enable-gpio = <&gpio5 18 GPIO_ACTIVE_LOW>;
>>> +};

>>      Darn, this also misses the PinMux props... I was going to post v2 of these
>> patches but now would need to add that and retest... :-/

> I'm sorry for the my delayed work... I will submit v2 patches today.

> By the way, I cannot understand that "this also misses the PinMux props".
> According to the original "legacy" code in board-lager.c, it uses gpio5 18:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id6be7686caa05334ca8d52df157b373a41d8d9f1

    Right. But there are also USB0 pins.

> Best regards,
> Yoshihiro Shimoda

WBR, Sergei

