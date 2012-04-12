From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Thu, 12 Apr 2012 08:18:20 +0000
Subject: Re: [PATCH] i2c: Add support SuperH SH7734 I2C bus controller
Message-Id: <CABMQnVKQAfdnQ+CfSuYSXQHmOyjQzPzngzTVLm6an2-haQAKZg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1334188641-14641-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
 <87d37d37ml.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d37d37ml.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Magnus <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-SH <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

2012/4/12 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>:
>
> Hi Iwamatsu-san
>
>> This is the SuperH SH7734 I2C Controller Driver.
>> A simple Master only support driver for the I2C included in processors SH7734 only.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>> ---
>
> I guess we can use this I2C driver in other SuperH Navi series.
> (not only SH7734 CPU)
>

Well, the SH-NAVI series hss I2C.
However, I assume it support only for SH7734 because bus width and
register constitution are different.
If you point it out about R-Car, I will examine R-Car. (R-Car is not SH-NAVI).

Best regards,
  Nobuhiro
-- 
Nobuhiro Iwamatsu
