From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 20 Mar 2015 08:18:18 +0000
Subject: Re: [PATCH 1/3] i2c: slave: rework the slave API
Message-Id: <20150320081818.GA2071@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
List-Id: <linux-sh.vger.kernel.org>
References: <1426164123-8853-1-git-send-email-wsa@the-dreams.de>
 <1426164123-8853-2-git-send-email-wsa@the-dreams.de>
 <20150319201751.GZ10068@pengutronix.de>
 <20150320071504.GA906@katana>
 <20150320072441.GA10068@pengutronix.de>
 <20150320073135.GC906@katana>
 <20150320074447.GE10068@pengutronix.de>
In-Reply-To: <20150320074447.GE10068-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Andrey Danin <danindrey-JGs/UdohzUI@public.gmane.org>, Marc Dietrich <marvin24-Mmb7MZpHnFY@public.gmane.org>, Debora Grosse <debora-HRUOeNTICTI@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2015 at 08:44:47AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Mar 20, 2015 at 08:31:35AM +0100, Wolfram Sang wrote:
> >=20
> > > > > > After more discussion, brave users, and additional datasheet ev=
aluation,
> > > > > > some API updates for the new I2C slave framework became imminen=
t. The
> > > > > > slave events now get some easier to understand naming. Also, th=
e event
> > > > > > handling has been simplified to only send one event per interru=
pt.
> > > > > what is an interrupt here? An event where the bus driver needs fe=
edback
> > > > > from the backend?
> > > >=20
> > > > More the other way around: when the bus driver needs to notify the
> > > > backend. I wasn't 100% sure about the word 'interrupt', but then de=
cided
> > > > a HW slave support without interrupts would be so rare and adventur=
ous
> > > > that it is okay to use the term :)
> > > Yeah, I agree on HW slave support without interrupts is hardly possib=
le.
> > > But I imagine that controllers differ in which situations they can is=
sue
> > > an interrupt so talking about them for generic code feels strange to =
me
> > > because $flexiblecontrolerwithvariousirqs doesn't need to send more
> > > events than $bareminimumcontroler.
> >=20
> > Do you have a better word at hand? "...to send one event per event"? :)
> Maybe:
>=20
> 	Also, the event handling has been simplified to only need a
> 	single call to the slave callback when an action by the backend
> 	is required.

Bought. Thank you.


--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVC9fKAAoJEBQN5MwUoCm2cuYQAJEYZXpZtsdSa8wLDpg8azHQ
84JZNmyHGFdaKhLbOYxQ+lqo7Di9xCzv4aBr/u8/A1QZ0Us7i2GtkB+XtrrzT2uI
2rhulH7MYhGMYlnYQPBC0b9bh9QLJ92o5LJyfBp8whyELb+Q6cuBUXHUwYD7+aAB
wy7uvH+fVD3ShWC5tTFQYOH488SVoTecKPpVJS+UOsKBWeoKozmynas7ozdF8UVg
qdH0WPFssaIJWKcueJsWeQQCiB/ocfkG0GGqapnmV884e8b54aH/lg7XD3M5ijcc
fqB9M6UxvvKAkyczBBRm2D/BPvwmnInOXx+seG/PY1F9CXSdWVsWeIZENcOM9E3B
EXtSsou6vdMBvLi4/sAE0qgwdxm+qNAmbCGgz02OM2ealqLnsPMYN5lS3g3OM8EJ
z4zO09RgK6q74MqlSQLWL+ND70iGbCsDfhJI25+92a2CAF5hk+JdrSDCR8fhWMLt
ec09CFWAbvObBcQTjtQOei7p+r8yT9iPbUB+qid3jdXwje51QnUWCRW3ZwGDntlk
0tzrG80JQGeKevL4lHypF3/6R+p0IbDmMr0S+ryNpaAXUvSXn2KlI3dHOoCZz4Z0
AwwdQfBHgnovLLzoKZUb96s1l7aULHOvJYIYA+OU/s1q47ReShB75hMDqwms7LaM
soBnhGXBMPGIsTP6c6nY
=Guvg
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
