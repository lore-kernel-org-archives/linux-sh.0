From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Date: Sun, 16 Jun 2013 15:30:47 +0000
Subject: Re: [PATCH v11 15/21] V4L2: add a device pointer to struct v4l2_subdev
Message-Id: <CA+V-a8uPDDNE4y0NoFrhatQqLD+4S1ARdH4vAru4C3xmt3jmZQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1371236911-15131-1-git-send-email-g.liakhovetski@gmx.de> <1371236911-15131-16-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1371236911-15131-16-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-media@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Hans Verkuil <hverkuil@xs4all.nl>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>, Prabhakar Lad <prabhakar.lad@ti.com>, Sascha Hauer <s.hauer@pengutronix.de>

Hi Guennadi,

Thanks for the patch.

On Sat, Jun 15, 2013 at 12:38 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> It is often useful to have simple means to get from a subdevice to the
> underlying physical device. This patch adds such a pointer to struct
> v4l2_subdev and sets it accordingly in the I2C and SPI cases.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Regards,
--Prabhakar Lad
