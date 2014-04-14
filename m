From: Mark Brown <broonie@kernel.org>
Date: Mon, 14 Apr 2014 20:15:52 +0000
Subject: Re: [PATCH v3 2/2] spi: sh-hspi: Do not specifically request shyway_clk clock
Message-Id: <20140414201552.GZ25182@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Fq7EdiloNwzjWdQG"
List-Id: <linux-sh.vger.kernel.org>
References: <1397439698-30123-1-git-send-email-horms+renesas@verge.net.au>
 <1397439698-30123-4-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1397439698-30123-4-git-send-email-horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
To: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--Fq7EdiloNwzjWdQG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2014 at 10:41:38AM +0900, Simon Horman wrote:
> Rather than requesting the shyway_clk call clk_get with
> the device and a NULL con_id.
>=20
> This is in keeping with the way that clk_get() is called
> on other drivers used by Renesas Gen 1 SoCs. And I believe
> it is compatible with supplying clocks via DT, unlike the current code.

Applied, thanks.

> --

I think you were looking for --- there, though I just included
everything in the changelog anyway.

--Fq7EdiloNwzjWdQG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTEH1AAoJELSic+t+oim9XBEP/j/aQ5qUPNRsSBlKoUokrmHT
7myPYjXAYJD+Nzvz3bdQTbL0tIicGPn98WBjp0+/DOOTNlPebqoh3Uxs+wYcqaGX
6N8zCdyR4ZxAx3t8FEixFN522xnw1Xc6NpQOA+kyS5CTDnNJfdO7fG860VuwF3TN
ShVmFQAVqfqqcCEsDnwQnCyHEByDCldaQgXu9tnfvIVvLpfmPj0LharNd0WOUBWc
axHwUyoANApemZqGACiiXXyIfma0xAuc9Te8ewTPauFap22QgleY0NPxV6vq/mUr
5Tllg14Hyn4GoVUTsMJo5W0h5N2PSZoShSl6Nwer8okPsYEE9NtAg+/fMtpr9qTJ
vsr6k+fhShfqmtdkMM80DtDIL6z0CxUEPCYHT+4G8DmNFFkcP2VAgPUT/KY/XDev
IMchkhoRlJ25P9sE4hmkd8HiKmNRIRF8biob/wIgcW+nSulrabEDoSrm5P1TbGGQ
Bm8TZODflgd8AQ8aCo9l4/vekMiDtBmcQW+JMK4S+hdhiriNNUe/AyNr4sGY0xhH
2yAfVR9mKitG/W3XfgJIcpl67VUzzxkRlo04yM7hyvoiGejVLIw9c29iyQOTLAry
LJIbXOh0iXHimWTkHqi4b91aPCtGaj2uIh4CgTVBE4zw+6grKj+tnK+pR+cndsFA
fvbN+PAIWw+uPxUf9ZgA
=WsP4
-----END PGP SIGNATURE-----

--Fq7EdiloNwzjWdQG--
