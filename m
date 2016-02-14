From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 14 Feb 2016 19:20:58 +0000
Subject: Re: [PATCH 2/2] i2c-tools: i2ctransfer: clean up allocated resources
Message-Id: <20160214192057.GB1522@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OwLcNYc0lM97+oe1"
List-Id: <linux-sh.vger.kernel.org>
References: <1434710432-4182-1-git-send-email-wsa@the-dreams.de>
 <1434710432-4182-3-git-send-email-wsa@the-dreams.de>
 <20150911111218.319b0c23@endymion.delvare>
In-Reply-To: <20150911111218.319b0c23@endymion.delvare>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +	for (i =3D 0; i < I2C_RDRW_IOCTL_MAX_MSGS; i++)
> > +		msgs[i].buf =3D NULL;
> > +
>=20
> If you explicitly set "buf =3D NULL" for zero-length messages in the
> state machine as recommended in my review of the previous patch, this
> is no longer needed.

It is as stated in my previous mail.

We should really play safe here. If we optimize too much, the cleanup
loops become fragile (I tried some options) and one easily misses a
case. Cleaning up is hard, we know that from Linux drivers.

(For me, this is still a good example how letting the OS free memory can
actually prevent bugs. But I give in already ;))


--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWwNOZAAoJEBQN5MwUoCm2aDcQAKD1dWyBCEvp/lZ6VpdzpebA
zv8y1LH9H3RQ5OeFPRZNwOiV5yBShGP/zm4kssAA3650JfKM1r8KlrkHgngMbqr+
famTHepZEC03Z0IV2+k97n7/aGVnCqd5lbsvfvdgnBfhDU+vBvzjdd9yxJHhjnYq
pOhTAtgxoDfGzFWoahuyouBxPO62Zz7p4VdIHJOOjwJfHB0mVdUBiCpAFngPBbEh
SEQyFK39tM4V+0uAEu21CVZdu5nIJQt+ZZcuuIv02SxWpvSbiY+1ZxWT4DTMfua0
qg2/h0CAPc5lzb8lABX6lRyNp6RiA9zuDkvAF1ne1oN9R1otgQZyvrzeZwQSz5Oj
U69XY40na8tllpmQw5k+UIpcan23NkGEk9SDh0uvExKVQSDIRYF7GF/fOTMQPK8N
3vz2P1GOYR6opmZu8uTAp64BShVFP3G6QKnh7V3Cv6CKckgCJfV47evIJo+NmC/8
L3qSsgZcPKa5qsNKnXhhlOcGu/LYoJnsnRvWggY+eLyoE4t4RRnwZQQ4OHk1XnFU
5Abbh7RJeju4OqyGn9RKbrB12qcM8bunxGvOzygSD/5jtfQ6iN8Cw05MZGZS5Ym0
pr2FxTAEpUoeYWP4MVdk3RBVfupTVvZZKhtHPR5JwmX+HXchNl3p6h7ooQcCeVUn
XVCKxhpRmuzphVOy1xB3
=zkwT
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
