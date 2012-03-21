From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 21 Mar 2012 10:59:59 +0000
Subject: Re: [PATCH 1/2] V4L: sh_mobile_ceu_camera: maximum image size depends on the hardware version
Message-Id: <Pine.LNX.4.64.1203211157340.31443@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1203141600210.25284@axis700.grange>
 <2696549.KbXzs1B8nR@avalon>
In-Reply-To: <2696549.KbXzs1B8nR@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, linux-sh@vger.kernel.org

Hi Laurent

On Wed, 21 Mar 2012, Laurent Pinchart wrote:

> Hi Guennadi,
> 
> On Wednesday 14 March 2012 16:02:20 Guennadi Liakhovetski wrote:
> > Newer CEU versions, e.g., the one, used on sh7372, support image sizes
> > larger than 2560x1920. Retrieve maximum sizes from platform properties.
> 
> Isn't there a way you could query the CEU version at runtime instead ?

I'm not aware of any. And even if it were possible, I'm not sure putting 
tables with "version - feature-set" tables into the driver proper would be 
a very good idea. It used to be like that (or almost like that with 
dependencies on the chip-type) in other drivers (e.g., shdma) and we 
dropped it in favour of platform data.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
