From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 07 Jun 2013 08:51:40 +0000
Subject: Re: [PATCH v3] drm: Renesas R-Car Display Unit DRM driver
Message-Id: <20130607085140.GQ7827@phenom.ffwll.local>
List-Id: <linux-sh.vger.kernel.org>
References: <1370314420-26524-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CAKMK7uHB_x_qjFi40UbZs++3Z8cY8qnX2z2gw+_jGdHmEYEK=w@mail.gmail.com>
 <CADnq5_NJMmk-11vVXm4mXt19OQRyNje74GsaLg31ML72JPMvyQ@mail.gmail.com>
 <7879358.D2jilZSibG@avalon>
In-Reply-To: <7879358.D2jilZSibG@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, dri-devel <dri-devel@lists.freedesktop.org>, linux-sh@vger.kernel.org

On Fri, Jun 07, 2013 at 09:23:58AM +0200, Laurent Pinchart wrote:
> On Thursday 06 June 2013 09:21:35 Alex Deucher wrote:
> > On Thu, Jun 6, 2013 at 9:12 AM, Daniel Vetter wrote:
> > > On Wed, Jun 5, 2013 at 3:10 PM, Alex Deucher wrote:
> > >> To me at least, it doesn't make sense that an encoder can clone
> > >> itself.  If an encoder is already in use, trying to clone itself would
> > >> only lead to confusion and possible bugs (make sure some code path
> > >> doesn't try and reprogram the encoder again, etc.).
> > > 
> > > For me the possible_clones mask is just the set of encoders which can
> > > together share a crtc (presuming that crtc is indeed in all of the
> > > possible_crtcs mask of each encoder). From that pov it makes imo sense
> > > that a given encoder itself can always be with itself on the same crtc
> > > ;-)
> > > 
> > > Otoh setcrtc doesn't care one bit about encoders (the crtc helpers do
> > > internally use them, but it's not interface). And the possible_clones
> > > stuff is by far not enough to describe all hw restrictions. So tbh I
> > > don't care which way we go (or whether we indeed keep on using this
> > > much at all).
> > 
> > Same.  I can go either way.
> 
> So what's the agreement ? :-)

I think officially "meh". Keep your current code and we'll try to fix this
once it blows up somewhere for real ;-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
