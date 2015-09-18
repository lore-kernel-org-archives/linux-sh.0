From: Simon Horman <horms@verge.net.au>
Date: Fri, 18 Sep 2015 00:26:37 +0000
Subject: Re: Renesas Lager: Device Tree entries for VIN HDMI input, version 2
Message-Id: <20150918002636.GE12858@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1439465811-936-1-git-send-email-william.towle@codethink.co.uk>
In-Reply-To: <1439465811-936-1-git-send-email-william.towle@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: William Towle <william.towle@codethink.co.uk>
Cc: linux-media@vger.kernel.org, linux-kernel@lists.codethink.co.uk, linux-sh@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>

Hi William,

On Thu, Aug 13, 2015 at 12:36:48PM +0100, William Towle wrote:
>   Version 2 ... removes some redundant configuration from device nodes,
> and provides some supplementary logic for automatic initialisation of
> state->pdata.default_input based on the hardware present.
> 
>   (Obsoletes corresponding parts of "HDMI and Composite capture on
> Lager...", published previously)
> 
> Cheers,
>   Wills.
> 
> To follow:
> 	[PATCH 1/3] ARM: shmobile: lager dts: Add entries for VIN HDMI input
> 	[PATCH 2/3] media: adv7604: automatic "default-input" selection
> 	[PATCH 3/3] ARM: shmobile: lager dts: specify default-input for

I am wondering about the status of patch 2 of the series,
is it queued-up anywhere?

I am also wondering about the relationship between patch 2 and 3.
Does 3 work without 2? Does 2 make 3 unnecessary?
