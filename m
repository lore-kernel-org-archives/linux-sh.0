From: Mark Brown <broonie@kernel.org>
Date: Mon, 31 Mar 2014 10:18:27 +0000
Subject: Re: [PATCH] ASoC: rsnd: fix src clock prepare/unprepare
Message-Id: <20140331101827.GM2269@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="QeIEYJGnsH0eC7HY"
List-Id: <linux-sh.vger.kernel.org>
References: <1396018997-12390-1-git-send-email-ben.dooks@codethink.co.uk>
 <20140329101043.GF21628@sirena.org.uk>
 <53381DE2.9050907@codethink.co.uk>
 <20140330222433.GJ2269@sirena.org.uk>
 <53393DEC.9060400@codethink.co.uk>
In-Reply-To: <53393DEC.9060400@codethink.co.uk>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk


--QeIEYJGnsH0eC7HY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 31, 2014 at 11:05:32AM +0100, Ben Dooks wrote:
> On 30/03/14 23:24, Mark Brown wrote:

> >It would be easier to tell what you are talking about if you were to
> >quote some context from what you are replying to...  I'm guessing this
> >is the file that doesn't exist, the above path not present in linux-next
> >so I don't know what you mean by my "current development branch".  Are
> >you *sure* you're not using Linus' tree?

> Why would I be using Linus' tree, it just /does not work/ at all.

> I used your sound.git tree to work on due to the number of patches
> that where there.

My git tree has many branches, which were you using?  I'm pretty sure it
was neither the rcar topic branch nor for-next.

--QeIEYJGnsH0eC7HY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOUDwAAoJELSic+t+oim9kGIP/2j+4OyUyAPSjRPb9Zqc19SA
Y7WRGjIzoc0SX9nSlVPt8An9TOE2mtUVinfG2MzqJ+4VOvxYUELzN60Ig7c0af8f
sFK8qCB6EoAc8WghLJtJDV/MTz8o9GuyLkwqNJH6qodgGFJ1Akn2dpoVk4It+D8M
EVf4DWDv0pKW99+ANgCuWgikIi3oUwuZOUXho4k7QmnDC9WVLxp3UqhpLdRWUN4U
i0rTx+N4iO1I/xkWzacnKmfExLjOXqmE81cGbrvgG0uhzhrsUCxAEb9G4ZPk7MCA
XozNa5T63Nhhcho8xq3RzgBhrJ2EBwo5tOpjZtBS6hxW2VCfqqaMagggilmo121b
KI6F2FUY/DSzfjnkNUYqnsqmN62G0XN+/S7ZoiA2A9kKnG32RwGJPFRtqEYym/OS
vqR31PfggQcrtw+2Uo+YaKLXSOIO/3rfBcYmh1J2wtEds6eX6jaRKfZKzxzus8XK
TVWCwojLajYINE7OdyNSwX96REEYZIGC9ZD97qydEmdjnEIuEfJgNs0OhIx+elOL
svmh52SdEdAkhp7msYZNTxxn/kjt5AOKl0jf9RH5R3+oSZbO/m7jxmOYZlFTwOw8
0QerqfBym6A/lEmkYML+wKK51ahxCxrhfSpXFhAOoCfCN+zJOohcFn+waKg3aZ1M
9KQLNbOv5TYna4ucb9/H
=mJNq
-----END PGP SIGNATURE-----

--QeIEYJGnsH0eC7HY--
