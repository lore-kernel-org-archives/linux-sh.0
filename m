From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Date: Wed, 12 Jun 2013 17:28:29 +0000
Subject: Re: [PATCH v10 15/21] V4L2: add a device pointer to struct v4l2_subdev
Message-Id: <CA+V-a8tmf3Cm04gNa=+2sKrW6kiqVoRgBmGKJMqJgp6wAtepRQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1370939028-8352-1-git-send-email-g.liakhovetski@gmx.de> <1370939028-8352-16-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1370939028-8352-16-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-media@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Hans Verkuil <hverkuil@xs4all.nl>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>, Prabhakar Lad <prabhakar.lad@ti.com>, Sascha Hauer <s.hauer@pengutronix.de>

On Tue, Jun 11, 2013 at 1:53 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> It is often useful to have simple means to get from a subdevice to the
> underlying physical device. This patch adds such a pointer to struct
> v4l2_subdev and sets it accordingly in the I2C and SPI cases.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Regards,
--Prabhakar Lad
