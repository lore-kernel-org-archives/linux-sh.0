From: Mark Brown <broonie@kernel.org>
Date: Thu, 12 Jun 2014 11:12:51 +0000
Subject: Re: [alsa-devel] "ak" vs "asahi-kasei"
Message-Id: <20140612111251.GW5099@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gZp/6GhZa3TIWvVc"
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWTVBjFzA9L9Eqpq_2Xi9_NHkOCLrb_UjK611SBfwnc=Q@mail.gmail.com>
 <87ioo7c0g5.wl%kuninori.morimoto.gx@renesas.com>
 <539815E6.2050304@codethink.co.uk>
 <20140611165410.GK5099@sirena.org.uk>
 <CAMuHMdUT0hEBGbN+W-Oz5zJ0N8S2VDMndqtDO=EtWF3jG2MEew@mail.gmail.com>
 <20140611170233.GL5099@sirena.org.uk>
 <5398A53D.3020706@wwwdotorg.org>
 <20140611190444.GN5099@sirena.org.uk>
 <5398AB07.4040304@wwwdotorg.org>
In-Reply-To: <5398AB07.4040304@wwwdotorg.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>


--gZp/6GhZa3TIWvVc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 11, 2014 at 01:16:23PM -0600, Stephen Warren wrote:

> As far as DTs go, there are only 2 users of asahi-kasei, and they were
> both added well after the prefix was documented, so those seem like
> plain old bugs.

> But due to ABIness, perhaps we have to support both ak and asahi-kasei.
> I don't think fixing this implies we should introduce a third option akm
> though. No DT is using that today.

See my prior comments about how fetching pink with yellow spots would be :)

--gZp/6GhZa3TIWvVc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTmYswAAoJELSic+t+oim9ZAcQAJQECSHh3R3TbLPF+iL7uIo0
LXXl4tfi5jHZQWCyCwy/hGl6nM4pnJC6oTsHwLDK1GNk53Vk+S4j19W+qsNc3Rs+
OrgUgfy7meO89S0GwUdmiuegi6mk2Zf2CC2FGQoLOy+gbRYFwv+BMsP7Sknq5a/W
AEmy9+LMNRhMVf7tk0L0oVVeZg2M42JXoKfmkeEMFxjCUDXg3wfx2SoQy8nsSxkB
VhcU1ljDNwvcwx2iTYdcn/iiQ+EDLpo/jor5Fku5vNPYXW0kcUgDLJCDd51hbMFs
3hRSaWxB97srYf2XZciH3HufulHcDuFmKQvfZt4RL9mtRB+jwFurd2tEyW8CrVwY
K+zJEbnsJmS3jOQImE0r1iAkHVC55tXe+qd4ArN1H8cQwfTexeCmp6lChxbh/AZB
fMYCWfjH2rCn7KcFKQ2OxHesUATmGJaah+tg2QoYoLQm3epSUqZv8RbzeAaZYOcN
iXRVZdJOdJDl5VaGmoGIIF314DQZ4IUff1BYbHekymC4f39mbi0LEVsEcOhS5Vkz
OXw1hC2sdIjswbFY/gpVWwEZEibta9IlJtw98B+rntBw4U3oSQZ3n/a/RWhHblyf
htsNHxKm+IDrtvd8A+3jeiWiBV7xslTCSTcuqLKIVcy/XSZ0xN4mYuDuv2vgyofq
+OlaB/vBbrqoN54OwShU
=Lmbw
-----END PGP SIGNATURE-----

--gZp/6GhZa3TIWvVc--
