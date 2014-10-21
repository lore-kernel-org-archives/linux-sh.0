From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Tue, 21 Oct 2014 03:30:29 +0000
Subject: Re: [PATCH] media: soc_camera: rcar_vin: Enable VSYNC field toggle mode
Message-Id: <CAH1o70JoiJhec6thnQZnQ_99DLjhMrYhypFubkDYNnTcP_02ZQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1413267956-8342-1-git-send-email-ykaneko0929@gmail.com>
	<544280E4.20101@cogentembedded.com>
In-Reply-To: <544280E4.20101@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hello Sergei,

Thank you for your comments.

2014-10-19 0:01 GMT+09:00 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>:
> Hello.
>
> On 10/14/2014 10:25 AM, Yoshihiro Kaneko wrote:
>
>> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>
>
>> By applying this patch, it sets to VSYNC field toggle mode not only
>> at the time of progressive mode but at the time of an interlace mode.
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
>>   drivers/media/platform/soc_camera/rcar_vin.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>
>
>> diff --git a/drivers/media/platform/soc_camera/rcar_vin.c
>> b/drivers/media/platform/soc_camera/rcar_vin.c
>> index 5196c81..bf97ed6 100644
>> --- a/drivers/media/platform/soc_camera/rcar_vin.c
>> +++ b/drivers/media/platform/soc_camera/rcar_vin.c
>> @@ -108,6 +108,7 @@
>>   #define VNDMR2_VPS            (1 << 30)
>>   #define VNDMR2_HPS            (1 << 29)
>>   #define VNDMR2_FTEV           (1 << 17)
>> +#define VNDMR2_VLV_1           (1 << 12)
>
>
>    Please instead do:
>
> #define VNDMR2_VLV(n)   ((n & 0xf) << 12)

It's unclear to me why the style of the new #define should differ
from those of the existing ones.

Thanks,
Kaneko

>
> WBR, Sergei
>
