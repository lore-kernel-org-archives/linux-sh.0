From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 21 May 2013 17:17:09 +0000
Subject: Re: [PATCH v3] adv7180: add more subdev video ops
Message-Id: <519BAC15.8000503@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201305132321.39495.sergei.shtylyov@cogentembedded.com> <201305211135.59706.hverkuil@xs4all.nl> <519B8478.9010305@cogentembedded.com> <201305211645.49257.hverkuil@xs4all.nl>
In-Reply-To: <201305211645.49257.hverkuil@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: mchehab@redhat.com, linux-media@vger.kernel.org, vladimir.barinov@cogentembedded.com, linux-sh@vger.kernel.org, matsu@igel.co.jp

Hello.

On 05/21/2013 06:45 PM, Hans Verkuil wrote:

>>>> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>>> Add subdev video ops for ADV7180 video decoder.  This makes decoder usable on
>>>> the soc-camera drivers.
>>>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>> ---
>>>> This patch is against the 'media_tree.git' repo.
>>>> Changes from version 2:
>>>> - set the field format depending on video standard in try_mbus_fmt() method;
>>>> - removed querystd() method calls from try_mbus_fmt() and cropcap() methods;
>>>> - removed g_crop() method.
>>>>    drivers/media/i2c/adv7180.c |   86 ++++++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 86 insertions(+)
>>>>
>>>> Index: media_tree/drivers/media/i2c/adv7180.c
>>>> =================================>>>> --- media_tree.orig/drivers/media/i2c/adv7180.c
>>>> +++ media_tree/drivers/media/i2c/adv7180.c
>>
>>>> +
>>>> +static int adv7180_try_mbus_fmt(struct v4l2_subdev *sd,
>>>> +				struct v4l2_mbus_framefmt *fmt)
>>>> +{
>>>> +	struct adv7180_state *state = to_state(sd);
>>>> +
>>>> +	fmt->code = V4L2_MBUS_FMT_YUYV8_2X8;
>>>> +	fmt->colorspace = V4L2_COLORSPACE_SMPTE170M;
>>>> +	fmt->field = state->curr_norm & V4L2_STD_525_60 ?
>>>> +		     V4L2_FIELD_INTERLACED_BT : V4L2_FIELD_INTERLACED_TB;
>>> Just noticed this: use V4L2_FIELD_INTERLACED as that does the right thing.
>>> No need to split in _BT and _TB.
>>      Hm, testers have reported that _BT vs _TB do make a difference. I'll
>> try to look into how V4L2 handles interlacing for different standards.
> When using V4L2_FIELD_INTERLACED the BT vs TB is implicit (i.e. the application
> is supposed to know that the order will be different depending on the standard).
> Explicitly using BT/TB is only useful if you want to override the default, e.g.
> if a video was encoded using the wrong temporal order.

     We have used V4L2_FIELD_INTERLACED before and people reported
incorrect field ordering -- that's why we changed to what it is now. So this
might be an application failure?

WBR, Sergei

