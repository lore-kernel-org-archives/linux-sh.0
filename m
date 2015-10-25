From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 25 Oct 2015 15:53:51 +0000
Subject: Re: [PATCH 5/9] i2c: rcar: init new messages in irq
Message-Id: <20151025155351.GC23308@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uh9ZiVrAOUUm9fzH"
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
 <36149610.Eic43bQLgJ@avalon>
 <20151023121439.GK13380@katana>
 <3725918.YSMPQz70Zm@avalon>
In-Reply-To: <3725918.YSMPQz70Zm@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

so I did some testing regarding my setup.

> > Best report ever: I simply don't get a picture :) No warnings, no
> > messages. I think we want to make sure my HDMI->DVI converter is proper,
> > though.
>=20
> Does it work with other HDMI sources ?

I borrowed another HDMI monitor. There, my Lager board produces proper
HDMI output, both with plain HDMI connection as well as with the
HDMI->DVI converter. No I2C issues.

Seems I have to dump this other monitor which didn't even display the
output of the Chromecast I had lying around.


> > So, here is the NACK bit set. Which does not happen on my Lager and
> > Magnus' Koelsch. I am starting to wonder if you have a board with HW
> > issues?
>=20
> It works fine when reverting this patch :-/

Tricky. Your binary kernel didn't even start on first try on my Lager
and Magnus' Koelsch. Will check that again tomorrow.

> > Do you happen to know if you have an earlier revision of Koelsch?
>=20
> RTPORC7791SEB00010S
> KOELSCH SN.057
>=20
> I'm not sure if that tells anything about the board revision.

Magnus, what does your board say?

Thanks,

   Wolfram


--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWLPsOAAoJEBQN5MwUoCm2bRoQAJF58l+fZvHaW9A+yby2OclR
Z6hlW+mus4UoR+2s+CsHTlERS66Q9CJx8pw+WqRwPfTCH1fI9wgNBMYi4tH1TYt4
u3GWD4eD/TwmANOMiMzTs/Rofm0HrQb9ZI/CjegfJTtAj+piknLWdvS0YvelUGXe
Dqj6r/D/NDJi5yvzfqSSJa/niMgGAd8iAPPdzwlHMA24ebeO4mOXEhLQgpLZzVfT
lhKbkUPMpHgFXUrVp46qhyFgHY7moUIiXKDcXw4PwSiMkiBhZFefE+HOdlbHFa+C
TK4TA8sU6gh4qF1hEoat9MeP6EaF9nUdvSp2PSSsYXVZbRYepT4WfAQxbGntc+YP
Haj124mL+MLJFfPSwnBmwQeJgo6hZmRluCJeX7GNAfOhCtnYdnZpfYn6y0m5Kms5
vwCb/fugO3BEmWgrpEC6oWx77yi1RSXxTWgugHijhAD9kkGJleqhG/fcKIWrmbS3
PYh4ETa+JcgNFLMQl50VAs3ijAWsjifeORsr6PHDiAQ0paL2f5Z7DB/JKjjRyPQ0
ZTlooleMasImWm6L3KUwNIAjVkVqBFiQyqn4cWV9VloI5EfEveXjvzky8jlwBA9H
Yfd16Zm4H5wDyawt05MP7TgNSVM6VdMbEOmu6QDWRSa4NHAjqOkLpDIzwoWXLyYP
mE4eOrwI3lejNjwP7WSn
=PE+j
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--
