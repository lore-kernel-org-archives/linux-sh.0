From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 19 Mar 2015 15:39:49 +0000
Subject: Re: [RFC V2 2/4] i2c: mux: add function to reparent a mux
Message-Id: <20150319153949.GD7657@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="4zI0WCX1RcnW9Hbu"
List-Id: <linux-sh.vger.kernel.org>
References: <1426576524-22315-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1426576524-22315-3-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2015 at 08:15:22AM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Used for n-to-1 demuxes. Needs discussion.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

So, I'll discuss this with myself ;)

While this works, it is abusing the driver model quite much.
sysfs-representation will not notice the new parent and it does not look
possible to mark instantiated slaves as "kernel-driven" for the
currently active bus. They will only be marked for the bus they were
attached during instantiation.

It is nice to have some working code in case you need core switching and
leaving the childs active. However, I think an approach with
de/re-registering will be much cleaner.

I will hack something for that next week taking the DT binding from this
approach. I think we are quite OK with that one, or?

> ---
>=20
> Changes since RFC V1: none, only rebased
>=20
>  drivers/i2c/i2c-mux.c   | 8 ++++++++
>  include/linux/i2c-mux.h | 2 ++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index 593f7ca9adc783..c64f3fc9bb3750 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -100,6 +100,14 @@ static unsigned int i2c_mux_parent_classes(struct i2=
c_adapter *parent)
>  	return class;
>  }
> =20
> +void i2c_mux_reparent(struct i2c_adapter *adap, struct i2c_adapter *new_=
parent)
> +{
> +	struct i2c_mux_priv *priv =3D adap->algo_data;
> +
> +	priv->parent =3D new_parent;
> +}
> +EXPORT_SYMBOL_GPL(i2c_mux_reparent);
> +
>  struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
>  				struct device *mux_dev,
>  				void *mux_priv, u32 force_nr, u32 chan_id,
> diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
> index b5f9a007a3abdd..488a7744732853 100644
> --- a/include/linux/i2c-mux.h
> +++ b/include/linux/i2c-mux.h
> @@ -44,6 +44,8 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adap=
ter *parent,
> =20
>  void i2c_del_mux_adapter(struct i2c_adapter *adap);
> =20
> +void i2c_mux_reparent(struct i2c_adapter *adap, struct i2c_adapter *new_=
parent);
> +
>  #endif /* __KERNEL__ */
> =20
>  #endif /* _LINUX_I2C_MUX_H */
> --=20
> 2.1.4
>=20

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVCu3FAAoJEBQN5MwUoCm25QQQAImHPmBiRsWCktl5PhO0eujh
G7Ph52iyKCnQO3FqO+j2bMFG9rM7hiNqCr31tjgwC6vsxwb+ZB/1t+03zKIZ/+iQ
7xw1V57JVvO2waj5TsYAfr+cKmdqbtXy43NVakyG6JMR+HzqrJ0W8gG5NOf8/5K8
+HykVrA0VdlRHRDMFnOnVCWA2zlKV8pZkAPiXdqmD+b649BC4E7uc3jUhrNCzwZ5
yebTWIwIFV3p4dwYIAsmc2v8KXFbHhT8a3mNig43KPkhy6P7wgdKEaYruaQXUCJh
3sGZh6YOZh+Lx2RTl4zAC8n3Y+uq7K8A7o8tAmVUS5It8jE24WJ4K0janggpPXtQ
3eRJjcAI3zawv5kWfdWY/39jQPL/UWAreDhsxeKTTSkqG/z3S6YXRfInS+fOixG8
epxAG3oXfmK8MsXWB8rGbYwMIAm5UfM5gl6LeuB7TlmnpnRr1I4XUTCKS4/nzB68
Lyxw7Jp8MwmprdGufHE2GcIwCaM3OCrztT8W0Cwdz8c9Cbj0nGi3HGkXpQZl1Efz
3EeUMT8audt5IO7O6MC7yb19lf+s07n1QvmNXJ9iIzq3sMlB4dixoq4cf8DTylk4
37hIMQ93bnli8pRuJJAKPe+GYmcIAbhliX1xDaP1MJzp6VyyzkDO8784kKtnOTys
uJa+ejBIxo7f4XIlIRFZ
=K4lu
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
