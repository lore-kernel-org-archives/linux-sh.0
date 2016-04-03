From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 03 Apr 2016 08:25:13 +0000
Subject: Re: [PATCH v3 09/11] i2c: rcar: revoke START request early
Message-Id: <20160403082513.GA1404@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
List-Id: <linux-sh.vger.kernel.org>
References: <1447948611-2615-1-git-send-email-wsa@the-dreams.de>
 <1447948611-2615-10-git-send-email-wsa@the-dreams.de>
 <56FD9080.4090203@cogentembedded.com>
 <20160331224838.GA7381@katana>
 <56FED245.4010503@cogentembedded.com>
 <20160401201415.GA25936@katana>
 <56FEFEC4.6010401@cogentembedded.com>
 <20160402072726.GA1384@katana>
 <56FFC06F.70108@cogentembedded.com>
In-Reply-To: <56FFC06F.70108@cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>    And I still don't feel good about the patch removing the spinlock -- I'm
> not sure it's SMP-safe...

In what scenario?


--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXANNpAAoJEBQN5MwUoCm2EdQP/3NPWdgSJu4nXPrwT6tveDGH
J9Nbx4hpwES0qnZHqKtTcuLJWSfR9pKcydFifepTrdacEc1a+1HzpCcISDjNWuN+
NcZR1zEkGbe6NEETNNidPEIsxep5vKhXj1erA57Jf5XxsdLK2LOqf2OwFE8RU5s5
yqCWA6MsTKkpnUP6sCr6Eh8A74uKdWGj3ayWIXmIYD5ZozX842nWAJrJpMWdy4b4
gptt2V+P/q5x3Xl8KYMjT5M81i8Bt/fnZmAGjSAKRrK9wSJ6wahabUVGcgAiKuzJ
ur2uC0JWsXRnqR3U0SPLGYv1DGt4KHJcjvusHcvyNyAxql2r+mFxJIQl3MAbEQIG
mRS0VIjNF+/ZsHD8KeYqrypFmM30M9QFnHWfjSsp37GsUdAnucHLrorvAY/nfy0N
3zRI7E8asrh0DyIlbW2iWDY41iD6E9tsAHdIZ7c0KW02mLLDbEfJct0elhsfvIOm
RhkMAeK5HltCPLhuEYx9EvMWcIRx6MucgOwZoG/QovrCOXxwMFAAldxwV7x/gkpr
XSJMrfaIURbqrkgZtK4KC7wInxriGe1Hedx1IdpNePjWvtNy29bOaMPX4quU3EI3
OS0hlEhVTa/qM32yF1MhiiYl4XnXEGFqY9PeUlS/Mk2nVSKMaAJQW2aL70RUbuR5
v4JXjkJyT/OwbXPTYjrg
=1YJj
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
