From: jacopo mondi <jacopo@jmondi.org>
Date: Mon, 15 Jan 2018 06:55:03 +0000
Subject: Re: [PATCH v5 0/9] Renesas Capture Engine Unit (CEU) V4L2 driver
Message-Id: <20180115065503.GB8343@w540>
List-Id: <linux-sh.vger.kernel.org>
References: <1515765849-10345-1-git-send-email-jacopo+renesas@jmondi.org>
 <3051373.PoZynrBGJV@avalon>
In-Reply-To: <3051373.PoZynrBGJV@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org
Cc: Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, geert-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sakari.ailus-X3B1VOXEql0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pombredanne-od1rfyK75/E@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello Hans,

On Fri, Jan 12, 2018 at 04:27:50PM +0200, Laurent Pinchart wrote:
> Hi Jacopo,
>
> On Friday, 12 January 2018 16:04:00 EET Jacopo Mondi wrote:
> > Hello,
> >    (hopefully) last round for CEU driver.
> >
> > Changelog is quite thin, I have updated CEU driver MODULE_LICENSE to match
> > SPDX identifier, added Rob's and Laurent's Reviewed-by tags to bindings, and
> > made variables of "struct ceu_data" type static in the driver.
> >
> > All of the patches are now Reviewed/Acked. Time to have this series
> > included?
>
> Yes please !
>
> Hans, could you pick this up ?

Hans, since this series contains changes for the SH architecture as
well, and SH maintainers have prove to be somehow unreachable, could
you please consider to have the whole series being merged thorough
your tree?

Thanks
   j

>
> > v4->v5:
> > - Added Rob's and Laurent's Reviewed-by tag to DT bindings
> > - Change CEU driver module license to "GPL v2" to match SPDX identifier as
> >   suggested by Philippe Ombredanne
> > - Make struct ceu_data static as suggested by Laurent and add his
> >   Reviewed-by to CEU driver.
> >
> > v3->v4:
> > - Drop generic fallback compatible string "renesas,ceu"
> > - Addressed Laurent's comments on [3/9]
> >   - Fix error messages on irq get/request
> >   - Do not leak ceudev if irq_get fails
> >   - Make irq_mask a const field
> >
> > v2->v3:
> > - Improved DT bindings removing standard properties (pinctrl- ones and
> >   remote-endpoint) not specific to this driver and improved description of
> >   compatible strings
> > - Remove ov772x's xlkc_rate property and set clock rate in Migo-R board file
> > - Made 'xclk' clock private to ov772x driver in Migo-R board file
> > - Change 'rstb' GPIO active output level and changed ov772x and tw9910
> > drivers accordingly as suggested by Fabio
> > - Minor changes in CEU driver to address Laurent's comments
> > - Moved Migo-R setup patch to the end of the series to silence 0-day bot
> > - Renamed tw9910 clock to 'xti' as per video decoder manual
> > - Changed all SPDX identifiers to GPL-2.0 from previous GPL-2.0+
> >
> > v1->v2:
> >  - DT
> >  -- Addressed Geert's comments and added clocks for CEU to mstp6 clock
> > source -- Specified supported generic video iterfaces properties in
> > dt-bindings and simplified example
> >
> >  - CEU driver
> >  -- Re-worked interrupt handler, interrupt management, reset(*) and capture
> >     start operation
> >  -- Re-worked querycap/enum_input/enum_frameintervals to fix some
> >     v4l2_compliance failures
> >  -- Removed soc_camera legacy operations g/s_mbus_format
> >  -- Update to new notifier implementation
> >  -- Fixed several comments from Hans, Laurent and Sakari
> >
> >  - Migo-R
> >  -- Register clocks and gpios for sensor drivers in Migo-R setup
> >  -- Updated sensors (tw9910 and ov772x) drivers headers and drivers to close
> > remarks from Hans and Laurent:
> >  --- Removed platform callbacks and handle clocks and gpios from sensor
> > drivers --- Remove g/s_mbus_config operations
> >
> > Jacopo Mondi (9):
> >   dt-bindings: media: Add Renesas CEU bindings
> >   include: media: Add Renesas CEU driver interface
> >   v4l: platform: Add Renesas CEU driver
> >   ARM: dts: r7s72100: Add Capture Engine Unit (CEU)
> >   v4l: i2c: Copy ov772x soc_camera sensor driver
> >   media: i2c: ov772x: Remove soc_camera dependencies
> >   v4l: i2c: Copy tw9910 soc_camera sensor driver
> >   media: i2c: tw9910: Remove soc_camera dependencies
> >   arch: sh: migor: Use new renesas-ceu camera driver
> >
> >  .../devicetree/bindings/media/renesas,ceu.txt      |   81 +
> >  arch/arm/boot/dts/r7s72100.dtsi                    |   15 +-
> >  arch/sh/boards/mach-migor/setup.c                  |  225 ++-
> >  arch/sh/kernel/cpu/sh4a/clock-sh7722.c             |    2 +-
> >  drivers/media/i2c/Kconfig                          |   20 +
> >  drivers/media/i2c/Makefile                         |    2 +
> >  drivers/media/i2c/ov772x.c                         | 1181 ++++++++++++++
> >  drivers/media/i2c/tw9910.c                         | 1039 ++++++++++++
> >  drivers/media/platform/Kconfig                     |    9 +
> >  drivers/media/platform/Makefile                    |    1 +
> >  drivers/media/platform/renesas-ceu.c               | 1648 +++++++++++++++++
> >  include/media/drv-intf/renesas-ceu.h               |   26 +
> >  include/media/i2c/ov772x.h                         |    6 +-
> >  include/media/i2c/tw9910.h                         |    9 +
> >  14 files changed, 4133 insertions(+), 131 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/media/renesas,ceu.txt
> >  create mode 100644 drivers/media/i2c/ov772x.c
> >  create mode 100644 drivers/media/i2c/tw9910.c
> >  create mode 100644 drivers/media/platform/renesas-ceu.c
> >  create mode 100644 include/media/drv-intf/renesas-ceu.h
>
> --
> Regards,
>
> Laurent Pinchart
>
