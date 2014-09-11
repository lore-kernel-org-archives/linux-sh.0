From: Marc Dietrich <marvin24@gmx.de>
Date: Thu, 11 Sep 2014 14:52:22 +0000
Subject: Re: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
Message-Id: <1591383.Xdy91rktuP@fb07-iapwap2>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart6151357.4VKUoaRBI6"
List-Id: <linux-sh.vger.kernel.org>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <20140911141257.GC5149@katana> <20140911144003.GD5149@katana>
In-Reply-To: <20140911144003.GD5149@katana>
To: linux-arm-kernel@lists.infradead.org


--nextPart6151357.4VKUoaRBI6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Am Donnerstag, 11. September 2014, 16:40:04 schrieb Wolfram Sang:
> > b) could be seen as a configuration thing since the functionality
> > backend could be changed at runtime even.
> 
> Come to think of it, not only the functionality, also the address can be
> changed at runtime. This makes me think it should really not be in DT
> after all.

even worse, there can be multiple masters and slaves changing their role on 
the fly AFAIK. So the best dt can do is to provide an initial configuration, 
so all drivers know where they are and where to start. Everything else can be 
changed during runtime.

> People will probably find out that it is possible to put it in DT, but
> it should not be encouraged and they should do it on their own risk.

--nextPart6151357.4VKUoaRBI6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJUEbcmAAoJEKyeR39HFBtoUJAH/2VkYCMJ+aDlPXoWbktY2AHP
xHbstyCIzfj7kdVl8G4BRmuAbkSzoSGtm/apwz6zQOv0YjwaxUw32gaO6/E3srVT
qEzCTqg7gyvvhenOQY2OWXJvM9inwBPQzuB8DRVtRTbO8kJtyk7YCBhaKURc6xyf
pqyhLjuJrwRuAxxF1hd3fur3uvtop11LFNbv5hxybGWyRRosO38h0vaHfLpKSqSD
RjqV7NfjxoQ8sk25IAghwRquO+YeaItJ1fWcmcaOLGj/ID27X54SHq2vYGVkqMN2
n9+CZ6n795dxd1tj1WQnIVl3CCd/0xcS5QAfmMgVKQ7sgfJB6AX/ElX6BxJf3u0=
=3/oV
-----END PGP SIGNATURE-----

--nextPart6151357.4VKUoaRBI6--

