From: Mark Brown <broonie@kernel.org>
Date: Thu, 21 May 2015 10:59:05 +0000
Subject: Re: [PATCH 3/4 v2] ASoC: rsnd: add rsnd_dai_stream_quit()
Message-Id: <20150521105905.GU21577@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="QXliVHAuIB9eJ4yJ"
List-Id: <linux-sh.vger.kernel.org>
References: <878ucitwyh.wl%kuninori.morimoto.gx@renesas.com>
 <874mn6twui.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874mn6twui.wl%kuninori.morimoto.gx@renesas.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Simon <horms@verge.net.au>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, sakato <ryusuke.sakato.bx@renesas.com>, dmaengine@vger.kernel.org


--QXliVHAuIB9eJ4yJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2015 at 03:49:54AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current Renesas R-Car sound driver calls rsnd_dai_stream_init() when
> start, but it didn't call paired function. This patch adds
> rsnd_dai_stream_quit() for it. This is prepare for interrupt error
> status check feature support.

Applied, thanks.

--QXliVHAuIB9eJ4yJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXbp4AAoJECTWi3JdVIfQYakH/3MWnJKAhR/0/c9shpHV8hPr
OK8NXP341OmqVzro0NaOZN7EZEFsrfGHpFh+fC5MxW26kIoMuaKjU+pP+DnZFKOP
G7Cq+Qc1Xo3yX4Mee8Ckrp43uaKnXpCJR9sTZrRei13JMUBPsKgdKIAT1CmK4inh
0vJ/93hZkGlKiI+YcL+suSefvAUebNdqvarjwjsD2pZkjdYNOKmFtgyj3rohYMgi
p3+7iT1BH2FokzpSFir5B0he7SHXrv5Dpa3PvOg6tfT0i5p9jAtPT0MZQHODg8xP
qNQ/1yf3iGvRCr9tsC90BpIqooeJeHjvetc0mLhlQHcRFbIEDMc/xkWnnvcp29Y=
=L7NI
-----END PGP SIGNATURE-----

--QXliVHAuIB9eJ4yJ--
