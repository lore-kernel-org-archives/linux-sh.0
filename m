From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Sep 2015 04:30:11 +0000
Subject: Re: [PATCH/RFC v2 net-next 1/4] phylib: Add phy_set_max_speed helper
Message-Id: <20150911043011.GA20882@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1441936878-18290-1-git-send-email-horms+renesas@verge.net.au>
 <1441936878-18290-2-git-send-email-horms+renesas@verge.net.au>
 <55F2552A.1010509@gmail.com>
In-Reply-To: <55F2552A.1010509@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, Sep 10, 2015 at 09:14:34PM -0700, Florian Fainelli wrote:
> Le 09/10/15 19:01, Simon Horman a =C3=A9crit :
> > Add a helper to allow ethernet drivers to limit the speed of a phy
> > (that they are attached to).
> >=20
> > This mainly involves factoring out the business-end of
> > of_set_phy_supported() and exporting a new symbol.
> >=20
> > This code seems to be open coded in several places, in several different
> > variants.
> >=20
> > This code is envisaged this will be used in situations where setting
> > the "max-speed" property is not appropriate, e.g. because the maximum
> > speed is not a property of the phy hardware.
>=20
> This looks good to me, one minor comment, see below:
>=20
> >=20
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >=20
> > ---
> >=20
> > v2
> > * First post
> > ---
> >  drivers/net/phy/phy_device.c | 52 ++++++++++++++++++++++++++++--------=
--------
> >  include/linux/phy.h          |  1 +
> >  2 files changed, 34 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > index c0f211127274..d9a020095972 100644
> > --- a/drivers/net/phy/phy_device.c
> > +++ b/drivers/net/phy/phy_device.c
> > @@ -1205,6 +1205,37 @@ static int gen10g_resume(struct phy_device *phyd=
ev)
> >  	return 0;
> >  }
> > =20
> > +static void __set_phy_supported(struct phy_device *phydev, u32 max_spe=
ed)
> > +{
> > +	if (!IS_ENABLED(CONFIG_OF_MDIO))
> > +		return;
>=20
> I think that part should be moved to of_set_phy_supported(), since your
> are exporting phy_set_max_speed() which should therefore be available
> regardless of whether Device Tree is used.

Yes of course, silly me.

> While you are it, it might be nice to either warn or return -ENOTSUPP if
> the speed does not match 10, 100 or 1000, but that might be worth a
> second patch.

Sure, that sounds reasonable.
