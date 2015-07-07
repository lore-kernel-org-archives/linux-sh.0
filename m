From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 07 Jul 2015 19:49:32 +0000
Subject: Re: [PATCH 3/5] i2c: emev2: add driver
Message-Id: <20150707194931.GC1572@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ctP54qlpMx3WjD+/"
List-Id: <linux-sh.vger.kernel.org>
References: <1436219188-4325-1-git-send-email-wsa@the-dreams.de>
 <1436219188-4325-4-git-send-email-wsa@the-dreams.de>
 <8117172.9hfShvmdlS@avalon>
In-Reply-To: <8117172.9hfShvmdlS@avalon>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +static inline void em_clear_set_bit(struct em_i2c_device *priv, u8 cle=
ar,
> > u8 set, u8 reg)
>=20
> Maybe em_i2c_clear_set_bit for consistency ? I'd prefer having the reg=20
> argument before clear and set, but maybe that's just me.

This is such a generic function that I decided to skip 'i2c' in the
function name. Can add it, don't have a strong preference.

> I would have also introduced em_i2c_read and em_i2c_write. That's entirel=
y up=20
> to you.

I don't like such wrappers around standard read/write functions. What's
the gain?

> > +		retr =3D 1000;
> > +		while (readb(priv->base + I2C_OFS_IICACT0) =3D=3D 1 && retr)
>=20
> How about adding a cpu_relax() here ?

Can do, but I think it is overkill.

>=20
> > +	/* Extra setup for read transactions */
> > +	if (!(status & I2C_BIT_TRC0)) {
>=20
> How about checking msg->flags & I2C_M_RD here ? It should be equivalent b=
ut=20
> would make the code more readable by not requiring knowledge of the hardw=
are.=20

I buy this argument. Will change.

> > +	priv =3D devm_kzalloc(&pdev->dev, sizeof(struct em_i2c_device),=20
> GFP_KERNEL);
>=20
> I'd use sizeof(*priv).

Yes, definately.

> > +	irq =3D platform_get_irq(pdev, 0);
>=20
> I'd move this call right before devm_request_irq() below. devm_request_ir=
q()=20
> should handle invalid IRQs, but won't print an error message. I'd let you=
=20
> decide whether that's a problem.

Will check.

>=20
> > +	priv->adap.timeout =3D msecs_to_jiffies(100);
> > +	priv->adap.retries =3D 5;
>=20
> Is there a particular reason for setting the number of retries to 5 ?

It should be non-zero at least, so bus access will be retried if -EAGAIN
is returned because of a busy bus.

> > +	if (ret)
> > +		goto exit_clk;
>=20
> Nitpicking, I'd call this error_clk to show that the label is used in cas=
e of=20
> error only. You could also just call it error as there's no other error-
> related label.

Yup.

> > +	dev_info(&pdev->dev, "Added i2c controller %d irq %d @ 0x%p\n",
> > +		priv->adap.nr, irq, priv->base);
>=20
> Is priv->base useful here ? The physical address of the registers block c=
ould=20
> be, but its kernel virtual address doesn't seem very interesting to me.

Agreed.

Thanks for the review!

   Wolfram


--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnC1LAAoJEBQN5MwUoCm2EPUP/i1PGhBVjbswPkoLW5/sw+0g
osIPi8mRhR5g/KiKNsa3hSDaQXkBj5znbmp/tpZ35Gky8/rL5h0gfUqyo8koocif
yO/jgfE1XecbXsk1sEO2EdgH2AqY1+WzIBvc+ZmRZK4UBmo/MKJG8YPj4vDsd5ZW
T/1LMObWu0QnAf4r5oPs2KvfgH0+4v4xQfy+jat02oyINNZoG27RMf3i3rElyh3p
wfxMMwxYiwkEHztnyviOft9ndR7qtw9vloe0UsP4i6LAjhzMiOG3Fz3ZTgwWQYmS
8i+zq9JK8Orz/aDfGtJUhuq3sdMaxdtkLYNZiLeh/HG9J1NuVf/+LxlthAseVmHR
k+nuxYsGcq2kDvKtH0FYq0ET9KVDa3Jph+eqfDL3oYJoF6d171sJuYoFVB0ZmC6N
PlOImTwhLF07N2pOegpMiZ2Nm8tjmh7zZtHl9iEo9ozekQyLQnjY2j8UpObEcjGH
BjOdO0D6MwVyBsUWaZSQ2o7r0WGFA+LaDRYvRuUACA97e1++tbOJfl+DWc3y+FXR
puM9vmM3zxRe5/+HWubaHiy14gnfGvT3z0KkqrdSyqol3esOlGTz29xrYbxW1eem
P4Px60MYyVXqmZqgTsMTiU47zWD/ozlHbOY/hjQXYjJTYDjxpsHd2A3VixU02e/t
PBbSPEUQxxJC7n2Z4Sq1
=/yCE
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
