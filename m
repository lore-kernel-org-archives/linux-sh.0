From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 27 Dec 2007 19:11:54 +0000
Subject: Re: [PATCH] SH/Dreamcast - add support for GD-Rom device
Message-Id: <200712271411.55677.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1744597.mj4YYZDJtH"
List-Id: <linux-sh.vger.kernel.org>
References: <8b67d60712261726l28960f69u2eb2756a6f5176e1@mail.gmail.com> <20071227081822.GA22693@linux-sh.org>
In-Reply-To: <20071227081822.GA22693@linux-sh.org>
To: Paul Mundt <lethal@linux-sh.org>
Cc: Adrian McMenamin <lkmladrian@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

--nextPart1744597.mj4YYZDJtH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 27 December 2007, Paul Mundt wrote:
> On Thu, Dec 27, 2007 at 01:26:47AM +0000, Adrian McMenamin wrote:
> > +static int gdrom_get_last_session(struct cdrom_device_info *cd_info,
> > struct cdrom_multisession *ms_info) +{
> > +	int fentry, lentry, track, data, tocuse, err;
> > +	kfree(gd.toc);
> > +	gd.toc = kzalloc(sizeof(struct gdromtoc), GFP_KERNEL);
>
> Er, what? The size of this never changes, allocate it once, and just
> overload it every time you step in to this function. There's no reason to
> free it and reallocate every time. Shove it in your probe routine with
> the rest of your kzallocs.

since gd is a global, just dont declare toc as a pointer ...
-mike

--nextPart1744597.mj4YYZDJtH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.8 (GNU/Linux)

iQIcBAABAgAGBQJHc/j7AAoJEEFjO5/oN/WBaD8QALFJnSolyfgpFX7dsk8Bn8pZ
t9FtWWMHvQuUI2m5HNKkQSLkJtFRMk/EWl4YBb1zaRc1+s3Wgxq9GC3NsJo6CgLj
0Q6rmyOI9QJHKygGtUEz2ab0Dv28QY35WkOKN70JwiA1DiIBzG5S3KE7Ih4mst7O
lus0NaCRD3c0Rn6m+IL31gHvhwYE0K+2XLMluM+WTFGx15DBfHlwUQJH+G2AQIXF
vxJlyzIIbEufe5JEVPIP3FKi9hwyjrSNmhUprotfY3O7AbOx8Fw7JseOXmxH/SG4
1+jlJbYm8Uj3Ate01R3/P3Tr6oiiLMUoCepkO8BKPq9PgaNFrD5YqkhKIQgaDok0
NHTR/gOSDuHgiYf7/iXhJs9S01pPqaG2be438SS1W5C6mV8npKYPxN7Q6GSn1BZF
CKvipNn446QrhbfEOqnvETkzEPRnmgk171avApKFpnh/s+Gr8gtj8PBPr+sQ5U/N
ZfX708XUUmYVD3chjtn7cDvxScJIO5IDUg03D5mp+TpD5smjpbUOXRPGLApBRkB1
F1okBqTfflNcqF6AZrZnPuQlY+OceiafXMambMQcOrqCrmGTLU9+FYvM8yV4c2tZ
MZjGRxLWbX2+Ki53ElpNbnaw93neseZwcnkjlTseFPllAb/YV86UDPWjM8okdHso
EDvGuU0nDjOVcwYHZSzn
=hAqC
-----END PGP SIGNATURE-----

--nextPart1744597.mj4YYZDJtH--
