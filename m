From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 25 Mar 2014 16:31:38 +0000
Subject: Re: [PATCH 0/5] ARM: shmobile: r8a7790: enable IIC(B) cores
Message-Id: <20140325163137.GD6374@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="IDYEmSnFhs3mNXr+"
List-Id: <linux-sh.vger.kernel.org>
References: <1394573078-20767-1-git-send-email-wsa@the-dreams.de>
 <2570845.PngjMN9sWk@avalon>
In-Reply-To: <2570845.PngjMN9sWk@avalon>
To: linux-arm-kernel@lists.infradead.org


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > This series allows r8a7790 boards to use the alternative IIC(B) control=
ler
> > handled by the i2c-sh_mobile driver. Since both i2c cores always use the
> > same pins only in a different function group, you can easily use this or
> > that core for your devices. For that reason, there is currently no
> > enablement on the Lager board, since it needs discussion which core we =
want
> > to have on which bus. sh_mobile seems more stable currently, so I'd vote
> > for that.
>=20
> Do you have a short list of pros and cons from a hardware point of view ?

iic has DMA capability for which we don't have software support yet.
Other than that, I guess it is just details and I haven't looked that deep
into the datasheets yet. That might be coming after this DT enablement.


--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTMa9pAAoJEBQN5MwUoCm2FM4P+gPiQ7D4dhTv+G+j2OybN6q+
lYoV63jqyFdmSoONKLvyzFmLK5LxtYBLSyp6tYpf8z9/nQloCoXEefGz2b50FbIg
7idzaQ9iDZvrDyFoTMmvXgPyqmckp8ZGZIjkPFSDeLThhHIWcLv1ELaRuLr6Trkn
J7th1JDXHdjW+aVdU/GHw0eyHTIe6nCGU+6yg8h5I/fdtoZy9Rg4xXJI4dO/JXe3
s6HWtvC4M2j0p0N5p0QS/7AAM4fhkm+h9DSn7wq3Z+BvXRX4kRZAAUu7QWZysgUT
NW2HkqCBkD3IxwLpFfrKiIGqF5TRea5drt85aaeJ4WRKgndFP8k+H6uQhk91ZLx/
Ylq3MsZhB4TWJ5RO/ygBcKLPHWM9YscqKx1yBjm5ba9vo9m6X0I9yPphPZdvUVMd
2amrkRKyisYXGuZ5zDxpZaTD7Yw5x65V4LuOygIcJ84Xr4zWa/SH+GKizp+1JhI4
aajMrbAGm5cvy54bsb4/1HwpKnCy4gBjm6gApw7TemRkkToruGZvkkyobjXAMQ5z
ccwYtAJpbhEFSkZDRYwBmpRq9oYUQy1ffAjIf6JjOLFROmahB6gk8DS7Jmu70o+L
FGyjdimw7n/ukB0fRerLOV4AQhkCCbg/yE2mLPyVhQ10e27HpnntWlcriHXH9b0g
Unqv72k3JljAmtlVD2GZ
=3HwH
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
