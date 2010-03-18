From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 18 Mar 2010 11:25:06 +0000
Subject: Re: [PATCH 1/3 v2] V4L: SuperH Video Output Unit (VOU) driver
Message-Id: <aec7e5c31003180425l5066edffl4eda8804278b42d8@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1003171103030.4354@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1003171103030.4354@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, Magnus Damm <damm@opensource.se>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hey Guennadi,

On Thu, Mar 18, 2010 at 7:28 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> A number of SuperH SoCs, including sh7724, include a Video Output Unit. This
> patch adds a video (V4L2) output driver for it. The driver uses v4l2-subdev and
> mediabus APIs to interface to TV encoders.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---

Thanks for your work on this. The VOU block is actually used by the
SH-Mobile series of SoCs. So you may want to throw in a "mobile" there
in you description to avoid future name space collisions.

I'll make sure that people test your V2 patch.

Is both NTSC and PAL known to be ok with v2?

Thanks,

/ magnus
