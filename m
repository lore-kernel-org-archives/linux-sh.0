From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 27 Mar 2014 20:07:00 +0000
Subject: Re: [RFC] Serial port aliases in DT
Message-Id: <20140327200700.GA2585@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
List-Id: <linux-sh.vger.kernel.org>
References: <5448979.WQPtOb56tW@avalon>
 <CAL_Jsq+SWZUz4D+3pdDs5yfi_XbTODC0ytt1S5KpmR_C5vVL=A@mail.gmail.com>
 <20140327151829.GX17250@pengutronix.de>
 <4966076.uASvrV0Iy2@wuerfel>
In-Reply-To: <4966076.uASvrV0Iy2@wuerfel>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I disagree with this one: the aliases should be a board specific
> property, if not settable in the boot loader. This is how it traditionally
> work on OF, and I think it's the most sensible approach for end users:
> If the machine has multiple serial ports coming out the back, they are
> normally numbered in some way, and the numbers should match what you
> see in the OS, regardless of what the SoC calls them.

I agree with this one, makes sense. It calls for quite some cleanup,
though:

$ grep aliases arch/arm/boot/dts/*.dtsi | wc -l
79


--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTNITkAAoJEBQN5MwUoCm2ktoP/A655wsbqjbhsmnV/q5uzx7z
qUr2SLFsJMnnREYwIN5uy81wNwpOlYOijJu3uwpi9l9UR/22iEPzNr7Z7HpYRRMP
CkLqACmBZJl1C7ZWfnMWEwrJwBpNMNVbCBiaEVjEiRtfMAEefvcF6CHBc8rs7mry
Uu9d9VdAfnJACsnrIIw2cuRPWuiaf9UQ9mxPO6M7Ezy3O9L84tlcoZkBRk6sbaFQ
rfFpqETt8VGRdkjZR4hOeQ75ZmNHODjDqrSct6eXAgYBDMvknm9/d9YiL6iWX5+Y
TJip7BbqZx18ylkR/nlegSRMKxZkXpkX/ntB4c3i0PjU5G4QaLULDY88F1z+lmXb
EwhwHK8BrlHDHlu91sZvBxKY1rF73QI1DFFq5vASZtfApEpy9zQovS1Yb9H+Qjv/
nOR6o+NPZk4QZq+YZUMYzFeVzjk626jCn3n5DjErG4EGy5tkDOYB8G8zrZq/cNKX
TuUYgBZzab2NqdxKM1bXdt5iOrjn/SYe3BvCxJ5TYzvvpzU6INMwPY8tSC804tdX
DKu80+8b9ewWTX4kI7HXQ9+oBOOL0I7fYSGXQuGHhnHqmPAUECyG56VKUL2Qf2QL
6/yRsE6bqXXEnECPzxpEtlGgSOWcABI77DLEggQCusuhziCSKJxQNUl8raENmhlX
eL/joHmXpRRoHoLvUlFb
=pDoQ
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
