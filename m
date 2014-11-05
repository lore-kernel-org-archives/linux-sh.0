From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Date: Wed, 05 Nov 2014 18:09:35 +0000
Subject: Re: [PATCH 2/7] pinctrl: pinconf-generic: Infer map type from DT property
Message-Id: <d0c8876b424049059acab000d07ffa4b@BN1AFFO11FD053.protection.gbl>
List-Id: <linux-sh.vger.kernel.org>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-3-git-send-email-soren.brinkmann@xilinx.com>
 <21124316.ibhe1N9UZS@avalon>
In-Reply-To: <21124316.ibhe1N9UZS@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, 2014-11-05 at 03:56PM +0200, Laurent Pinchart wrote:
> Hi Soren,
>=20
> Thank you for the patch.
>=20
> On Monday 03 November 2014 11:05:26 Soren Brinkmann wrote:
> > With the new 'groups' property, the DT parser can infer the map type
> > from the fact whether 'pins' or 'groups' is used to specify the pin
> > group to work on.
> > To maintain backwards compatibitliy with current usage of the DT
> > binding, this is only done when an invalid map type is passed to the
> > parsing function.
>=20
> The Renesas PFC implements similar bindings with using the vendor-specifi=
c=20
> properties "renesas,pins" and "renesas,groups" (bindings and implementati=
on=20
> available at Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctr=
l.txt=20
> and drivers/pinctrl/sh-pfc/pinctrl.c respectively).
>=20
> The Renesas implementation is a bit more generic in that it allows both p=
ins=20
> and groups to be specified in a single subnode. Do you think that feature=
=20
> would make sense for pinconf-generic as well ?

I don't have a use-case for that. I guess if somebody needs this kind of
functionality it could be added later. I would like to avoid blocking
pinctrl-zynq on adding more features here.

	Thanks,
	S=C3=B6ren
