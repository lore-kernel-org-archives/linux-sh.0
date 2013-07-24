From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Date: Wed, 24 Jul 2013 19:36:01 +0000
Subject: Re: [PATCH v8] V4L2: soc_camera: Renesas R-Car VIN driver
Message-Id: <51F02CA1.7050603@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201307200314.35345.sergei.shtylyov@cogentembedded.com> <Pine.LNX.4.64.1307241731560.2179@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1307241731560.2179@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, mchehab@redhat.com, linux-media@vger.kernel.org, magnus.damm@gmail.com, linux-sh@vger.kernel.org, phil.edworthy@renesas.com, matsu@igel.co.jp

Hi Guennadi,

Thank you for the v8 review.

On 07/24/2013 08:14 PM, Guennadi Liakhovetski wrote:
> [snip]
>> +	/* output format */
>> +	switch (icd->current_fmt->host_fmt->fourcc) {
>> +	case V4L2_PIX_FMT_NV16:
>> +		iowrite32(ALIGN(cam->width * cam->height, 0x80),
>> +			  priv->base + VNUVAOF_REG);
>> +		dmr = VNDMR_DTMD_YCSEP;
>> +		output_is_yuv = true;
>> +		break;
>> +	case V4L2_PIX_FMT_YUYV:
>> +		dmr = VNDMR_BPSM;
>> +		output_is_yuv = true;
>> +		break;
>> +	case V4L2_PIX_FMT_UYVY:
>> +		dmr = 0;
>> +		output_is_yuv = true;
>> +		break;
>> +	case V4L2_PIX_FMT_RGB555X:
>> +		dmr = VNDMR_DTMD_ARGB1555;
>> +		break;
>> +	case V4L2_PIX_FMT_RGB565:
>> +		dmr = 0;
>> +		break;
>> +	case V4L2_PIX_FMT_RGB32:
>> +		if (priv->chip = RCAR_H1 || priv->chip = RCAR_E1) {
>> +			dmr = VNDMR_EXRGB;
>> +			break;
>> +		}
>> +	default:
>> +		BUG();
> as commented above, please, remove
Does WARN_ON(1) work instead of removal?

Regards,
Vladimir

