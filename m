From: Felipe Balbi <balbi@ti.com>
Date: Wed, 10 Sep 2014 13:50:28 +0000
Subject: Re: [PATCH 3/4] usb: renesas_usbhs: fix the timing of dcp_control_transfer_done
Message-Id: <20140910135028.GF667@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5CUMAwwhRxlRszMD"
List-Id: <linux-sh.vger.kernel.org>
References: <53F72602.3010704@renesas.com>
In-Reply-To: <53F72602.3010704@renesas.com>
To: linux-sh@vger.kernel.org

--5CUMAwwhRxlRszMD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2014 at 07:34:05PM +0900, Yoshihiro Shimoda wrote:
> According to the datasheet, this driver should clear the INTSTS0.CTRT
> bit before this controller detects the next stage transition. Otherwise,
> the driver may not be able to clear the bit after the controller went to
> the next stage transition. After that, the driver will not be able to
> clear the INTSTS0.VALID, and a usb control transfer will not finish
> finally.
>=20
> If we use the testusb tool, it is easy to reproduce this issue:
>=20
>  # testusb -a -t 10
>=20
> Since the previous code handled a data stage and a status stage in
> the usbhsf_pio_try_push(), it may not clear the INTSTS0.CTRT at the
> right timing.
> So, this patch changes the timing of usbhs_dcp_control_transfer_done()
> to the usbhsg_irq_ctrl_stage().
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

which commit does this fix ? Do we need to Cc stable ?

--=20
balbi

--5CUMAwwhRxlRszMD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUEFckAAoJEIaOsuA1yqREMOIQAJNEenlCebcvdKhyBSEGFIw3
bc0lm5Epm0OmBohKjapcGLbH8S6+ZKIubWkHL438sOFGGC8djG2GJxQGScQHXb3j
R3rPQv8BcP0WSQuynOPccqVhgelr0V+7h9QgVSjdFdw7a/g0ma0UTVjLRk7Y20SZ
hP/6Df9mtafCWMfdBrtaluXSv/ptZpH9BB0vUqTbjuZhkbuTNRh2i21wEYGUb9Rt
g4BXfiNbdrj5CqoHnfeF1BZf8mpgFZu6m+jo53OlgZrITUy8loKDS84g+UpncH23
/2t1huX93EsAOzEJ99Wzx69g4JhSPGylCdIFDkt+TUfeirL2wpSrmG7WlX2KOB60
xmJRrQgjS4z3J0uHW4zjDEJlGpZigIrD29jpElvDJV4YmdbMrY6mDMWX9SIWPIwb
WhLGNQbVKYBAhxwt38pIZsh5JkB9R6CQqQ2ABkZFHnJRLNU6HoddVfszgKCoQ5o0
1kQscDzJHbsYUP4cBPNgCYXWhTyx6Drp3OFdSPkO9NhCxx+7oA/WQC9rFXnTeK0j
Of+MEvlTTpG97WXkao0vOF5vSQ+UfHSQVdoWGpFtta9XE8PDXAn/C5rAOEN5rJd4
yTtlCDzLuKrwDL0QosCUYg5t/FXr5kcAObXnUZgJVTvpfKQzpraVWGBdo2dqhUPb
jcy6bTEdyEoXBmISP4wz
=+7eP
-----END PGP SIGNATURE-----

--5CUMAwwhRxlRszMD--
