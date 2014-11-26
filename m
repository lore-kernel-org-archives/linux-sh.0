From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 26 Nov 2014 19:06:02 +0000
Subject: Re: [PATCH v4 6/9] drm: Decouple EDID parsing from I2C adapter
Message-Id: <2001051.DfcmgkZjNf@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1414337068-28664-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1416959247-23132-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CAF6AEGtayqotLxYg9g23nG=T_vgT2-a7YAopU=RYYDP0tXhp+Q@mail.gmail.com>
In-Reply-To: <CAF6AEGtayqotLxYg9g23nG=T_vgT2-a7YAopU=RYYDP0tXhp+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org

Hi Rob,

On Tuesday 25 November 2014 19:38:47 Rob Clark wrote:
> On Tue, Nov 25, 2014 at 6:47 PM, Laurent Pinchart wrote:
> > From: Lars-Peter Clausen <lars@metafoo.de>
> > 
> > The drm_get_edid() function performs direct I2C accesses to read EDID
> > blocks, assuming that the monitor DDC interface is directly connected to
> > the I2C bus. It can't thus be used with HDMI encoders that control the
> > DDC bus and expose EDID blocks through a different interface.
> > 
> > Refactor drm_do_get_edid() to take a block read callback function
> > instead of an I2C adapter, and export it for direct use by drivers.
> > 
> > As in the general case the DDC bus is accessible by the kernel at the
> > I2C level, drivers must make all reasonable efforts to expose it as an
> > I2C adapter and use drm_get_edid() instead of abusing this function.
> > 
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> I suppose if tda998x were converted over to use it, it would be a nice
> negative diffstat ;-)

 tda998x_drv.c |   86 ++++++++++++-------------------------------------------
 1 file changed, 18 insertions(+), 68 deletions(-)

:-)

> Reviewed-by: Rob Clark <robdclark@gmail.com>
> 
> > ---
> > 
> >  drivers/gpu/drm/drm_edid.c | 43 ++++++++++++++++++++++++++++-------------
> >  include/drm/drm_edid.h     |  5 +++++
> >  2 files changed, 35 insertions(+), 13 deletions(-)
> > 
> > Daniel, could you please review and hopefully ack this ? If this new
> > version is acceptable I'd like to send an updated pull request for R-Car
> > DU HDMI support for v3.19, so time is running short.
> > 
> > Changes since v3:
> > 
> > - Add kerneldoc for the new exported drm_do_get_edid function

-- 
Regards,

Laurent Pinchart

