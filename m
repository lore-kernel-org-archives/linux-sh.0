From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 21 Apr 2015 07:06:53 +0000
Subject: Re: [RFC] i2c-tools: i2ctransfer: add new tool
Message-Id: <20150421070653.GA900@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
List-Id: <linux-sh.vger.kernel.org>
References: <1425053816-19804-1-git-send-email-wsa@the-dreams.de>
 <20150420173638.GA1452@katana>
 <20150421072551.326bb4b7@endymion.delvare>
In-Reply-To: <20150421072551.326bb4b7-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2015 at 07:25:51AM +0200, Jean Delvare wrote:
> Hi Wolfram,
>=20
> On Mon, 20 Apr 2015 19:36:38 +0200, Wolfram Sang wrote:
> > On Fri, Feb 27, 2015 at 05:16:56PM +0100, Wolfram Sang wrote:
> > > This tool allows to construct and concat multiple I2C messages into o=
ne
> > > single transfer. Its aim is to test I2C master controllers, and so th=
ere
> > > is no SMBus fallback.
> > >=20
> > > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > > ---
> > >=20
> > > I've been missing such a tool a number of times now, so I finally got=
 around to
> > > writing it myself. As with all I2C tools, it can be dangerous, but it=
 can also
> > > be very useful when developing. I am not sure if distros should suppl=
y it, I'll
> > > leave that to Jean's experience. For embedded build systems, I think =
this
> > > should be selectable. It is RFC for now because it needs broader test=
ing and some
> > > more beautification. However, I've been using it already to test the =
i2c_quirk
> > > infrastructure and Renesas I2C controllers.
> >=20
> > Jean, my tests went well and so I want to brush it up for inclusion into
> > i2c-tools upstream. Any show-stoppers you see from a high-level point of
> > view?
>=20
> I think it is a good idea, just I couldn't find the time to review it,
> sorry :(

No problem, no hurry. Glad to know that you like it in general.


--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVNfcNAAoJEBQN5MwUoCm25CAP/2e4wFJ2ef6Kb4M6XLGDk3Nf
9YGC9DOjvXdLD2xfmXXBz1yjQ895kUS904auLt8fUf9+9m/O3RuXT0LX2+0F7MOw
q7Wrk/W2rptAcghX69JIjcvGhBJjFLsLuS9pvYEQzzaDaUnIi44wPAJLKT9mJjie
OKiCu+6hesUVuac74UiuU7y2lwwN0JHbDV2kfp3eQOJ2zxe1rqcHsDgU9fsxWGVI
2QZkVJAUJKRxHgKy/auvDyUpHH2mziMpR/5dlccev442oA1C7cZE/YT4EfUJrUnF
+QPlTTdParOd0lbSWu088j9kiCSSQLacctLT0LGTdEKFHTPxJRgjl4XMSDlrMXpv
g3PTm0tsnistPbTIIZDBap/wt5w2HiK1dDWdvpVmInPYyn+oc3Th75eaex5rLyaf
dlJGbs4j6KY/HnXxjOH35STIZfCjq2hAHwkUlWTaE70G0Q/bWCvh26zoaNY9O9VR
y1pXtvIHqkPfhQ1phUaIU/+Ue4ws1kiwTqsUduWP7sx0dbWAVX6hyvzGcNvKw+Uv
dqqFr75XpV7tvcbCDzJDeZr6cpfY9v5CBDwYlstAN6yHITXKAcIlSfb0UHTpBjm/
wCgH1JKPCJJJ1vAF7CairBbhT5M4H9Hqd6lNeSPImoM5egkXv1Rgap7bC+JJnJET
yO5+IW2nM5RVFJSL0S5e
=dc89
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
