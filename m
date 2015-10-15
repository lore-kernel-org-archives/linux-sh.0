From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 15 Oct 2015 11:43:42 +0000
Subject: Re: [PATCH v2 2/4] i2c: rcar: enable RuntimePM before registering to the core
Message-Id: <20151015114342.GC1546@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="O3RTKUHj+75w1tg5"
List-Id: <linux-sh.vger.kernel.org>
References: <1444383567-18113-1-git-send-email-wsa@the-dreams.de>
 <1444383567-18113-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1444383567-18113-2-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2015 at 10:39:25AM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> The core may register clients attached to this master which may use
> funtionality from the master. So, RuntimePM must be enabled before, other=
wise
> this will fail. While here, move drvdata, too.
>=20
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-current, thanks!


--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWH5FuAAoJEBQN5MwUoCm229UQAINgTr2P1cwIz5BSwfgPrpjO
/5l4uExWLafcXdvHvTwmKsCSOBev23aIiI0FdP9H7IRR9MWI23+Xcl+paI0EdSZ0
AB1Tg/D2PoJxVbcLb8PS7rK5PvrsjXqm300gPLQcIJnXq/vE6BkrE96k8TuHm0bD
+RNwqXBuhTxWKzLBIlf8QItcMrXkDe6g2HhksbIAfnZiFayigqolB5zJh0dnpTIF
zNI/1TTEmTaSTRciOTKz17x+GxsWIHexJCk1nXwMDtjQvTMrlUSFV7slX37PLWnf
oyiAa8yDesZh3CLrU/H8UBbLVkJCxRncatGK/iv5Qx5DcBPNPKJZ8Wl+5AgmqW5n
2foOs2D4oPR4glgVwd0FWNgvdmSsTvfgxwoXSRwMTBsKj5LQXIItyQ5BtYB7arM7
UzrRVkejUSrlVkrQ2K+5Fuqp3ySwL9F+tFNuD6dRX+4OM760BPZ/1cc2ZQGBPjA0
KUwk51ApQi0w9wA3ceIpjQ2/144XHVFx+EXBRaoj0o//U0lUp15wihpRrfacicWf
kQU1CLY7GSYQJP8B4cHH8CUmWI9krGs+EbT9Nt1K9cjVfLki5Pt7/VcR054/zQSq
20oKnelq7bD9tAnYG7Wpx6i7zeO+erw3lyGET9GOI8ziKTAu8d9Rd1s1oLk0/8r9
sPxMdldIxsg8LFlx3ySG
=qYs9
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
