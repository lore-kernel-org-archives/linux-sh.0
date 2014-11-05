From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 05 Nov 2014 18:17:38 +0000
Subject: Re: [PATCH 2/7] pinctrl: pinconf-generic: Infer map type from DT property
Message-Id: <1417202.djDaFURS6d@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <21124316.ibhe1N9UZS@avalon>
 <d0c8876b424049059acab000d07ffa4b@BN1AFFO11FD053.protection.gbl>
In-Reply-To: <d0c8876b424049059acab000d07ffa4b@BN1AFFO11FD053.protection.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi S=F6ren,

On Wednesday 05 November 2014 10:09:35 S=F6ren Brinkmann wrote:
> On Wed, 2014-11-05 at 03:56PM +0200, Laurent Pinchart wrote:
> > On Monday 03 November 2014 11:05:26 Soren Brinkmann wrote:
> > > With the new 'groups' property, the DT parser can infer the map type
> > > from the fact whether 'pins' or 'groups' is used to specify the pin
> > > group to work on.
> > > To maintain backwards compatibitliy with current usage of the DT
> > > binding, this is only done when an invalid map type is passed to the
> > > parsing function.
> >=20
> > The Renesas PFC implements similar bindings with using the vendor-speci=
fic
> > properties "renesas,pins" and "renesas,groups" (bindings and
> > implementation available at
> > Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt and
> > drivers/pinctrl/sh-pfc/pinctrl.c respectively).
> >=20
> > The Renesas implementation is a bit more generic in that it allows both
> > pins and groups to be specified in a single subnode. Do you think that
> > feature would make sense for pinconf-generic as well ?
>=20
> I don't have a use-case for that. I guess if somebody needs this kind of
> functionality it could be added later. I would like to avoid blocking
> pinctrl-zynq on adding more features here.

I'm fine with that, as long as the changes won't require breaking the DT AB=
I.=20
I don't think they would but I wanted to raise the issue in case I would ha=
ve=20
missed a potential issue.

--=20
Regards,

Laurent Pinchart

