From: Mark Brown <broonie@kernel.org>
Date: Sat, 29 Mar 2014 10:03:04 +0000
Subject: Re: [PATCH] ASoC: rsnd: use fast_io for bus
Message-Id: <20140329100304.GD21628@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="pQhZXvAqiZgbeUkD"
List-Id: <linux-sh.vger.kernel.org>
References: <1396005659-14557-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1396005659-14557-1-git-send-email-ben.dooks@codethink.co.uk>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 28, 2014 at 11:20:59AM +0000, Ben Dooks wrote:
> The rcar sound driver uses regmap to access registers in various parts
> of the block and uses regmap to manage mappings. The regmap is created
> without fast_io set, which means it locks with a mutex rather than a
> lighter-spinlock.

Applied, thanks.

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNppVAAoJELSic+t+oim9p6cP/1vJiEVTl7fgziAE13y4yS3H
EPsDw4gNfXjGYhjQTnHXE3Vkm9X8TbrALwCEi+OnnEC9r6aPExZPldCst6A3kn81
D+dlAKrdMafLNomddeva6jDFDTFhdqo92xa2g6aAFkFKR3fOppwZ88wejSlU3No9
0fAnXjly8uHe2sidRlZ7NXtnWAsheg8cn6shGSW70K46BRH+JHUGknlPAntJlHrP
YzvakDYWw1feK5IF/AV2G9CCQw8xP73aKHZZ5Z/Sht/BGGyVN70QlqRwj+lAzB/F
A1OZgxaaS+uF7pC59lUKryjm92QgIPYB2XKuVKC/Zgw+oTvTcdQ8kWsv6RAf52it
X2XRHGaeRmudaFgDqMi2EFpEhUKJ0Bj4bnX+xf89lF2Neh0osVBbnSDeJFgZYz5M
Du5zdF62ZrHVBAbXxdYqVgLQbJPvaarw0C/jmxcOZtDSyukcrgTTmmaRFgMPF18N
NcyyXbSx0W42Mwc+AQaXZZRbF9ZtjhU9xtwfRAVpIbvxyJ0gqrtYRC2nOmVFVt4h
1vVzjohbng9FAVYHqZdy9LL9ND1LFKpVSCs8Y5daDY9iRF6ZYtCpBTjSzg0gWh01
A8sB+4B7k+EZ5Ld7pdYtpaQLZsMTAyrYRAG5ZyYDWi/9atECWbeg2cq7PFI0GN7V
h1goZcd+4L88kI0S/yxn
=7u8y
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
