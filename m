From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Wed, 05 Jun 2013 11:57:53 +0000
Subject: Re: [PATCH v3] drm: Renesas R-Car Display Unit DRM driver
Message-Id: <20130605115753.GH5004@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1370314420-26524-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1463323.zSQmk3Du5c@avalon>
 <CAKMK7uHA=HBNBZ7jSkB4RZCGRr-9ULLM4Wu3fWrSOqXA=docKw@mail.gmail.com>
 <1706860.sAZ4jDfQzD@avalon>
In-Reply-To: <1706860.sAZ4jDfQzD@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, dri-devel <dri-devel@lists.freedesktop.org>, linux-sh@vger.kernel.org

On Wed, Jun 05, 2013 at 03:51:53AM +0200, Laurent Pinchart wrote:
> Hi Daniel,
>=20
> On Tuesday 04 June 2013 20:36:20 Daniel Vetter wrote:
> > On Tue, Jun 4, 2013 at 8:03 PM, Laurent Pinchart wrote:
> > > On Tuesday 04 June 2013 16:12:36 Daniel Vetter wrote:
> > >> On Tue, Jun 04, 2013 at 04:53:40AM +0200, Laurent Pinchart wrote:
> >
> > [snip]
> >=20
> > >> Should we add that to crtc helpers, instead of the current "just try=
 to
> > >> smash the old config on top of the ill-defined hw state after a fail=
ed
> > >> modeset"?
> > >=20
> > > It would probably make sense to add a rollback operation to undo the
> > > prepare operation, or maybe just a rollback/commit flag to the commit
> > > operation. We would still need to smash the old config back though, as
> > > the rollback operation shouldn't be expected to handle encoders and
> > > connectors.
> > >=20
> > > While we're at it, shouldn't we make drivers report supported formats=
 for
> > > the main frame buffer, like we do for planes ? That would allow catch=
ing
> > > format errors before calling the prepare operation.
> >=20
> > Yeah, I've noticed that one, too. I guess we could tackle that as part
> > of an eventual "make the implicit primary plane a bit more explict"
> > project. For now I'm not too offended by the duplication of checks.
>=20
> It would be nice to treat the primary plane as all the other planes. Seve=
ral=20
> embedded display engines don't make the primary plane special and just pa=
int=20
> the background with a plain color when the enabled planes don't cover the=
=20
> entire display.

Same deal for some intel hardware (at least partially). Anyways, my
current plan is that we fix it for the atomic pageflip/modeset stuff.
Ie. I don't even want expose the CRTC scanout stuff in the new atomic
API.

--=20
Ville Syrj=E4l=E4
Intel OTC
