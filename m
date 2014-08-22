From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Fri, 22 Aug 2014 17:03:48 +0000
Subject: Re: [PATCH 1/6] V4L2: Add Renesas R-Car JPEG codec driver.
Message-Id: <53F777F4.30804@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1408452653-14067-1-git-send-email-mikhail.ulyanov@cogentembedded.com>	<1408452653-14067-2-git-send-email-mikhail.ulyanov@cogentembedded.com>	<53F3531C.4080105@xs4all.nl> <20140822173900.0d3efcd1@bones>
In-Reply-To: <20140822173900.0d3efcd1@bones>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikhail Ulianov <mikhail.ulyanov@cogentembedded.com>
Cc: m.chehab@samsung.com, horms@verge.net.au, magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, laurent.pinchart@ideasonboard.com, linux-sh@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org

On 08/22/2014 01:39 PM, Mikhail Ulianov wrote:
> Hi Hans,
> 
> Thanks for your comments.
> 
> I have a question on default width, height and sizeimage values
> m2m driver should return in case when we try to run G_FMT on just
> opened device. Is there any preferable values? v4l2-compliance tool
> want it to be non zero, but at that moment we have no information 
> about output and capture, so i see few options here:
> 1) ignore v4l-complince error in such case
>>> v4l2-test-formats.cpp(417): !pix.width || !pix.height"
> 2) set some default values e.g. 640x480
> Do you have a suggestion? \

Use 2: just set a default value. V4L2 should always be in a sane state,
which in this case means that the driver should just pick some default
initial format.

Regards,

	Hans

> 
> Thanks, Mikhail.
> 
>> Hi Mikhail,
>>
>> I did a quick scan over the source code and I noticed a few things
>> that aren't right. The easiest for you is probably to run the
>> v4l2-compliance tool over your driver and it should tell you what
>> needs to be fixed. The things I noticed are: querycap doesn't fill in
>> bus_info (should be 'platform:<foo>') and device_caps, the vid_cap
>> try_fmt fails on a wrong field setting, instead it should just set it.
>>
>> I also have some doubts about g_selection, but I need to look at that
>> again when I have more time next week. It does look like it is not
>> properly separating the capture and output streams. I would expect
>> g_selection to return different things for capture and output. Note
>> that v4l2-compliance doesn't yet check the selection API, so it won't
>> help you there.
>>
>> Regards,
>>
>> 	Hans

