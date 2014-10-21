From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Tue, 21 Oct 2014 11:33:52 +0000
Subject: Re: [PATCH v2] media: soc_camera: rcar_vin: Add BT.709 24-bit RGB888 input support
Message-Id: <CAH1o70Jk=dCf3VWqdAJmGzd6TSQFeN=x+FCKExDzaf0BZF0L1A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1413868129-22121-1-git-send-email-ykaneko0929@gmail.com>
	<544633D3.5010805@cogentembedded.com>
In-Reply-To: <544633D3.5010805@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hello Sergei,

2014-10-21 19:22 GMT+09:00 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>:
> Hello.
>
> On 10/21/2014 9:08 AM, Yoshihiro Kaneko wrote:
>
>> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>
>
>> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>> ---
>
>
>> This patch is against master branch of linuxtv.org/media_tree.git.
>
>
>> v2 [Yoshihiro Kaneko]
>> * remove unused/useless definition as suggested by Sergei Shtylyov
>
>
>    I didn't say it's useless, I just suspected that you missed the necessary
> test somewhere...

Sorry for my inaccurate description.

>
>>   drivers/media/platform/soc_camera/rcar_vin.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>
>
>> diff --git a/drivers/media/platform/soc_camera/rcar_vin.c
>> b/drivers/media/platform/soc_camera/rcar_vin.c
>> index 20defcb..cb5e682 100644
>> --- a/drivers/media/platform/soc_camera/rcar_vin.c
>> +++ b/drivers/media/platform/soc_camera/rcar_vin.c
>> @@ -74,6 +74,7 @@
>>   #define VNMC_INF_YUV10_BT656  (2 << 16)
>>   #define VNMC_INF_YUV10_BT601  (3 << 16)
>>   #define VNMC_INF_YUV16                (5 << 16)
>> +#define VNMC_INF_RGB888                (6 << 16)
>>   #define VNMC_VUP              (1 << 10)
>>   #define VNMC_IM_ODD           (0 << 3)
>>   #define VNMC_IM_ODD_EVEN      (1 << 3)
>
> [...]
>>
>> @@ -331,6 +336,9 @@ static int rcar_vin_setup(struct rcar_vin_priv *priv)
>>         if (output_is_yuv)
>>                 vnmc |= VNMC_BPS;
>>
>> +       if (vnmc & VNMC_INF_RGB888)
>> +               vnmc ^= VNMC_BPS;
>> +
>
>
>    Hm, this also changes the behavior for VNMC_INF_YUV16 and
> VNMC_INF_YUV10_BT{601|656}. Is this actually intended?

Probably this code is incorrect.
Thank you for your review.

Thanks,
Kaneko

>
> [...]
>
> WBR, Sergei
>
