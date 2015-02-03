From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 03 Feb 2015 09:09:55 +0000
Subject: Re: [RFC 5/5] watchdog: sh_mobile: add driver
Message-Id: <20150203090955.GA1500@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
List-Id: <linux-sh.vger.kernel.org>
References: <1422802074-1921-6-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422802074-1921-6-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > Is there a reason to set the counter to 0xfff0 instead of 0xffff ?
> >=20
> > Giving serial console some time to push out FIFOs. But yeah, it is an
> > arbitrary value.
>=20
> 16 cycles as 32.768 kHz would be 488=C2=B5s. Assuming a 115200 serial bau=
d rate=20
> that would allow transmission of a bit less than 6 characters. I wonder i=
f=20
> it's worth it. Shouldn't the restart core code instead flush the serial F=
IFOs=20
> explicitly before calling the restart handler if that behaviour is desire=
d ?

It should, but I didn't check yet. I wanted to when going from RFC to PATCH.


--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU0JBjAAoJEBQN5MwUoCm2tEIP/Rtq9MzvR/85aWBVbi+uexOZ
uHd0VSmVKCBUMgtsLJbziarpwp9/BB/kcIIl6yWZfnxvGI1vsPdoot2rHRJy4gKm
F/UTE/Pn74JkSxSHCiiMo6BxsCIWe/eODYCia4519R4GTm2xTYByZQCj8pVepgsq
XSoJTy4ZuQZyASyEbDClraulu2ZIXR4CLphx6N0OQrNNSovdvz4Kg2cxG8Ad10H+
fiLLXVc9wLBoB2e5kxFz2EdtQAg7bUXiPs7YvUJXoVdKPb1LayLToremIjowYOAa
ST09QDgKNkYAflSPiQEct7yXQYKQOhXIh3hzWWxPH7r2cU+NKG8Acq+hO/hgrcY5
z+NOAPvrS6Wuf0WlyyMvwVxt2PzecaAuDMB1oyUTlWon/sk3TMmTBt/eZeCxB3S7
GfSZAfjTAThJzA0pVDpEegEaHgtSvybuyBCx0lyyPuhb6i3E4FBWoemOlToQChmd
C2T4PU898LvZ7CEXu9N2YLSWx8aTU1eB6gMgpVkgAQq9Gt/rpaG+JyfgCIOvVhnM
YighxmFlefpQaEiQMjiteOOHMz2j3Vw4vZzXG07Qav4JKb7MRFd4VFssoycUHEVk
+OcW6oNc1BjzJyOVlL9PdfRVXu60nnknVSjv/2M80h0qsC4+EbGH1WYfTSrsPh0o
HRbloEbvBYv8lFofDuSb
=AhZJ
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
