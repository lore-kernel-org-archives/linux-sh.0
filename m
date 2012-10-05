From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Fri, 05 Oct 2012 10:48:50 +0000
Subject: Re: [PATCH v4] media: add a VEU MEM2MEM format conversion and scaling driver
Message-Id: <201210051248.50932.hverkuil@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1210051241540.13761@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1210051241540.13761@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

On Fri October 5 2012 12:43:41 Guennadi Liakhovetski wrote:
> Video Engine Unit (VEU) is an IP block, found in multiple SuperH and ARM-
> based sh-mobile and r-mobile SoCs, capable of processing video data. It
> can perform colour-space conversion, scaling and several filtering
> transformations. This patch adds an initial implementation of a mem2mem
> V4L2 driver for VEU. So far only conversion from NV12 to RGB565 is
> supported. Further functionality shall be added in the future.
> 
> This driver is based on a VEU vidix driver by Magnus Damm.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Thanks!

	Hans
