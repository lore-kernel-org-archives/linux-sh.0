From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 20 Jul 2012 00:57:27 +0000
Subject: Re: [PATCH] i2c: Add support SuperH SH7734 I2C bus controller
Message-Id: <5008ACF7.6000009@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1334188641-14641-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
 <87d37d37ml.wl%kuninori.morimoto.gx@renesas.com>
 <CABMQnVKQAfdnQ+CfSuYSXQHmOyjQzPzngzTVLm6an2-haQAKZg@mail.gmail.com>
 <87y5q02cv2.wl%kuninori.morimoto.gx@renesas.com>
 <CABMQnVK8Jt1cZZA-w9xnfrMZNvRbe4r+Sjm3YeF3o6utX0g93Q@mail.gmail.com>
 <87aa2c7d2a.wl%kuninori.morimoto.gx@renesas.com>
 <4F8B7019.2030307@renesas.com>
 <OF7FE4858F.5425E857-ON80257A3F.002C2DA0-80257A3F.002E3111@eu.necel.com>
In-Reply-To: <OF7FE4858F.5425E857-ON80257A3F.002C2DA0-80257A3F.002E3111-mWMTcI9IYFFWk0Htik3J/w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
To: phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-SH <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sh-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Hi, Phil.

phil.edworthy@renesas.com さんは書きました:
> Hi Iwamatsu-san,
> 
>> Date: 16/04/2012 01:58
>> Subject: Re: [PATCH] i2c: Add support SuperH SH7734 I2C bus controller
>> Sent by: linux-sh-owner@vger.kernel.org
>>
>> Kuninori Morimoto さんは書きました:
>>> Hi Iwamatsu-san
>>>
>>>>> I guess R-Car is not same as this I2C.
>>>>> And sorry, SH7734 seems not same as SH-NAVI.
>>>>> Now I'm checking the series.
>>>>> Please wait.
>>>>>
>>>> I already checked SH7775 and SH7776. These are SH-NAVI series.
>>>> But these CPU's are constitution unlike I2C of SH7734.
>>> I got the information about it this morning.
>>> SH7734 I2C came from SH7266, and it came from SH-NaviJ3.
>>>
>> I comfirmed these, thanks.
>> OK, I will rename file and update description.
> 
> I noticed your sh7734 i2c patch and realised that the registers are the same as sh7269 (sh2a). I tried this driver on sh7269, but I had to make some
> changes to use it.
> 
> The following code is not suitable for sh7269:
> +	/* Mask clear interrupts */
> +	if (pd->adap.nr = 0)
> +		__raw_writel(I2C_INT_ALL, I2C0_INTMASK_CLR);
> +	else if (pd->adap.nr = 1)
> +		__raw_writel(I2C_INT_ALL, I2C1_INTMASK_CLR);
> 
> +	/* Mask interrupts */
> +	if (pd->adap.nr = 0)
> +		__raw_writel(I2C_INT_ALL, I2C0_INTMASK);
> +	else if (pd->adap.nr = 1)
> +		__raw_writel(I2C_INT_ALL, I2C1_INTMASK);
> 
> Do you plan to send this driver again? If yes, maybe add #ifdef CPU_SUBTYPE_SH7734 around this code, or add platform data to enable it.

I will resend patch with some fixes and your point.

Best regards,
  Nobuhiro
