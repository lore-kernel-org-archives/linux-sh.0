From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 01 Mar 2014 13:50:03 +0000
Subject: Re: [PATCH v3 01/20] clk: shmobile: r8a7779: Add clocks support
Message-Id: <20140301135002.GA4307@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
List-Id: <linux-sh.vger.kernel.org>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1393400016-23433-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> +	cpg =3D kzalloc(sizeof(*cpg), GFP_KERNEL);
> +	clks =3D kzalloc(CPG_NUM_CLOCKS * sizeof(*clks), GFP_KERNEL);
> +	if (cpg =3D=3D NULL || clks =3D=3D NULL) {
> +		/* We're leaking memory on purpose, there's no point in cleaning
> +		 * up as the system won't boot anyway.
> +		 */
> +		pr_err("%s: failed to allocate cpg\n", __func__);
> +		return;
> +	}

I have problems with this sloppiness. Writing the comment took probably
the same time as writing the proper exit path :) On the drawback side,
static code checkers will keep reporting this.

> +	cpg->reg =3D of_iomap(np, 0);
> +	if (WARN_ON(cpg->reg =3D=3D NULL))
> +		return;

if (WARN(!cpg->reg, "can't ioremap CPG\n"))

?

> diff --git a/include/linux/clk/shmobile.h b/include/linux/clk/shmobile.h
> index f9bf080..7667f49 100644
> --- a/include/linux/clk/shmobile.h
> +++ b/include/linux/clk/shmobile.h
> @@ -1,7 +1,9 @@
>  /*
>   * Copyright 2013 Ideas On Board SPRL
> + * Copyright 2013 Horms Solutions Ltd.
>   *
>   * Contact: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> + * Contact: Simon Horman <horms@verge.net.au>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -14,6 +16,7 @@
> =20
>  #include <linux/types.h>
> =20
> +void r8a7779_clocks_init(u32 mode);
>  void rcar_gen2_clocks_init(u32 mode);

Shouldn't the init functions be protected by #ifdef CONFIG_ARCH...?

Regards,

   Wolfram


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTEeWKAAoJEBQN5MwUoCm2RpsP/3RqJBOmlgdyVt+FAFhSfEds
k/aEovJgcCzUPfXgK8/gwCybUtb53LFR8TiH6RmDLVMzsoK/RkeodLOtU4Vmfnwe
x4nu8+gBxo4YyCV/i4KMOyFv5pcYatAilf6yx5QYn2aFs0Jl3tPahZ6aa29IzAxr
2H4tdkXW3GBXte9LIYZTixHYtF/jmUcWsU3sTpTd6UAwB6EU4XMUY64mUEyZhLu7
fC5u3f0KAnNLmveY5tz4yOvF4AkIp0L1WRcgZ3DZs3Jd2GMqRGZ0expkSiSWcvWd
xXyJleN/XIcpno2wlK3bpuV9Px2lY6w0r4JTVNWqozu8ppzycxU38PQ0DH+J8uq5
qWtsWo46l4xGUr6BPucKfJBlYWlUm5ykHSXvXwY9gh++nvXhZ0XmXkILAlwCAqCu
cWt/NIDj7wRpWQug6qzcyYTBnlU1MfE/E96Q/uwgvjYwYPvJZHYYEj37i7Fub8TM
FirpqRhbkaN1C+VvgnAP0rxV2W6zQcdUI6A2wcL0mWSwMuzke/C2dVM0iYEgzOF5
3LJ5XwPpqRzg9HeNo0QAC4iX/LXxPKnCjYpxKxf2spegcf8th4og6oFxg78Gni3w
5yoQN5G5rY2QFKlpgPppQGyLgcFCX9wMQSIXLV5jkwzS+2w06Ht/J7oIbOc3Njlm
D3JDZbN+UCJJ6AH44Rhg
=r09N
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
