From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Fri, 19 Jan 2018 10:47:33 +0000
Subject: Re: [PATCH v6 6/9] media: i2c: ov772x: Remove soc_camera dependencies
Message-Id: <00f1dd19-6420-26ab-0529-a97f2b0de682@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1516139101-7835-1-git-send-email-jacopo+renesas@jmondi.org>
 <1516139101-7835-7-git-send-email-jacopo+renesas@jmondi.org>
 <d67c21e5-2488-977b-39d8-561048409209@xs4all.nl>
In-Reply-To: <d67c21e5-2488-977b-39d8-561048409209-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, geert-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sakari.ailus-X3B1VOXEql0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pombredanne-od1rfyK75/E@public.gmane.org
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/19/18 11:24, Hans Verkuil wrote:
> On 01/16/18 22:44, Jacopo Mondi wrote:
>> Remove soc_camera framework dependencies from ov772x sensor driver.
>> - Handle clock and gpios
>> - Register async subdevice
>> - Remove soc_camera specific g/s_mbus_config operations
>> - Change image format colorspace from JPEG to SRGB as the two use the
>>   same colorspace information but JPEG makes assumptions on color
>>   components quantization that do not apply to the sensor
>> - Remove sizes crop from get_selection as driver can't scale
>> - Add kernel doc to driver interface header file
>> - Adjust build system
>>
>> This commit does not remove the original soc_camera based driver as long
>> as other platforms depends on soc_camera-based CEU driver.
>>
>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Un-acked.

I just noticed that this sensor driver has no enum_frame_interval and
g/s_parm support. How would a driver ever know the frame rate of the
sensor without that?

This looks like a bug to me.

Regards,

	Hans
