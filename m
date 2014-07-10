From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 10 Jul 2014 09:54:30 +0000
Subject: Re: [PATCH v5 8/8] ARM: shmobile: genmai-reference: Enable MTU2 in device tree
Message-Id: <20140710095430.GD2728@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GyRA7555PLgSTuth"
List-Id: <linux-sh.vger.kernel.org>
References: <1404911564-17380-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1404911564-17380-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1404911564-17380-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2014 at 03:12:44PM +0200, Laurent Pinchart wrote:
> No more device needs to be added from platform code when booting the
> reference platform, move MTU2 registration from setup-r7s72100.c to
> board-genmai.c and remove the now empty r7s72100_add_dt_devices()
> function.
>=20
> As the genmai_add_standard_devices() function is now identical to the
> default init_machine implementation, remove it as well.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>

Yay, tasty!

Reviewed-by: Wolfram Sang <wsa@sang-engineering.com>


--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTvmLWAAoJEBQN5MwUoCm2doEQAILnGMScbm3FaU9eoM/nir0+
OX3aRNAgVQtklrrZf/HohfBP6K1FN2OLq/UryNqJyQ23etLu3CtHjNyM4D3BnCM8
ai5yBdzl0JvLAN3wjJECWkvvxDuuS5U+YZT1QtvoISGsZgDKKgD37ZPkYG/hrNRg
EJAgRNXE5M3E3qAqYktpjxdy4wwT0lqmJZb/3XP2k2F7/OzBQA6xYyp+JXaRjgPn
IF6VRxY9meZC4b2F9eXH7RPgbFQJ+uUOYhAWunB8IDNLjIKvQBu+lNP3TEDtQY1E
cEt7CMqzHZYCAO55jyl5UAFSVwIgK7ZQKrXKaZMSjLiJvUnQyN3l0hL7U0j/G9YQ
uo7dgOj1HA9wFphuiOIG95wYKp7RtwuQq7EAqCx4g/aModnQE54sso7TY5afWBpa
TYeMX8qw4rAxXYYoj7xiyh8qIIoCUN0vJnz9+ptZ3wpl2RK6/A81oxnSfiBRIsIl
VmivUS2Ko1zbqIx5OEF1Q9YeRT0MzuCXQvHOLZ1QFlZAOid30WMFxDbA4LQq603K
5Wfhw6V/+ImPcZX86cV5yxJq/WTuYYQebbDn05szS/y9rJqz1wcxFDlp9xkiT0qh
ClQQocZCLbJLKLQMCj94q6LaDIyDxLKk4iB9bfZL4RLpzC/Aftj0L5T1gACrB18e
Bc6BRZJOHCavn0eJC6xA
=osPw
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--
