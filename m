From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 17 Dec 2013 21:04:03 +0000
Subject: Re: [PATCH 02/05 v2] pinctrl: sh-pfc: r7s72100 base support
Message-Id: <20131217210403.GA1196@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
List-Id: <linux-sh.vger.kernel.org>
References: <20131217023745.24573.3660.sendpatchset@w520>
 <20131217023804.24573.82351.sendpatchset@w520>
In-Reply-To: <20131217023804.24573.82351.sendpatchset@w520>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, linux-sh@vger.kernel.org, horms@verge.net.au, laurent.pinchart@ideasonboard.com


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> +#define _P_DATA(bank, pin, name, sfx)					\
> +	PINMUX_DATA(name##_DATA, name##_PMC_0, name##_PIPC_0,		\
> +		    name##_PIBC_1, name##_PBDC_1)
> +
> +#define _P_FN(n, fn, pfcae, pfce, pfc)					\
> +	PINMUX_DATA(n##_MARK_FN##fn, n##_PMC_1,	n##_PIPC_1,		\
> +		    n##_PFCAE_##pfcae, n##_PFCE_##pfce, n##_PFC_##pfc)

I need to apply this patch, otherwise my i2c pinmuxing fails?

diff --git a/drivers/pinctrl/sh-pfc/pfc-r7s72100.c b/drivers/pinctrl/sh-pfc=
/pfc-r7s72100.c
index 4acdaae..2b716d1 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r7s72100.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r7s72100.c
@@ -68,11 +68,11 @@ enum {
 #define _P_GPIO(bank, _pin, _name, sfx) _GP_GPIO(16, bank, _pin, _name, sf=
x)
=20
 #define _P_DATA(bank, pin, name, sfx)					\
-	PINMUX_DATA(name##_DATA, name##_PMC_0, name##_PIPC_0,		\
+	PINMUX_DATA(name##_DATA, name##_PMC_0,		\
 		    name##_PIBC_1, name##_PBDC_1)
=20
 #define _P_FN(n, fn, pfcae, pfce, pfc)					\
-	PINMUX_DATA(n##_MARK_FN##fn, n##_PMC_1,	n##_PIPC_1,		\
+	PINMUX_DATA(n##_MARK_FN##fn, n##_PMC_1,		\
 		    n##_PFCAE_##pfcae, n##_PFCE_##pfce, n##_PFC_##pfc)
=20
 #define _P_MARK_FN1(bank, pin, name, sfx) _P_FN(name, 1, 0, 0, 0)


--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSsLxDAAoJEBQN5MwUoCm2+DUQAIYFAnm7vt7v0uKtidXTc8m0
OWtY20WYsZg2Hbg0/hjAmSxjDvTulORIssZH0a4F7hR4GoJhXOfB54AinowZ7eT4
3Y2aJyiy8uvCgz5t6FNGJz1hkaqLHiwyc1kpcpL7ulKHnKdb6NQ5/1GVdtMEs8C4
Y0UFughMS2LYSnlYM4f22vWtohwiY/UcFKz8ocnJ9zDmvoem4l1FhKztaQb9amtx
+hRkW24hgFCGt2yu/t/LXSyoH8FRk5Y7rLn8QQ5/yJNjYZbVDyfmvsMS9l6THlE3
LKYZRCd3gk2hTpSZ6Q7TB1j3fJTf1Lw8xn0FWlEc22EUQRpYiBhnbq18JFQAhhmo
tU3tlL0RHmQ9ul0nC/Q/aROORYERUZaCzq5bO0rkSAWi02YLrXfPbqq+HdAMWqnG
miikT7kJu9BHW5iqS4Xqft8uB2yv6hrptd6KmCpnp7S8wfZw99sNZrIXUA4u64zH
SHWf8DAdLOQhUrD4Ob0Glz34dNDIpcqlV0LLTpkcJQj5VExD3R+MTwJyyNUZyPHJ
SSl6HUKMchzNOWm1mhRKYotI2qdaYscvZTHKBz1k3hopU68EAicFGu59CPo7lZg7
UB9Vp8lofWeAVsslRT1QgykLlr/nvy4YSP06nL1QoYweC73WxsRVrggUZ6mdC8/U
x5cW89uHrNcDM9QwWsth
=j+DW
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
