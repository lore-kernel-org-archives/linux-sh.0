From: Mark Brown <broonie@kernel.org>
Date: Fri, 02 Aug 2013 16:29:07 +0000
Subject: Re: [PATCH] spi: rspi: provide port addresses to dmaengine driver via slave configuration
Message-Id: <20130802162907.GQ9858@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="hz7mcsMzb/4kGyFr"
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1308021500041.28012@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1308021500041.28012@axis700.grange>
To: linux-sh@vger.kernel.org


--hz7mcsMzb/4kGyFr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 02, 2013 at 03:03:42PM +0200, Guennadi Liakhovetski wrote:
> Don't rely on shdma dhaengine driver getting DMA slave addresses from its
> slave configuration. Instead provide those addresses, using a
> dmaengine_slave_config() call.

Applied, thanks.

--hz7mcsMzb/4kGyFr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+95QAAoJELSic+t+oim9lboP/jrW7tELXuPGE4sIibALGNCp
UG3Lwj4WmCpGehZ6k53IfvHBWK22T+av0oXLNAt1f4riKom3DmhtIleWzLk51Et1
VRktoo/btPXkYFsr76cv/UeZE4Wr9wqqQX6/0EdQm8FoxGogg16dyBLTNltn7gzP
o/ttHgqqOsjIlU9PZtXCCuIN5Th65c8O6tYOYzgRabBHxaMJUOzG15lOZgoDnVGt
gO4rtsv7Xy1pSttHiLXnLVKZdU8RuTMdPnAnNFTzcpApIFW0AoeZF0FkaAWC/EdU
BYVk0iflePtmBTD+7r7E8ex/vXMuppWyhpaOhyE9YLv8x6qemtO++3wxZL+933AV
xb8HiUcmTHQWg9F05xNwah6uV4mIFSFRoInYpYSn3XKO7TOPSumev2fmzzHLQAxx
eT0bBBiEe6n2Kf+gtzd3QO29Phoos0zx2Bqo9zTx2j5gnC/LHoVQTKZVneZFzBdh
u7dFD7SecCOHNaKNnD721URytwLPgS7X3gBX0Lm3qHqLwIxf/CkIgu7IkI/Lg6tI
A1x30HoUzUSmbRS8uByaybDmTVV2v59A7ioF3n7Fk86iCyziqq+fo87Kh0mPm8nc
r7P2LMukZMRnOHW1uF/M7l9JBDldc1uacEokmIK5BkiNyiGwsECu4NR0UBDEC3De
35xX3xaD6W/Z+sYYtXTs
=DDJB
-----END PGP SIGNATURE-----

--hz7mcsMzb/4kGyFr--
