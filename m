From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 23 Apr 2015 12:51:26 +0000
Subject: Re: [PATCH] kernfs: remove outdated and confusing comment
Message-Id: <20150423125125.GB19918@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="oLBj+sq0vYjzfsbl"
List-Id: <linux-sh.vger.kernel.org>
References: <1426069565-7933-1-git-send-email-wsa@the-dreams.de>
 <20150311114531.GB25944@htj.duckdns.org>
In-Reply-To: <20150311114531.GB25944@htj.duckdns.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2015 at 07:45:31AM -0400, Tejun Heo wrote:
> On Wed, Mar 11, 2015 at 11:26:02AM +0100, Wolfram Sang wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >=20
> > Grabbing the parent is not happening anymore since 2010 (e72ceb8ccac5f7
> > "sysfs: Remove sysfs_get/put_active_two"). Remove this confusing
> > comment.
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Acked-by: Tejun Heo <tj@kernel.org>

So, how does it go in? gkh? akpm?

Thanks,

   Wolfram


--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVOOrNAAoJEBQN5MwUoCm2EhgP/3+yv9/0aaysex9XQ/yYkfP2
VMz8wOYK3AXsP4PHo4AXd/RbrwLtqyM29/N/hgidgz0dJJdlzFOpd7l1KIj3ZGem
QVYJ5LXoqoCOE3REy3V+WTUVO7y1ju/EbU+p6VJsAf4Q1Q2W84sruD2FC6/3DBxV
wxXejZnPxViZjrvPGy66Os+SvTJD8p/D2ltgZIohit25KbrcVALalHL4RK0R16rW
mCcHVcyBgV6wYv1V3GfRdYn94z5nEp2/rAN9Iu3pLmIZ+V/MA/EW+OzTxOSA5xhk
8zLfiUXEf0gah4Wzho/TuUliuYRwoe9KSs88jIte6S8bhT5k1DrZy6u01g9AS8u1
S4O1660ZMVTOGSpl3qnxOHXEY+CktyIoJdNCIjaI+I9WpSVKR2Z522i2blK/cWXG
WLFD0383hw9/nFxPDB4jh+nYw35NauqDaAXDTFiHqEkhvIKrsGmKdU4OMjnCVy3/
2sDOz+lvk/NKhiOFDZ5JRbq25RuY+Elr4LE32iYT08uhQmwBNsNWPgvKU3wrnN3G
hmiNgMAlX8sr91czY1CsqmTe4KwwSyPvanvd739RL86ibEvRSNzs8V4KUfmuz4zv
BTjSdFJdqGAXteQg8bctFkJh/1ZtX1ALjjcootGyOb1DC4FHfP1I7pPhHqSSiL1/
lvPB++9Rfl8PWPZrZvUJ
=Fogf
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
