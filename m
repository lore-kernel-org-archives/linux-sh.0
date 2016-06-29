From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 29 Jun 2016 23:58:32 +0000
Subject: Re: Rcar Gen2: DU: Bootlogs Error and show image error
Message-Id: <1528572.t4akQ1HVCM@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <564ECE30.9000206@jinso.co.jp>
In-Reply-To: <564ECE30.9000206@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hello Hiep-san,

On Tuesday 28 Jun 2016 10:19:20 Hiep Cao Minh wrote:
> Hi Laurent-san
> 
> Sorry to bother you again!
> I would like to confirm the fixed patch for this issue on Lager.
> I have retested it on Lager(Rcar-H2), The issue still happens at the
> Linux upstream version v4.7-rc2
> Have you released the fixed patch?
> Please tell me the version and test method if you have already released it.
> I resent the damage image when displaying it on the HDMI screen.

I'm currently traveling and have only taken my H3 board with me, so I don't 
have access to Lager. I'll be back home on the 5th of July and then test this. 
Sorry for the delay.

> On 12/17/2015 03:37 PM, Cao Minh Hiep wrote:
> > Hello Laurent-san
> > 
> > On 2015年12月14日 04:45, Laurent Pinchart wrote:
> >> Hello Cao Minh-san,
> >> 
> >> (this is a bit of a stupid question, and I apologize for that, but
> >> what is the
> >> proper way to address you, Cao-san, Cao Minh-san, Hiep-san, or
> >> something else
> >> ?)
> > 
> > No problems! :) , Hiep is my name! Every one calls me Hiep,
> > 
> >> On Thursday 10 December 2015 10:43:18 Cao Minh Hiep wrote:
> >>>>>> Yes, CONFIG_DRM_I2C_ADV7511=y has already enabled in default
> >>>>>> config at
> >>>>>> v4.4-rc2.
> >>>>>> I also have enabled CONFIG_DRM_SHMOBILE and CONFIG_FB_SH_MOBILE_HDMI
> >>>>>> then test.
> >>>>>> But It has nothing change.
> >>>>>> Is there other configuration or reason could we think?
> >>>>> 
> >>>>> Does this problem happen on your board?
> >>>>> If not, Could you please send me your config file?.
> >>>> 
> >>>> Sorry for the delay, I wanted to retry on my Koelsch board before
> >>>> replying.
> >>>> 
> >>>> The probe deferral error (-517) you're seeing is normal, it comes
> >>>> from the
> >>>> DU being probed before its dependencies. Probe is deferred and
> >>>> retried,
> >>>> and finally succeeds as shown by
> >>>> 
> >>>> [drm] Initialized rcar-du 1.0.0 20130110 on minor 0
> >>>> 
> >>>> With a stock v4.4-rc2 kernel I get the same result, and I can then
> >>>> use the
> >>>> HDMI output without any issue with the modetest application.
> >>>> 
> >>>> I've attached the kernel configuration I used for testing, just in
> >>>> case.
> >>> 
> >>> Thanks, I have changed our HDMI display device(Old one -> other
> >>> newer one),
> >>> and then I could show a image on the display successfully. This test is
> >>> on Koelsch board.
> >>> But I found that, before showing the image on HDMI display,
> >>> I have to enable CONFIG_FRAMEBUFFER_CONSOLE =y or
> >>> run a command something like "fbset -xres 640 -yres 480 -laced 0", in
> >>> order to clear the first screen.
> >>> 
> >>> On Lager, with the same test method, I could show a image on RGB
> >>> display
> >>> very well,
> >>> but when I showed image on HDMI display, The image showed on display
> >>> looks bad as attached picture.
> >>> The attached picture: HDMI-Display-image-showed-from-Lager.jpg
> >>> 
> >>> Please have a look and show me what i have to do!
> >> 
> >> I'll try to reproduce that. Could you please send me the image file
> >> and the
> >> exact test procedure ?
> > 
> > I tested on v4.4-rc2 on Lager board.
> > 
> > CONFIG_DRM_RCAR_HDMI=y
> > CONFIG_DRM_I2C_ADV7511=y
> > VIDEO_ADV7511=y
> > CONFIG_FRAMEBUFFER_CONSOLE =y
> > 
> > I used the Morimoto-san's bmap tool to show image file.
> > ./bmap /dev/fb0 ./picture.bmp
> > 
> > I attach bmap file and the image file "picture.bmp".
> > 
> > Regards,
> > Jinso/Hiep.

-- 
Regards,

Laurent Pinchart

