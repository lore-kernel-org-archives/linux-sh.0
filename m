From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 09 Jan 2016 13:16:07 +0000
Subject: Re: [PATCH] soc_camera: cleanup control device on async_unbind
Message-Id: <20160109131607.GA1520@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
List-Id: <linux-sh.vger.kernel.org>
References: <1451911723-10868-1-git-send-email-wsa@the-dreams.de>
 <Pine.LNX.4.64.1601091226440.15612@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1601091226440.15612@axis700.grange>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, linux-media@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Thanks for the patch! From looking at it, I agree, that this looks like a=
=20
> fix, and I even would recommend it for stable, but - at least for that I'=
d=20
> like this patch to actually be tested! At least if someone could try to=
=20
> use the camera after such a unbind / bind cycle. Would you be able to tes=
t=20
> this? Until then I'll just push this for the forthcoming 4.5.

I'll try to get it tested.

Thanks,

   Wolfram


--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWkQgXAAoJEBQN5MwUoCm27pMP/RxmsC0VkAOQPz8N3/Srfcgq
Lc+3bumUT5NlLbelIcNoAx2MVNR8wypbqeA7XuudL0DVCNsfivWdvaTY8aQaRSjF
gsKRs3U4TMasW8i+TyAEE4qVHhfSxWYYGMfkJIJt5QzdQPsYPmOE5d+TV6p6TrBF
k255RlD9SQ7hwupDobIykAMt0LPjttvNh3jFQXcgey9aQW6pBIwGcsLbcbDD9fmd
c9LM9Q72rtn9EtGVS2r/792BuABmHRt45yv83bUVYBW7TfxD7brP6OZj8li4QxXs
kQru/sxjS3/vOL1QfVxfTXFcKNEHF+zSJX2gN5E818jLc65ngGHXlQG6g5uV0A6g
TePyqRBVi6OZiSGFTmUU0oQBkXxGXK0DQ8f3brC12JFa0ZGL+zJO5YtyjZTwxClE
fPXBdZdTsVhC6GQD7HSy67Zlvxkn9Rk5uQopGZTasAfR5fMwwbwGUwxaKQLgAR04
+3DGAZ56zTSIdT0HuIxJoXIVwi5DcfUJW0v1y6AIE7XEuITf796Y8V2FV2X6+21v
9RZzUhWjvoCJwO8rihHRNjGtSQk3sH2opJQJw0lcGgP7kjiRz2/ptJz24yF+EUAy
gITkNDPZqbcbSKKy6ZJEtAPUk3PEjkg49REwDwo32mmfpI2lFdIdMBuTNfYGF0GA
iSv0QuaqgujUxc914MG/
=J3l4
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
