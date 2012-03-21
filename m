From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 21 Mar 2012 10:52:09 +0000
Subject: Re: [PATCH 1/2] V4L: sh_mobile_ceu_camera: maximum image size depends on the hardware version
Message-Id: <2696549.KbXzs1B8nR@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1203141600210.25284@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1203141600210.25284@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, linux-sh@vger.kernel.org

Hi Guennadi,

On Wednesday 14 March 2012 16:02:20 Guennadi Liakhovetski wrote:
> Newer CEU versions, e.g., the one, used on sh7372, support image sizes
> larger than 2560x1920. Retrieve maximum sizes from platform properties.

Isn't there a way you could query the CEU version at runtime instead ?

-- 
Regards,

Laurent Pinchart

