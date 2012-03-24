From: Richard Weinberger <richard@nod.at>
Date: Sat, 24 Mar 2012 11:12:12 +0000
Subject: Re: [PATCH 08/10] um: Fix possible race on task->mm
Message-Id: <4F6DAC0C.4010203@nod.at>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enigD953513F54FF3AFE747589E6"
List-Id: <linux-sh.vger.kernel.org>
References: <20120324102609.GA28356@lizard> <20120324103050.GH29067@lizard>
In-Reply-To: <20120324103050.GH29067@lizard>
To: linux-arm-kernel@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD953513F54FF3AFE747589E6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 24.03.2012 11:30, schrieb Anton Vorontsov:
> Checking for task->mm is dangerous as ->mm might disappear (exit_mm()
> assigns NULL under task_lock(), so tasklist lock is not enough).
>=20
> We can't use get_task_mm()/mmput() pair as mmput() might sleep,
> so let's take the task lock while we care about its mm.
>=20
> Note that we should also use find_lock_task_mm() to check all process'
> threads for a valid mm, but for uml we'll do it in a separate patch.
>=20
> Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard


--------------enigD953513F54FF3AFE747589E6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPbawQAAoJEN9758yqZn9et8IIAIjjApdHtjO4jbQojJt9/hMC
a2mKqQUILDnbdr7KTCZu3OGUbHpQhvdWYo1ZssGjz9XHSDFIKF8PdmSwPuh46HcO
GZwGZ6gfPRV23gJr1BnT+WkJzRoC4CG/xBzt2YpPMgjLDFAs4mkGX0w0knd/iEYD
hu185ttLe/u2DmU2rbCsEJ9YfxkwQ0+326WxH7D71HwAMpRCtmg1ciPdXMabeNnq
mU6gHLh7JPKWu8QPYWLwF+NRAzqOAENnHZkBEBX3rvapkQhIYdFWBHLhY2Wh9dgL
8cLyhir504HG+JcT5wegeivcMT2YQ/ODRuPqCwUsUEXxjI5caPzyWfsV3d2Y2nI=
=J9Yc
-----END PGP SIGNATURE-----

--------------enigD953513F54FF3AFE747589E6--
