From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Date: Wed, 12 Nov 2014 18:53:15 +0000
Subject: Re: [PATCH 4/7] pinctrl: zynq: Document DT binding
Message-Id: <682b075ae056422683f93be4ea892011@BL2FFO11FD024.protection.gbl>
List-Id: <linux-sh.vger.kernel.org>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-5-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkdazagbSZdMvHTggQuAFm9uObn2ARoCwcyM-sspuLTXqkQ@mail.gmail.com>
In-Reply-To: <CACRpkdazagbSZdMvHTggQuAFm9uObn2ARoCwcyM-sspuLTXqkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, 2014-11-11 at 04:00PM +0100, Linus Walleij wrote:
> On Mon, Nov 3, 2014 at 8:05 PM, Soren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
>=20
> > Add documentation for the devicetree binding for the Zynq pincontroller.
> >
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> (...)
> > +Example:
> > +       pinctrl0: pinctrl@700 {
> > +               compatible =3D "xlnx,pinctrl-zynq";
> > +               reg =3D <0x700 0x200>;
> > +               syscon =3D <&slcr>;
> > +
> > +               pinctrl_uart1_default: pinctrl-uart1-default {
> > +                       common {
> > +                               groups =3D "uart1_10_grp";
> > +                               function =3D "uart1";
> > +                               slew-rate =3D <0>;
> > +                               io-standard =3D <1>;
> > +                       };
>=20
> I don't really like that you mix multiplexing and config in the
> same node. I would prefer if the generic bindings say we have
> muxing nodes and config nodes, and those are disparate.
>=20
> Can't you just split this:
>=20
> common-mux {
>     groups =3D "uart1_10_grp";
>     function =3D "uart1";
> };
>=20
> common-config {
>     groups =3D "uart1_10_grp";
>     slew-rate =3D <0>;
>     io-standard =3D <1>;
> };
>=20
> That way we can identify nodes as mux nodes (have "function")
> or config nodes (have "groups" or "pins" but not "function") which
> I think makes things easier to read.

I think such separation is not required by the bindings currently and
the parser assumes everything can be present in any node.
Can we add that requirement to the generic bindings without breaking
current users? I think it would make the implementation a little easier.
=09
	Thanks,
	S=C3=B6ren
