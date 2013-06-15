From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 15 Jun 2013 23:52:59 +0000
Subject: Re: [RFC] pinctrl: generic: Add DT bindings
Message-Id: <1422045.RvRkWGR9K7@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1370988237-30593-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1795038.rqcr6GWLdP@avalon> <CACRpkdYi=ekV8okmz68HZ8Ydv9hTrHnHvQh0HYMs5SfURd9mdA@mail.gmail.com>
In-Reply-To: <CACRpkdYi=ekV8okmz68HZ8Ydv9hTrHnHvQh0HYMs5SfURd9mdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, James Hogan <james.hogan@imgtec.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Linus,

On Sunday 16 June 2013 01:51:32 Linus Walleij wrote:
> On Sun, Jun 16, 2013 at 1:35 AM, Laurent Pinchart wrote:
> > On Saturday 15 June 2013 22:16:13 Heiko St=FCbner wrote:
> >> Am Samstag, 15. Juni 2013, 21:56:05 schrieb Linus Walleij:
> >>=20
> >> Disable would the be either
> >>=20
> >>       bias-disable;
> >>=20
> >> or
> >>=20
> >>       bias-pull-up =3D <0>;
> >>=20
> >> A driver should probably handle both, as both are valid pinconf options
> >> or this.
> >=20
> > I feel a bit uneasy about that. Do we really need to support two differ=
ent
> > ways to achieve the same result ?
>=20
> In this specific case I think yes, but not on all options.
>=20
> As dicussed earlier this was designed for systems where
> you could set the pull-up resistance, like
>=20
> bias-pull-up =3D <600000>;
>=20
> would give 600kOhm pull up.
>=20
> In most existing systems that is silly, as they can't specify it, so they
> should be able to do just:
>=20
> bias-pull-up;
>=20
> as that is all they can do. If we have to cut one way, we should cut the
> former until such a system appears.

I'm fine with bias-pull-up =3D <1>; vs bias-pull-up;. What bothers me a bit=
 is=20
bias-pull-up =3D <0>; vs bias-disable;.

--=20
Regards,

Laurent Pinchart

