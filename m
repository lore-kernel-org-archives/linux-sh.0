From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Tue, 08 Jan 2013 14:27:09 +0000
Subject: Re: [PATCH 1/6 v4] media: V4L2: support asynchronous subdevice registration
Message-Id: <50EC2CBD.3080102@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1356544151-6313-1-git-send-email-g.liakhovetski@gmx.de> <18858693.KSUhrxG65A@avalon> <50EC0500.4030708@gmail.com> <1446871.ydXdxJD4sK@avalon>
In-Reply-To: <1446871.ydXdxJD4sK@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>, Prabhakar Lad <prabhakar.lad@ti.com>

Hi Laurent,

On 01/08/2013 01:41 PM, Laurent Pinchart wrote:
>> Subdev names are exposed to user space by the media controller API.
>> So they are really part of an ABI, aren't they ?
>
> They're used to construct the name exposed to userspace, but the media
> controller core could probably handle that internally by concatenating the
> driver name and the subdev name.
>
>> Also having I2C bus number or I2C slave address as part of the subdev
>> name makes it more difficult to write portable applications. Hence
>> in sensor drivers I used to overwrite subdev name to remove I2C bus
>> and slave address, as the format used v4l2_i2c_subdev_init() seemed
>> highly unsuitable..
>
> This clearly shows that we need to discuss the matter and agree on a common
> mode of operation.
>
> Aren't applications that use the subdev name directly inherently non-portable
> anyway ? If you want your application to support different boards/sensors/SoCs
> you should discover the pipeline and find the sensor by iterating over
> entities, instead of using the sensor entity name.

It depends on how we define the entity names :) It the names change from 
board
to board and are completely unreliable then user space applications 
using them
have no any chance to be generic. Nevertheless, struct 
media_entity_desc::name
[1] has currently no specific semantics defined, e.g. for V4L2.

It's likely way better for the kernel space to be no constrained by the 
subdev
user space name requirement. But having no clear definition of the 
entity names
brings more trouble to user space. E.g. when a sensor exposes multiple 
subdevs.
User space library/application could then reference them by entity name. It
seems difficult to me to handle such multiple subdev devices without 
somehow
reliable subdev names.

I imagine a system with multiple sensors of same type sitting on 
different I2C
busses, then appending I2C bus number/slave address to the name would be 
useful.

And is it always possible to discover the pipeline, as opposite to e.g. 
using
configuration file to activate all required links ? Configurations could be
of course per board file, but then at least we should keep subdev names
constant through the kernel releases.


[1] http://linuxtv.org/downloads/v4l-dvb-apis/media-ioc-enum-entities.html

--

Regards,
Sylwester
