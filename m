From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Date: Wed, 12 Jun 2013 17:30:38 +0000
Subject: Re: [PATCH v10 16/21] V4L2: support asynchronous subdevice registration
Message-Id: <CA+V-a8uvcgYj+kq79a9XpvyNuh31vYUgjPNWvj9oLKiCUGnHiw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1370939028-8352-1-git-send-email-g.liakhovetski@gmx.de> <1370939028-8352-17-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1370939028-8352-17-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-media@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Hans Verkuil <hverkuil@xs4all.nl>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>, Prabhakar Lad <prabhakar.lad@ti.com>, Sascha Hauer <s.hauer@pengutronix.de>

Hi Guennadi,

Thanks for the patch. Hopefully we get this in for 3.11

On Tue, Jun 11, 2013 at 1:53 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Currently bridge device drivers register devices for all subdevices
> synchronously, tupically, during their probing. E.g. if an I2C CMOS sensor
> is attached to a video bridge device, the bridge driver will create an I2C
> device and wait for the respective I2C driver to probe. This makes linking
> of devices straight forward, but this approach cannot be used with
> intrinsically asynchronous and unordered device registration systems like
> the Flattened Device Tree. To support such systems this patch adds an
> asynchronous subdevice registration framework to V4L2. To use it respective
> (e.g. I2C) subdevice drivers must register themselves with the framework.
> A bridge driver on the other hand must register notification callbacks,
> that will be called upon various related events.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
Tested-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Regards,
--Prabhakar Lad
