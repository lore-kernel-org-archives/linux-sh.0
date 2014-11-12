From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Date: Wed, 12 Nov 2014 18:43:25 +0000
Subject: Re: [PATCH 2/7] pinctrl: pinconf-generic: Infer map type from DT property
Message-Id: <67efe9ba5e634b3cb925ab4d68e59726@BL2FFO11FD023.protection.gbl>
List-Id: <linux-sh.vger.kernel.org>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-3-git-send-email-soren.brinkmann@xilinx.com>
 <21124316.ibhe1N9UZS@avalon>
 <CACRpkdZH9b_KB9Mz8r5vj=KGqr0bJeKMRgODUbNeBDVNr=tsCg@mail.gmail.com>
In-Reply-To: <CACRpkdZH9b_KB9Mz8r5vj=KGqr0bJeKMRgODUbNeBDVNr=tsCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, 2014-11-11 at 01:29PM +0100, Linus Walleij wrote:
> On Wed, Nov 5, 2014 at 2:56 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > On Monday 03 November 2014 11:05:26 Soren Brinkmann wrote:
> >> With the new 'groups' property, the DT parser can infer the map type
> >> from the fact whether 'pins' or 'groups' is used to specify the pin
> >> group to work on.
> >> To maintain backwards compatibitliy with current usage of the DT
> >> binding, this is only done when an invalid map type is passed to the
> >> parsing function.
> >
> > The Renesas PFC implements similar bindings with using the vendor-speci=
fic
> > properties "renesas,pins" and "renesas,groups" (bindings and implementa=
tion
> > available at Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinc=
trl.txt
> > and drivers/pinctrl/sh-pfc/pinctrl.c respectively).
> >
> > The Renesas implementation is a bit more generic in that it allows both=
 pins
> > and groups to be specified in a single subnode. Do you think that featu=
re
> > would make sense for pinconf-generic as well ?
>=20
> I think for generic pin controllers either nodes with:
>=20
> {
>     function =3D "foo";
>     pins =3D "A0", "A1", "A2";
> }
>=20
> or
>=20
> {
>     function =3D "foo";
>     groups =3D "bar", "baz";
> }
>=20
> In parsing this it's easy to just look for "function" then see if
> we're mapping to groups or pins.
>=20
> It'd be nice if we could then centralize parsing of functions/pins/groups
> and add the non-renesas-prefixed configs as alternatives to genericized
> the bindings, while keeping backward compatibility.

I think the generic parser can't handle that currently. When it finds
'function' it passes the PINs to pinctrl_utils_add_map_mux(). That
function fails when it doesn't receive a group.
I don't know if the non-generic pinctrl drivers solve that somehow, but
pinconf-generic can't handle pins + function in the same node if we
change the meaning of pins to actually just be pins.

That is why I chose the "kludgy" approach. To maintain current behavior.
If nobody needs that though, things could change I guess.

	S=C3=B6ren
