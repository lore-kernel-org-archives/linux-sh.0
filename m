From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 13 Jun 2013 22:23:26 +0000
Subject: Re: [PATCH v5 01/22] pinctrl: generic: Add DT bindings
Message-Id: <1961223.akELqavQP8@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1370989371-30846-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1370989371-30846-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CACRpkdYev+hapkM075Sw7Yi0u+XpRvL74SwT39DV1aV1RtHC+Q@mail.gmail.com>
In-Reply-To: <CACRpkdYev+hapkM075Sw7Yi0u+XpRvL74SwT39DV1aV1RtHC+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Linus,

On Wednesday 12 June 2013 11:24:38 Linus Walleij wrote:
> On Wed, Jun 12, 2013 at 12:22 AM, Laurent Pinchart wrote:
> > Document DT properties for the generic pinctrl parameters and add a
> > parser function.
> >=20
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
>=20
> It appears we have a race here, as something like three people,
> or four, happened to do generic pinconf bindings at the same time.
>=20
> Yesterday I applied Heiko St=FCbners patch
> "pinctrl: add function to parse generic pinconfig properties from a dt no=
de"
> doing basically the same thing. With subtle differences...
> but it already supports schmittrigging and some more.
>=20
> It appears to be close to your idea though!
>=20
> Would it be possible for you to look at what I have on my "devel" branch
> now (same as submitted for -next), rebase on that and patch any problems?

OK, I will do so. In the meantime I'll resubmit this patch series without t=
he=20
pinconf DT bindings for inclusion in v3.11, and will then post follow-up=20
patches to add pinconf DT support, for v3.11 or v3.12 depending on the timi=
ng.

> > +               if (param->flag) {
> > +                       ret =3D of_property_read_bool(np, param->proper=
ty)
> > +                           ? 0 : -EINVAL;
> > +                       val =3D 1;
> > +               } else {
> > +                       ret =3D of_property_read_u32(np, param->propert=
y,
> > &val); +               }
>=20
> This construct is done differently in Heiko's code, please review it so we
> know we have a nice, efficient parser.

--=20
Regards,

Laurent Pinchart

