From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Date: Thu, 21 Mar 2013 08:31:50 +0000
Subject: Re: [PATCH v6 1/7] media: V4L2: add temporary clock helpers
Message-Id: <CA+V-a8vgthS2kh4bAH_pKNWkFTy+4xrAva5wdF58qT10Ni5nUg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1363382873-20077-1-git-send-email-g.liakhovetski@gmx.de> <1363382873-20077-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1363382873-20077-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-media@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>, Prabhakar Lad <prabhakar.lad@ti.com>

Hi Guennadi,

On Sat, Mar 16, 2013 at 2:57 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Typical video devices like camera sensors require an external clock source.
> Many such devices cannot even access their hardware registers without a
> running clock. These clock sources should be controlled by their consumers.
> This should be performed, using the generic clock framework. Unfortunately
> so far only very few systems have been ported to that framework. This patch
> adds a set of temporary helpers, mimicking the generic clock API, to V4L2.
> Platforms, adopting the clock API, should switch to using it. Eventually
> this temporary API should be removed.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> v6: changed clock name to just <I2C adapter ID>-<I2C address> to avoid
> having to wait for an I2C subdevice driver to probe. Added a subdevice
> pointer to struct v4l2_clk for subdevice and bridge binding.
>
>  drivers/media/v4l2-core/Makefile   |    2 +-
>  drivers/media/v4l2-core/v4l2-clk.c |  184 ++++++++++++++++++++++++++++++++++++
>  include/media/v4l2-clk.h           |   55 +++++++++++
>  3 files changed, 240 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/media/v4l2-core/v4l2-clk.c
>  create mode 100644 include/media/v4l2-clk.h
>
While trying out this patch I got following error (using 3.9-rc3):-

drivers/media/v4l2-core/v4l2-clk.c: In function 'v4l2_clk_register':
drivers/media/v4l2-core/v4l2-clk.c:134:2: error: implicit declaration
of function 'kzalloc'
drivers/media/v4l2-core/v4l2-clk.c:134:6: warning: assignment makes
pointer from integer without a cast
drivers/media/v4l2-core/v4l2-clk.c:162:2: error: implicit declaration
of function 'kfree'
make[3]: *** [drivers/media/v4l2-core/v4l2-clk.o] Error 1
make[2]: *** [drivers/media/v4l2-core] Error 2

Regards,
--Prabhakar
