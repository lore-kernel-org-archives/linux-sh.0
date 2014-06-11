From: Mark Brown <broonie@kernel.org>
Date: Wed, 11 Jun 2014 19:04:44 +0000
Subject: Re: [alsa-devel] "ak" vs "asahi-kasei"
Message-Id: <20140611190444.GN5099@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="HYp1lSkoFcXgiw1x"
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWTVBjFzA9L9Eqpq_2Xi9_NHkOCLrb_UjK611SBfwnc=Q@mail.gmail.com>
 <87ioo7c0g5.wl%kuninori.morimoto.gx@renesas.com>
 <539815E6.2050304@codethink.co.uk>
 <20140611165410.GK5099@sirena.org.uk>
 <CAMuHMdUT0hEBGbN+W-Oz5zJ0N8S2VDMndqtDO=EtWF3jG2MEew@mail.gmail.com>
 <20140611170233.GL5099@sirena.org.uk>
 <5398A53D.3020706@wwwdotorg.org>
In-Reply-To: <5398A53D.3020706@wwwdotorg.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>


--HYp1lSkoFcXgiw1x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 11, 2014 at 12:51:41PM -0600, Stephen Warren wrote:
> On 06/11/2014 11:02 AM, Mark Brown wrote:

> > I think the bikeshed would be much better painted pink with yellow spots :)

> Sorry to jump in on this late, but what on earth is wrong with "ak". It
> went through the appropriate review process, and is already in use.
> Admittedly only in a single ARM DT file, but it's still in use. We'll
> have to allow the ak prefix forever given that DT is an ABI, so rather
> than introducing more random variations, we should just stick with what
> we have.

Well, the issue is that in reality the bulk of the drivers are using
asahi-kasei, we're going to have to churn at least something anyway.  We
seem to have one in tree user of ak in a DTS file and two DTSs using
asahi-kasei with seven drivers.

--HYp1lSkoFcXgiw1x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTmKhJAAoJELSic+t+oim9WJYP/3Zcxx3gxVg/h2bumn8vnZtP
ZkoxgG4k8Zqkh6Mvx0I6xrcwqv2X0H9D3Gd7VNAXSU+EFJ9iYpydaHwcQU2v5ZRw
gs9X9LseZvaIjR8Zc3ZbMH1RjeG5XVC/fRnrfy6f+ZZRBDKjwPA/oRnavZc+Atzo
KYmJZvROwq0BeJFhb3OdwthQegASXLliU4qRkjrya6iXRcLkAT0CsJbBhmTkVSby
wjuVsPuCqeLY1wvYShhIYjj7cuagINUytdFUV2yOdiOiExsskgzL8DjdQhStfGJS
NOYMkMujm9qPT9XL2QVo2/QYzjUHlXyFL+U6+mqk3nuyp1jnp0QyvMwSOKK9b6fg
6nHYoxywWN4Xff5jBerWsZRjNweHZJTceVMgrxzgu2MAw+8YoJIVS0c5jq2x5jwG
g/uCk8x87UwLnaDSNhHs4y516bbIzFsQGD8Q/x1gEVv4yHy3izgx1/PBmsBGEulE
+JdVdcsd3iVHBeM7m+7Qzt7AQnGet++mUUWXuC5uyJ5j/h9Y5DNklAfyqUypRsyi
y4Ev7Ei/LEJIu/sEXF8Z5ME8iJjJYHv8Wo4bBuWQR1sUQUEzejy07ZR6yVJzGpDG
5RIdf8BLJQXh7pCRtlqOdEzB0ORZUu8lxL2b8cfcdrYzHC2r/aeJg8csXtNc1ZJ/
2CQg6u2hWmnMBc0pqMdp
=5d7L
-----END PGP SIGNATURE-----

--HYp1lSkoFcXgiw1x--
