From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 08 Jan 2008 05:57:21 +0000
Subject: Re: Busybox and automatic module loading
Message-Id: <200801080057.22296.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart19066624.N4nUu6seTS"
List-Id: <linux-sh.vger.kernel.org>
References: <1199495386.12780.3.camel@localhost.localdomain>
In-Reply-To: <1199495386.12780.3.camel@localhost.localdomain>
To: linux-sh@vger.kernel.org

--nextPart19066624.N4nUu6seTS
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 04 January 2008, Adrian McMenamin wrote:
> I am struggling to get alsa (userland) to work on my Dreamcast - the
> kernel side works nicely when using oss emulation but I cannot get the
> pure alsa stuff - which relies on the alsa-lib - to work at all.
>
> I *think* this is due to not being able to configure the modules
> automatically and I cannot figureout any way to get Busybox to do this -
> eg neither /etc/modules or /etc/modules.conf appear to be handled.
>
> I suppose I could hack the init in some way to fix this, but I wonder if
> someone here has had this problem and knows how to get round it?

you still having troubles with the userspace alsa stuff ?
-mike

--nextPart19066624.N4nUu6seTS
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.8 (GNU/Linux)

iQIcBAABAgAGBQJHgxDCAAoJEEFjO5/oN/WBNcUP/j72aLjlpqq7ku4nqZwxM18/
vqM8GQmsKoHFRReOqd+epo8lWm8Vw1aLFbHqVvJCJ8yi5ITQqfqVrpH9f8yxVcHh
w8/IQlsNy2y1MDJTL4TozxaebnabzF9OsDeP4/yYF298srPaD/03xj8PyWnO9HdC
UeAD4quRACmue3HxR2rrGviv9y/9Jv4S918C8v2zxf2PlL52CRBlRZ6eA+VvsqJq
ftXmhfzO0jyLvo8y8H0mFkVLCXtvpOPAeEJSH6ehITFtyC1f2DaIJA1F+ctnjiGs
6BCC9a2Mf5PRhpy6WLFy53Vjx9tnmz2qKs+TWg5231C9DM7Kcm8/x6/4bXR0Z9ou
uCCRJlos4wiPKLiUcJxfhMhLfp3RNYHLrT2R7voKsw5aRomJB/BWdaBw+tkpFYlU
g/i2x0UQWzwWk620g/29PRNv0Cc7TtTlzAYEUKNj4JJRAmd/FNNcZgRCsbX2PZUb
bJTLiNUyDNY55KrtMP5maKtAMSY5QyaNTa5t+fhbgzy40qfHByEaUen1vGHKzz+e
BZ7/yBYG+BUPrtNycO++T6zcNRNc/JrtP+DKMyTIB5thtiTYpYq2ZmK35buZLrgV
v5T5KFzM3dSU7gyXzrPAwX18V8nsdWADvwleODIFpHH57pThl4qGSD2hl7SOrWPf
paoMdktvroohXSqpH3kX
=xKwM
-----END PGP SIGNATURE-----

--nextPart19066624.N4nUu6seTS--
