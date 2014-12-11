From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 11 Dec 2014 08:28:17 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <20141211082817.GA2239@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
 <20141211050226.GJ16827@intel.com>
 <20141211073727.GA1252@katana>
 <8247960.gkSH1BQ5uX@avalon>
In-Reply-To: <8247960.gkSH1BQ5uX@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, dmaengine@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 09:47:29AM +0200, Laurent Pinchart wrote:
> On Thursday 11 December 2014 08:37:27 Wolfram Sang wrote:
> > > I think this is a limitation of driver may not be for HW. The right m=
odel
> > > for dma_chan is to be viewed as SW channels and not the ones of HW (y=
es
> > > that is how most of the drivers use that, but we can improve upon)
> > >=20
> > > If we rework the driver to view dma_chan as SW channels, then you can
> > > accept multiple channel requests and accept based on if we are able l=
ink
> > > the channel to that peripheral or not.
> >=20
> > In my understanding, the DMA driver does exactly that.
>=20
> Actually it doesn't at the moment, I should implement that.

OK, so I was misinterpreting the overcommitment. Thanks for the correction!

> > However, it is not even loaded at the time the I2C driver wants a chann=
el,
> > so the dmaengine core defers the probe. That is the problem for optiona=
l DMA
> > channels: we can't know when deferring probe won't help anymore and don=
't
> > know when it is time to fall back to PIO.
>=20
> This is true regardless of the whether the driver exposes HW or SW channe=
ls.

Yup.


--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUiVWgAAoJEBQN5MwUoCm2PA8QAInOOPLWsmLB2S0HtdYeLJod
Xmri9s4PlZs+iMEjF8oY/5RMEba8Y9FQk2fBeoKDQOuY1lhutIwYT3jk5AibUKCw
0h88MNAUlxL61Ia/l1bZimfXYpIzWUGxizek4M2AXZnPOzVb2OyARimzeurxCtQx
r3BATuQ30cXhXtoJxcvzI9vfdISVJtCAdn5JJilGxYimyd0nt4PETNMw3cAGyU2z
xiAhliIxYId/YI4D0WQpyub7a1CbrnU1Sw9360hUROg36E8ice2ZASc6TAUn8mqT
4QGP4BZMlXuTcgLGsR/NwBnHhVG6PbJlVS9cMhW4yCot+CobT0ZbNPxw0ytJ8/QT
+nn6qY8E2wiqdSsoHk9Mhwtzh8PqSh+EEz76TqKpt0ttYy+qNYmRoAJ5uwKxx0x+
B/oBILryCJTWn8Br/66KRSVUKbamRYaO40eMI6I6n+vejG+IuotXVmSLo9Vc4hHI
+fvxynKLduzZBeQo8ROhovc0YEyQpd0UUrZE/qg+HRAoP/I9GLkK43x0l54+fGRh
qnoPTNruMLItmjkx1doVjJoDouopKWoghmWjL7TGhpnZieYfGyyjZzyDbPWziXWX
4fWOopmCNMtSupL+fOgy6Gva/bQcFZmWBPg72WZ+JOibv8fT/EJc2UH7Cq8W1ef0
lHvO6I8nCOn52jDREHSw
=EUr9
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
