From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 30 Oct 2014 11:05:43 +0000
Subject: Re: [PATCH v3 0/9] Renesas R-Car DU HDMI support
Message-Id: <11054192.lJRMYJX3F4@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1414337068-28664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <CAPM=9tzCRxwLqJTk3kWM47jVUUqyMNKBnm1h2RG3N0zGiMxivg@mail.gmail.com>
In-Reply-To: <CAPM=9tzCRxwLqJTk3kWM47jVUUqyMNKBnm1h2RG3N0zGiMxivg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, dri-devel <dri-devel@lists.freedesktop.org>, linux-sh@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Simon <horms@verge.net.au>

On Tuesday 28 October 2014 15:30:05 Dave Airlie wrote:
> > The last patch instantiates the HDMI encoder in the Koelsch board DT file
> > and connects it to the DU output.
> > 
> > The patch series depends on Koelsch DU DT enablement (scheduled for merge
> > in v3.19-rc1). Dave, I'd like to get this merged in v3.19-rc1, how would
> > you like to proceed ? Could it go through Simon's Renesas tree ? There's
> > a small risk of conflict in drivers/gpu/drm/drm_edid.c,
> > include/drm/drm_edid.h, drivers/gpu/drm/i2c/Kconfig and
> > drivers/gpu/drm/i2c/Makefile. Simon, could you alternatively provide a
> > stable branch with the required dependencies ?
>
> I'd probably like to take the drm patches into drm-next first, then
> maybe get a stable branch from Simon I could use to base the rest on.

Simon, I believe that would be the dt-du-for-v3.19 branch of
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git 

Is it correct ?

> > Changes since v2:
> > 
> > - Name arguments to get_edid_block()
> > 
> > Changes since v1:
> > 
> > - Dropped Philipp Zabel's OF graph patches (the rcar-du-drm driver will be
> >   udpated to use for_each_endpoint_of_node when the implementation hits
> >   upstream)
> > - adv7511: Clarify the adi,input-format DT property documentation
> > - adv7511: Use map array to convert input style to hardware value
> > - adv7511: Fixed typos
> > 
> > For ease of testing and review I've pushed this series and its
> > dependencies to a git branch on
> > 
> >         git://linuxtv.org/pinchartl/fbdev.git drm/du/adv7511
> > 
> > Cc: devicetree@vger.kernel.org
> > Cc: Dave Airlie <airlied@gmail.com>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Simon <horms@verge.net.au>
> > 
> > Lars-Peter Clausen (2):
> >   drm: Decouple EDID parsing from I2C adapter
> >   drm: Add adv7511 encoder driver
> > 
> > Laurent Pinchart (7):
> >   drm: rcar-du: Remove platform data support
> >   drm: rcar-du: Pass the encoder DT node to rcar_du_encoder_init()
> >   drm: rcar-du: Replace direct DRM encoder access with cast macro
> >   drm: rcar-du: Replace drm_encoder with drm_slave_encoder
> >   drm: rcar-du: Add HDMI encoder and connector support
> >   video: Add ADV751[13] DT bindings documentation
> >   ARM: shmobile: koelsch: Add DU HDMI output support
> >  
> >  .../devicetree/bindings/video/adi,adv7511.txt      |   88 ++
> >  arch/arm/boot/dts/r8a7791-koelsch.dts              |   50 +-
> >  drivers/gpu/drm/drm_edid.c                         |   27 +-
> >  drivers/gpu/drm/i2c/Kconfig                        |    6 +
> >  drivers/gpu/drm/i2c/Makefile                       |    2 +
> >  drivers/gpu/drm/i2c/adv7511.c                      | 1010 +++++++++++++++
> >  drivers/gpu/drm/i2c/adv7511.h                      |  289 ++++++
> >  drivers/gpu/drm/rcar-du/Kconfig                    |   11 +-
> >  drivers/gpu/drm/rcar-du/Makefile                   |    2 +
> >  drivers/gpu/drm/rcar-du/rcar_du_crtc.h             |   10 +-
> >  drivers/gpu/drm/rcar-du/rcar_du_drv.c              |    4 +-
> >  drivers/gpu/drm/rcar-du/rcar_du_drv.h              |    2 -
> >  drivers/gpu/drm/rcar-du/rcar_du_encoder.c          |   45 +-
> >  drivers/gpu/drm/rcar-du/rcar_du_encoder.h          |   23 +-
> >  drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c          |  118 +++
> >  drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h          |   31 +
> >  drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c          |  151 +++
> >  drivers/gpu/drm/rcar-du/rcar_du_hdmienc.h          |   35 +
> >  drivers/gpu/drm/rcar-du/rcar_du_kms.c              |   53 +-
> >  drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c          |   31 +-
> >  drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h          |    2 -
> >  drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h          |    1 -
> >  drivers/gpu/drm/rcar-du/rcar_du_vgacon.c           |    5 +-
> >  include/drm/drm_edid.h                             |    5 +
> >  include/linux/platform_data/rcar-du.h              |   74 --
> >  25 files changed, 1894 insertions(+), 181 deletions(-)
> >  create mode 100644
> >  Documentation/devicetree/bindings/video/adi,adv7511.txt
> >  create mode 100644 drivers/gpu/drm/i2c/adv7511.c
> >  create mode 100644 drivers/gpu/drm/i2c/adv7511.h
> >  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
> >  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h
> >  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
> >  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.h
> >  delete mode 100644 include/linux/platform_data/rcar-du.h

-- 
Regards,

Laurent Pinchart

