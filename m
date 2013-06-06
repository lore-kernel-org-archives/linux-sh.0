From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 06 Jun 2013 13:12:24 +0000
Subject: Re: [PATCH v3] drm: Renesas R-Car Display Unit DRM driver
Message-Id: <CAKMK7uHB_x_qjFi40UbZs++3Z8cY8qnX2z2gw+_jGdHmEYEK=w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1370314420-26524-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1463323.zSQmk3Du5c@avalon>
	<CAKMK7uHA=HBNBZ7jSkB4RZCGRr-9ULLM4Wu3fWrSOqXA=docKw@mail.gmail.com>
	<1706860.sAZ4jDfQzD@avalon>
	<CADnq5_NcUziXdSxrN=LCYbDkvdxs1AuXMUEH5SDfzC=tRGOvtg@mail.gmail.com>
In-Reply-To: <CADnq5_NcUziXdSxrN=LCYbDkvdxs1AuXMUEH5SDfzC=tRGOvtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, dri-devel <dri-devel@lists.freedesktop.org>, linux-sh@vger.kernel.org

On Wed, Jun 5, 2013 at 3:10 PM, Alex Deucher <alexdeucher@gmail.com> wrote:
> To me at least, it doesn't make sense that an encoder can clone
> itself.  If an encoder is already in use, trying to clone itself would
> only lead to confusion and possible bugs (make sure some code path
> doesn't try and reprogram the encoder again, etc.).

For me the possible_clones mask is just the set of encoders which can
together share a crtc (presuming that crtc is indeed in all of the
possible_crtcs mask of each encoder). From that pov it makes imo sense
that a given encoder itself can always be with itself on the same crtc
;-)

Otoh setcrtc doesn't care one bit about encoders (the crtc helpers do
internally use them, but it's not interface). And the possible_clones
stuff is by far not enough to describe all hw restrictions. So tbh I
don't care which way we go (or whether we indeed keep on using this
much at all).
-Daniel
--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
