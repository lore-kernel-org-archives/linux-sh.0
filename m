Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D7CC433FE
	for <linux-sh@archiver.kernel.org>; Tue,  8 Dec 2020 20:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D63239FD
	for <linux-sh@archiver.kernel.org>; Tue,  8 Dec 2020 20:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgLHUjY (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 8 Dec 2020 15:39:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:56748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgLHUjY (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Tue, 8 Dec 2020 15:39:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CED2EAD26;
        Tue,  8 Dec 2020 18:52:51 +0000 (UTC)
Subject: Re: [PATCH] sh: Fix set but not used warnings with !CONFIG_MMU
To:     Sam Ravnborg <sam@ravnborg.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mike Rapoport <rppt@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20201208182117.163642-1-sam@ravnborg.org>
 <20201208182117.163642-2-sam@ravnborg.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <07774d98-ada5-ecc6-229b-d5a2a60f86ee@suse.de>
Date:   Tue, 8 Dec 2020 19:52:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201208182117.163642-2-sam@ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lKhDewu2fZP8HjR2zeyXNlGk9ZQ1fpt9J"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lKhDewu2fZP8HjR2zeyXNlGk9ZQ1fpt9J
Content-Type: multipart/mixed; boundary="Ie3GU21dNwjjJ57Gkh5MKptsw3mbG7OEJ";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 linux-sh@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>, Lee Jones <lee.jones@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Mike Rapoport <rppt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Message-ID: <07774d98-ada5-ecc6-229b-d5a2a60f86ee@suse.de>
Subject: Re: [PATCH] sh: Fix set but not used warnings with !CONFIG_MMU
References: <20201208182117.163642-1-sam@ravnborg.org>
 <20201208182117.163642-2-sam@ravnborg.org>
In-Reply-To: <20201208182117.163642-2-sam@ravnborg.org>

--Ie3GU21dNwjjJ57Gkh5MKptsw3mbG7OEJ
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 08.12.20 um 19:21 schrieb Sam Ravnborg:
> Building fbdev drivers for sh with W=3D1 produces the following warning=
:
>=20
>      tmiofb.c: In function =E2=80=98tmiofb_remove=E2=80=99:
>      tmiofb.c:805:21: warning: variable =E2=80=98par=E2=80=99 set but n=
ot used
>=20
> This is with allmodconfig and ARCH=3Dsh
>=20
> This boiled down to iounmap() defined as empty for !CONFIG_MMU.
> Fix this by by adding "(void)addr;" to tell the compiler the
> argument to iounmap() should be considered used.
>=20
> v4:
>    - Fix build error of ethernet driver (kernel test robot)
>      Added missing () around macro parameter
>=20
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: kernel test robot <lkp@intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   arch/sh/include/asm/io.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
> index 6d5c6463bc07..45082bcbd9aa 100644
> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -271,7 +271,7 @@ static inline void __iomem *ioremap_prot(phys_addr_=
t offset, unsigned long size,
>   #endif /* CONFIG_HAVE_IOREMAP_PROT */
>  =20
>   #else /* CONFIG_MMU */
> -#define iounmap(addr)		do { } while (0)
> +#define iounmap(addr)		do { (void)(addr); } while (0)
>   #define ioremap(offset, size)	((void __iomem *)(unsigned long)(offset=
))
>   #endif /* CONFIG_MMU */
>  =20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--Ie3GU21dNwjjJ57Gkh5MKptsw3mbG7OEJ--

--lKhDewu2fZP8HjR2zeyXNlGk9ZQ1fpt9J
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/Py4IFAwAAAAAACgkQlh/E3EQov+Av
KBAAr66DDuBRExQ1Cgw3Ic0LjpAuOAve7okt8zI2G1xnbP95x7PHs1u4kjUDYpP3miHYyOKT48FO
PRb23OqafLdQ41GEHaGUOzlxC8EiMMuPkmhNViOKIuMxc0ZvRfIUnd3lzj2bQWygPzMW0niRv/QC
9OGXui4irzsHJJ1ZI4wUgOTuJZPDo3ggc3vjYj9WXBZdX3qRU7x+QyYXXOHF6CRrhdCqIEbEvvhN
Hd/wG8sdBTiijqOjw+SKNHYHND5dZqKDpZJH8YXh2JvQ85QC5KxZDYVCMlVS0zWHO00KDUgZJsYd
BYAV5WaWU5UDFmFmVWGJhiyR+kLxFVojQkERHkU2kBWavdZbc/Yvj8jgInevPPG5x+FvAWzdZPIz
/Id6ikZovJ9MY7qsjwE055hkEFAynDQbcDqzVIzr58tClifAoYxb78gSc3MYTm/rB30y8Hn1PH5P
oTV0TCx1iwuXQPbrWW7vmuNhyK97FrObDjLKrYH3hmZLdNE430gHjoju/S34h0dThfZo9XpBXXmm
PLdq+LFRmAqKDceygBp6jRJRHD1fYxXaQepieiVfDm4frqUC7JUqJdcQRbl3l+Qe2cvg8H5b6tQN
sHvFzOGyTZO7dVS1ciSjN2pT0L7rEzoa2bDgOdEyWmGfAKSDHiVXBd10eCJ9tk+2hFZqy7HAHQVn
r5c=
=TRTT
-----END PGP SIGNATURE-----

--lKhDewu2fZP8HjR2zeyXNlGk9ZQ1fpt9J--
