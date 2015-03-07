From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 07 Mar 2015 10:33:49 +0000
Subject: Re: [PATCH/RFC] i2c: rcar: Fix order of restart and clear status
Message-Id: <20150307103349.GA1194@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
List-Id: <linux-sh.vger.kernel.org>
References: <1424011396-3492-1-git-send-email-ykaneko0929@gmail.com>
 <b0a6dd2b593f2f891946ef910c876b48@the-dreams.de>
 <20150304040819.GB12776@verge.net.au>
 <20150306220531.GA6572@katana>
In-Reply-To: <20150306220531.GA6572@katana>
To: Simon Horman <horms@verge.net.au>
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-i2c@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2015 at 11:05:31PM +0100, Wolfram Sang wrote:
>=20
> > I asked Kataoka-san about this and his response was as follows:
>=20
> Thanks, Simon!
>=20
> > If system(CPU) is busy, the driver can't clear the status register soon
> > after kicking start.
> >=20
> > If sequence of first start is as follows, there is a problem.
> > Because H/W starts by 1.
> > But sequence of re-start is as follows, there is no problem.
> > Because H/W starts by 2.
> >=20
> >   1. Issue START condition by ESG bit of ICMCR register.
> >                   <--- If there is too much time, H/W finish transmitti=
ng
> >                        and set status in status register.
> >   2. Clear interrupt status (ICMSR).
> >   3. Open interrupt mask.
> >   4. Wait interrupt.
> >                   <--- If status is cleared, interrupt does not occur.
>=20
> I understand. I'll add this explanation to the patch and apply it soon.

Sorry, another question came up while applying:

How can this interruption happen? The function is called in a
spin_lock_irqsave protected area. Is this an RT_PREEMPT related issue?
Am I missing something?


--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU+tQNAAoJEBQN5MwUoCm2I+UP/2n8b6yQcitFz97Xk39vJZA8
eMBeREhHp7GJjmDa9nJ2yfFSpV4Ke0mHktBXaZoEzgI5sUpbkVaeQZqPDCCrKl1t
hzTGPoLVo/wpanwCLNGkMxmky5T5U/Km9ArLYP1FTcmaDAAOebnZDmNHEqA+2go4
+yyScvzJ3H+rTImQm5PPoTCNmIAG9vS+Ak6C9oktZEgRQzycIi0WayLiN1Cqyh66
hRaNlzHhp/4xN0ze70qozSc0JFaciX0n9Gfn89Nq/GE2wQu93gQyUj07ro4zXhAb
aHWHeICOlq7odD5b419Ih/VeSfc4hOj2W2I05TD7Uqa1nWdcwt/1mQmYrmh7fh7i
B6fhekaW2ttsOO8buNdQR6cUCB03bsGK/R72IBe2vxzrdOgkV9nm9xBjQMmdgPV6
VxbvlTK7NcEFZTJIlFvViDWhev4BIFu+QExwiUzILF+HcPaoTBL+VfPeBjbdicDy
Knb/HIXulZntOO5PAz6UaHVQf0eI8q35GXoOBIO2NUAifZM32MQZlzuwXZwdA55n
261BEvfOv7W7gOm8LdM8Q0WBHdQOhRlQcahLI+ayInnLrzSBXShGguUEbliNgQz7
5ImunN1ZL2g1mMOZ2nhWXeRQ1RTkYje8BHf93K2kcEbLYQShNaakZjkNc2WKR5lk
e7GyAWDbPEPS96B2/qiz
=F4JD
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
