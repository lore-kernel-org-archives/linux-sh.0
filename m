From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 06 Mar 2015 22:05:31 +0000
Subject: Re: [PATCH/RFC] i2c: rcar: Fix order of restart and clear status
Message-Id: <20150306220531.GA6572@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
List-Id: <linux-sh.vger.kernel.org>
References: <1424011396-3492-1-git-send-email-ykaneko0929@gmail.com>
 <b0a6dd2b593f2f891946ef910c876b48@the-dreams.de>
 <20150304040819.GB12776@verge.net.au>
In-Reply-To: <20150304040819.GB12776@verge.net.au>
To: Simon Horman <horms@verge.net.au>
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-i2c@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I asked Kataoka-san about this and his response was as follows:

Thanks, Simon!

> If system(CPU) is busy, the driver can't clear the status register soon
> after kicking start.
>=20
> If sequence of first start is as follows, there is a problem.
> Because H/W starts by 1.
> But sequence of re-start is as follows, there is no problem.
> Because H/W starts by 2.
>=20
>   1. Issue START condition by ESG bit of ICMCR register.
>                   <--- If there is too much time, H/W finish transmitting
>                        and set status in status register.
>   2. Clear interrupt status (ICMSR).
>   3. Open interrupt mask.
>   4. Wait interrupt.
>                   <--- If status is cleared, interrupt does not occur.

I understand. I'll add this explanation to the patch and apply it soon.


--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU+iSrAAoJEBQN5MwUoCm2NYIP/jD/F4+ibWcVxTlhgrnDROBN
Bah6XoAvdFgU1sWUeaHSiI9s0uhMoXHTn7c1dGlDiPrTgyBD45EdFsVaahKPulwQ
gfSTa/RvUCy5/+IrLRVKPWs4kqsCJwCr7SVQASWAHa3F3iRuxp9/YlaJBQkLpJjA
8dJjmCfqNMihny+DhuAgQczFTCY3oTdo1VRgaxnEnQKUtks22WRmuvDUhSWNF0zz
y1rkKWbUZxaVeg/BCkBU2jHIw28Hsp+RWLGSDqCcfukgItUtgQ0J9TWEXw0Jx3Sq
9euSzQ85D3eWvqcme1J+DykvSM5JBUjkpfEzmLr2LhzDiiPr1niEac3UEb2E9YER
W490G7caz/uhi4p8vJ1e7yguAz5/MNJ3yz0ZQs6A3Nbfysl49Dhse9/pkU8B4Vdo
rvVaSVCr/NR+r43bxtBvVUOFvZGl93ZxxBFpt6vGgvkTxd9yNr68Lj/OjMg+mlIQ
yLKshjFfF4tBsd1f1bQrPTEEB0RboyWtFl/MjtAwO2H5VBKY2vnT34/5wiXrufNE
Cxj8wnp1f4VI1jPWscZEvO6+bl4iWcK6+QZsfnk2tMGhZvaCzy1D7YJwTtGdJPU8
iKkS2L48LTV4D+9pR8T99lV+QjjqSb8PjSzFiuF4scFk3HtU8zj5erLbZhpqmmbj
fyQYtlZ4VOvVvYNaLOIK
=E2vm
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
