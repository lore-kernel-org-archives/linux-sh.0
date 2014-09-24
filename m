From: Mark Brown <broonie@kernel.org>
Date: Wed, 24 Sep 2014 08:27:26 +0000
Subject: Re: regulator node names and unit-addresses? (Re: [PATCH v2 1/5] ARM: shmobile: kzm9d: Remove spurio
Message-Id: <20140924082726.GX4015@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="qRqofxetdBO9L27H"
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdVC2h4_Q+4BpV5iLbhfviimzrnfZ3+c6dqnegTAxBHw_g@mail.gmail.com>
 <20140924081455.GU4015@sirena.org.uk>
 <CAMuHMdWQfSLwqMMigLOZuGFJqQO03Qyw+ZHE1YAgd6mNDGmrEg@mail.gmail.com>
In-Reply-To: <CAMuHMdWQfSLwqMMigLOZuGFJqQO03Qyw+ZHE1YAgd6mNDGmrEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--qRqofxetdBO9L27H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 24, 2014 at 10:21:12AM +0200, Geert Uytterhoeven wrote:
> On Wed, Sep 24, 2014 at 10:14 AM, Mark Brown <broonie@kernel.org> wrote:

> > As far as the regulator API is concerned the node name is completly
> > immaterial and all this stuff is just verbiage we're forced to include.
> > As far as I can tell the requirement that node names be in the form
> > "regulator" or whatever is just another thing that wasn't terribly well
> > thought through in ePAPR, they were trying to do classes I think.

> So perhaps we should just keep "regulator@0" and "regulator@1"?

I don't care what they're called so long as things work; the DT people
are the ones to ask though.

--qRqofxetdBO9L27H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIoBtAAoJECTWi3JdVIfQcBwH/RPaghAYlu5qUpsvSrTkSIu9
ksbjo3QtgXhNyX2yLpwXla4v6zJSLcSQ8jlHBxvUeHWcGsS9LJyyi26TPuFvAA0J
zMZSNqSchAaIfpnseR0m+hTSxegOevDdaMmAEz+HdkQIFD20aBc6kpZtk85ebRZX
FYu/B5DcQIvUVssMqzW/VFwMd48IemU5KqzG8+r6rVp1Wta8EbZQdasfoRGAPji+
k8wlhyRwekQmPDyg1a2nKEga9qPCd0d146nEPDe0I8UXRdRIGD4VON7Df7tAGxr+
LvsAkYl5pCzKxMNPH7exwLASxk1i0zOx4JF/zGARqpIG6YJ5FgGXPjrjCy70jRM=
=nju0
-----END PGP SIGNATURE-----

--qRqofxetdBO9L27H--
