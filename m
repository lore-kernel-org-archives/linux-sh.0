From: Felipe Balbi <balbi@ti.com>
Date: Wed, 08 Oct 2014 18:22:05 +0000
Subject: Re: [PATCH v3 2/3] ARM: shmobile: koelsch: enable HS-USB
Message-Id: <20141008182205.GL22688@saruman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="E6lVPAHcXg6biC3t"
List-Id: <linux-sh.vger.kernel.org>
References: <1511869.4ca9KHmSFr@wasted.cogentembedded.com>
 <8674731.7YYzQeH0h1@wasted.cogentembedded.com>
 <20141008180513.GJ22688@saruman>
 <54357D76.4050104@cogentembedded.com>
 <20141008180852.GK22688@saruman>
 <54357E6F.1080702@cogentembedded.com>
In-Reply-To: <54357E6F.1080702@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org

--E6lVPAHcXg6biC3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2014 at 10:11:59PM +0400, Sergei Shtylyov wrote:
> On 10/08/2014 10:08 PM, Felipe Balbi wrote:
>=20
> >>>>From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>=20
> >>>>Enable HS-USB device for the Koelsch board, defining the GPIO that th=
e driver
> >>>>should check when probing (which is the ID output from MAX3355 OTG ch=
ip).
>=20
> >>>>Note that there will be pinctrl-related error messages if both intern=
al PCI
> >>>>and HS-USB drivers are enabled but they should be just ignored.
>=20
> >>>>Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >>>>[Sergei: added pin function/group and prop, moved device node, fixed =
summary,
> >>>>added changelog]
> >>>>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>=20
> >>>>---
> >>>>Changes in version 3:
> >>>>- added pinctrl-related properties;
>=20
> >>>did you miss pinctrl here ?
>=20
> >>     No, AFAICS. Or what do you mean?
>=20
> >usb0_pins doesn't appear to be defined anywhere.
>=20
>    They are defined in the same file, just not in this patch. If you're
> looking at some of the USB trees or Linus' tree, the corresponding patch
> just hasn't hit them yet, it's in renesas.git ATM.

oh, alright then. :-)

cheers

--=20
balbi

--E6lVPAHcXg6biC3t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUNYDNAAoJEIaOsuA1yqRE+jAP/iThRIVHetyuMSV2P8a3TnQa
R+rQEZ0vMy0BlFcxyBtOffkUppkTql5jFEmbDSlOfBqE6XW2ozCbnXZ23beHSR5X
J71QyC7szCjpseRvTm6lHmNrc9ob8dlBuFTrRh3rH40HGJf2VfutIfc2IO8laq6K
hDWC+ISbstRomyb5zqx+5VdyqxVVar8I2DETRtETAdIVULPUl6o6VCXbjdIDgKpS
2v/+GckcggfVW51y/TNtBvtpoEoTExSmsiZGvjfLrbGcv7LVKnFp8IR60JhnV+Ud
2seqsrJOq0k7vrBKb8yRSmvHH4tFdJY0KiDwbMiknuiMYsWQ5M71//Y/VtmNIXIL
LV3cDKhbL0s96DzWjBNNIHWQ3q6W2Fosf4gZufJ82GdF6jAs1MXIBv4iUbZnPxfj
320eJNgZrsZr1OS5LTvZMSQ2wdXUe+hMSNcLdekqFP6ldXmUQ8jZGrdL0w3b4bN4
HyzPrudf5W2x8tOLnC5AfEvT264vyfxIOr9sh5MvIPAx3ZwW+IGSV8eYmJFi/bxz
+XcuY91rjB2nzseVQ0IzacEh+spc3TRCqNCd4/2qBl2Zk90924JJrOCiLRyVNriJ
zW/mrX+6YsbTSLZfl3N0Ks4+6aZDw+OOUTBW7KwPm4ccteHvTTipk2QpiHSSdX/z
1Ohu3ApbtAdAWfartDo0
=xk3K
-----END PGP SIGNATURE-----

--E6lVPAHcXg6biC3t--
