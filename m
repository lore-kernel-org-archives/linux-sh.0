From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 24 Aug 2015 21:58:07 +0000
Subject: Re: [PATCH] rcar_vin: propagate querystd() error upstream
Message-Id: <55DB936F.2060008@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1650569.JYNQd5Bi8T@wasted.cogentembedded.com>
 <2204711.y8psPZeT2j@avalon>
In-Reply-To: <2204711.y8psPZeT2j@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: g.liakhovetski@gmx.de, mchehab@osg.samsung.com, linux-media@vger.kernel.org, linux-sh@vger.kernel.org

hello.

On 08/21/2015 12:51 AM, Laurent Pinchart wrote:

>> rcar_vin_set_fmt() defaults to  PAL when the subdevice's querystd() method
>> call fails (e.g. due to I2C error).  This doesn't work very well when a
>> camera being used  outputs NTSC which has different order of fields and
>> resolution.  Let  us stop  pretending and return the actual error (which
>> would prevent video capture on at least Renesas Henninger/Porter board
>> where I2C seems particularly buggy).
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> The patch is against the 'media_tree.git' repo's 'fixes' branch.
>>
>>   drivers/media/platform/soc_camera/rcar_vin.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Index: media_tree/drivers/media/platform/soc_camera/rcar_vin.c
>> =================================>> --- media_tree.orig/drivers/media/platform/soc_camera/rcar_vin.c
>> +++ media_tree/drivers/media/platform/soc_camera/rcar_vin.c
>> @@ -1592,7 +1592,7 @@ static int rcar_vin_set_fmt(struct soc_c
>>   		/* Query for standard if not explicitly mentioned _TB/_BT */
>>   		ret = v4l2_subdev_call(sd, video, querystd, &std);
>>   		if (ret < 0)
>> -			std = V4L2_STD_625_50;
>> +			return ret;
>
> What if the subdev doesn't implement querystd ? That's the case of camera
> sensors for instance.

    Indeed.

> In that case we should default to V4L2_FIELD_NONE.

    Hmm, even if the set_fmt() method is called with V4L2_FIELD_INTERLACED 
already, like in this case?

>>   		field = std & V4L2_STD_625_50 ? V4L2_FIELD_INTERLACED_TB :
>>   						V4L2_FIELD_INTERLACED_BT;

MBR, Sergei

