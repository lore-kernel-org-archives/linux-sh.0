From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Mon, 18 May 2015 08:17:52 +0000
Subject: Re: [PATCH/RFC] v4l: vsp1: Align crop rectangle to even boundary for YUV formats
Message-Id: <5559A030.4030301@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1430327133-8461-1-git-send-email-ykaneko0929@gmail.com> <5542105A.1010601@cogentembedded.com> <2003077.85RPlhiJ1o@avalon>
In-Reply-To: <2003077.85RPlhiJ1o@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-media@vger.kernel.org, Mauro Carvalho Chehab <m.chehab@samsung.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hello Laurent,

On 2015-05-04 7:13 AM, Laurent Pinchart wrote:
> Hello,
> 
> On Thursday 30 April 2015 14:22:02 Sergei Shtylyov wrote:
>> On 4/29/2015 8:05 PM, Yoshihiro Kaneko wrote:
>>> From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
>>>
>>> Make sure that there are valid values in the crop rectangle to ensure
>>> that the color plane doesn't get shifted when cropping.
>>> Since there is no distintion between 12bit and 16bit YUV formats in
>>
>> Вistinсtion.
>>
>>> at the subdev level, use the more restrictive 12bit limits for all YUV
>>> formats.
> 
> I would like to mention in the commit message that only the top coordinate 
> constraints differ between the YUV formats, as the subsampling coefficient is 
> always two in the horizontal direction.

I believe that the height value has the same constraint as the top.

> 
> Do you foresee a use case for odd cropping top coordinates ?

There might be a case when you're blending surfaces together and one
extends beyond the boundary of the other and you want to clip away the
non-overlapping portions.


>>>   	if (rwpf->entity.type = VSP1_ENTITY_WPF) {
>>> -		sel->r.left = min_t(unsigned int, sel->r.left, 255);
>>> -		sel->r.top = min_t(unsigned int, sel->r.top, 255);
>>> +		int maxcrop > 
> I would declare maxcrop as an unsigned int.
> 
>>> +			format->code = MEDIA_BUS_FMT_AYUV8_1X32 ? 254 : 255;
>>
>> I think you need an empty line here.
>>
>>> +		sel->r.left = min_t(unsigned int, sel->r.left, maxcrop);
>>> +		sel->r.top = min_t(unsigned int, sel->r.top, maxcrop);
> 
> Is this needed ? Based on what I understand from the datasheet the WPF crops 
> the image before passing it to the DMA engine. At that point YUV data isn't 
> subsampled, so it looks like we don't need to restrict the left and top to 
> even values.
> 

I think that you're correct. There is no subsampling at this stage in
the pipeline so the maxcrop setting should be fine at 255 regardless of
the format.

Thank you,
Damian
