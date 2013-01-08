From: Simon Horman <horms@verge.net.au>
Date: Tue, 08 Jan 2013 04:27:20 +0000
Subject: Re: [PATCH 6/6] ARM: shmobile: convert ap4evb to asynchronously register camera subdevices
Message-Id: <20130108042720.GA25895@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1356544151-6313-1-git-send-email-g.liakhovetski@gmx.de>
 <1356544151-6313-7-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1356544151-6313-7-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-media@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>

On Wed, Dec 26, 2012 at 06:49:11PM +0100, Guennadi Liakhovetski wrote:
> Register the imx074 camera I2C and the CSI-2 platform devices directly
> in board platform data instead of letting the sh_mobile_ceu_camera driver
> and the soc-camera framework register them at their run-time. This uses
> the V4L2 asynchronous subdevice probing capability.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Hi Guennadi,

could you let me know what if any dependencies this patch has.
And the status of any dependencies.
