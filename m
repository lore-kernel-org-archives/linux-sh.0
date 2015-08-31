From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 31 Aug 2015 22:13:13 +0000
Subject: Re: [PATCH] rcar_vin: propagate querystd() error upstream
Message-Id: <55E4D179.4080009@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1650569.JYNQd5Bi8T@wasted.cogentembedded.com>
 <55DC7AE2.6010103@xs4all.nl>
In-Reply-To: <55DC7AE2.6010103@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hverkuil@xs4all.nl>, g.liakhovetski@gmx.de, mchehab@osg.samsung.com, linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hello.

On 08/25/2015 05:25 PM, Hans Verkuil wrote:

>> rcar_vin_set_fmt() defaults to  PAL when the subdevice's querystd() method call
>> fails (e.g. due to I2C error).  This doesn't work very well when a camera being
>> used  outputs NTSC which has different order of fields and resolution.  Let  us
>> stop  pretending and return the actual error (which would prevent video capture
>> on at least Renesas Henninger/Porter board where I2C seems particularly buggy).
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

> Ouch, this should never be done like this.

    Too late. :-)

> Instead the decision should be made using the last set std, never by querying.
> So querystd should be replaced by g_std in the v4l2_subdev_call above.

    Hm, then this code will stop working, as adv7180.c and ml86v7667.c we use 
don't support the g_std() method yet...

> The only place querystd can be called is in the QUERYSTD ioctl, all other
> ioctls should use the last set standard.

    OK, I'll have to fix all the drivers involved...

> Regards,
> 	Hans

MBR, Sergei

