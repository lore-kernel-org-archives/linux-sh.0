From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Mon, 08 Apr 2013 15:38:38 +0000
Subject: Re: [PATCH v7 2/7] media: V4L2: support asynchronous subdevice registration
Message-Id: <5162E47E.8010306@samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1365419231-14830-1-git-send-email-g.liakhovetski@gmx.de>
 <1365419231-14830-3-git-send-email-g.liakhovetski@gmx.de>
 <5162C934.90808@samsung.com> <Pine.LNX.4.64.1304081548360.29945@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1304081548360.29945@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-media@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>, Prabhakar Lad <prabhakar.lad@ti.com>

On 04/08/2013 03:55 PM, Guennadi Liakhovetski wrote:
> On Mon, 8 Apr 2013, Sylwester Nawrocki wrote:
>> On 04/08/2013 01:07 PM, Guennadi Liakhovetski wrote:
[...]
>>> +static struct v4l2_async_subdev *v4l2_async_belongs(struct v4l2_async_notifier *notifier,
>>> +						    struct v4l2_async_subdev_list *asdl)
>>> +{
>>> +	struct v4l2_async_subdev *asd = NULL;
>>> +	bool (*match)(struct device *,
>>> +		      struct v4l2_async_hw_device *);
>>> +
>>> +	list_for_each_entry (asd, &notifier->waiting, list) {
>>> +		struct v4l2_async_hw_device *hw = &asd->hw;
>>> +		switch (hw->bus_type) {
>>> +		case V4L2_ASYNC_BUS_SPECIAL:
>>> +			match = hw->match.special.match;
>>> +			if (!match)
>>> +				/* Match always */
>>> +				return asd;
>>> +			break;
>>> +		case V4L2_ASYNC_BUS_PLATFORM:
>>> +			match = match_platform;
>>> +			break;
>>> +		case V4L2_ASYNC_BUS_I2C:
>>> +			match = match_i2c;
>>> +			break;
>>> +		default:
>>> +			/* Oops */
>>> +			match = NULL;
>>> +			dev_err(notifier->v4l2_dev ? notifier->v4l2_dev->dev : NULL,
>>> +				"Invalid bus-type %u on %p\n", hw->bus_type, asd);
>>> +		}
>>> +
>>> +		if (match && match(asdl->dev, hw))
>>> +			break;
>>
>> Since we maintain various lists of sub-devices, couldn't we match them e.g. by
>> name instead ? What would be preventing this ?
> 
> Do you have a specific case where your proposal would work, whereas mine 
> wouldn't? This can be changed at any time, we can leave it until there's a 
> real use-case, for which this implementation wouldn't work.

No, don't have any specific case in mind. Just was wondering if we don't
happen to be over-engineering things a bit. And yes, this seems something
that could be changed later if required.

>> And additionally provide an API to override the matching method?
> 
> Override - that's what the "SPECIAL" (CUSTOM) is for.

Yes, I wanted to emphasize the idea to have a possibility for custom subdev
matching was good.


Regards,
Sylwester
