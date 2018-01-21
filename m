From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Sun, 21 Jan 2018 10:23:12 +0000
Subject: Re: [PATCH v6 3/9] v4l: platform: Add Renesas CEU driver
Message-Id: <e9623e9c-6444-2531-62c0-feed622c6e3b@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1516139101-7835-1-git-send-email-jacopo+renesas@jmondi.org>
 <1516139101-7835-4-git-send-email-jacopo+renesas@jmondi.org>
 <d056343b-46be-436a-e316-0a588a182eb9@xs4all.nl>
 <20180121095323.GL24926@w540>
 <55c3ab66-0886-4b2b-6842-ac07fc9138f3@xs4all.nl>
In-Reply-To: <55c3ab66-0886-4b2b-6842-ac07fc9138f3@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jacopo mondi <jacopo@jmondi.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, laurent.pinchart@ideasonboard.com, magnus.damm@gmail.com, geert@glider.be, mchehab@kernel.org, festevam@gmail.com, sakari.ailus@iki.fi, robh+dt@kernel.org, mark.rutland@arm.com, pombredanne@nexb.com, linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On 21/01/18 11:21, Hans Verkuil wrote:
> On 21/01/18 10:53, jacopo mondi wrote:
>> Hi Hans,
>>
>> On Fri, Jan 19, 2018 at 12:20:19PM +0100, Hans Verkuil wrote:
>>> static int ov7670_g_parm(struct v4l2_subdev *sd, struct v4l2_streamparm *parms)
>>> {
>>>         struct v4l2_captureparm *cp = &parms->parm.capture;
>>>         struct ov7670_info *info = to_state(sd);
>>>
>>>         if (parms->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
>>>                 return -EINVAL;
>>>
>>> And parms->type is CAPTURE_MPLANE. Just drop this test from the ov7670 driver
>>> in the g/s_parm functions. It shouldn't test for that since a subdev driver
>>> knows nothing about buffer types.
>>>
>>
>> I will drop that test in an additional patch part of next iteration of this series,
> 
> Replace g/s_parm by g/s_frame_interval. Consider g/s_parm for subdev drivers as
> deprecated (I'm working on a patch series to replace all g/s_parm uses by
> g/s_frame_interval).

Take a look here:

https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=parm

You probably want to use the patch 'v4l2-common: add g/s_parm helper functions'
for the new ceu driver in your patch series. Feel free to add it.

Regards,

	Hans
