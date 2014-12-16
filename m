From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 16 Dec 2014 11:34:11 +0000
Subject: Re: [RFC 1/2] i2c: sh_mobile: refactor DMA setup
Message-Id: <20141216113411.GA10958@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
List-Id: <linux-sh.vger.kernel.org>
References: <1418217709-26392-1-git-send-email-wsa@the-dreams.de>
 <1418217709-26392-2-git-send-email-wsa@the-dreams.de>
 <548899BA.40002@cogentembedded.com>
In-Reply-To: <548899BA.40002@cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>    Hm, alignment style changed...

I am not too strict on that as long as the result is somewhat readable.

I'd be more interested in your thoughts about the general approach taken
in this series.


--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUkBizAAoJEBQN5MwUoCm2/JEP/2NTo17TlAO6iWVZSwqMxUh+
PrGA5SlEOQlg1NfsfmxYr9b+JBWGLD6369oYvHF/qG+KgOqmhMFKZa1rDPsejq1b
er8YOZU+KCBxI33aoxHmp+WdLiViOEk7cIHEgvkLR06EB9n+hJ5j3NlVlHE8k6jF
ThYFahDGPqvSQhnp6PHjuQ3fNSJpr0cLZPar2LFbrgFnx5Vw3yuAVVGc8mZOFyc5
OD9oBZshugv+PV1vYNieBfUoNVWbmAcaAGluXFQGUMiZbMvvVplJ0Zg0zJlkT+17
NXJRQj8/roz4q2TH/v8pGB3iMVLSup8AMbf0wJEvo4BuTkuszMwNXCqzrPP/eQ7A
Us3wGt0Jl4PY6ecTwnlgOCky42CAYuacu9RdtjdW678+PMiZHMBzowbh6nQYqBIr
YGQd0v0sxKaIg6QdX8v4bfuiOV5QCLGprYx6H9SISUz0/I4g8JGqhUFB9G239dva
gGb15TItU1rlQ7+Phu86wLlfK0AfW6PANfOj5BMiSziVK0hDJgPo3UE0g+XKKkCF
0ZkJ14wIeG2UlvKnjakCRNHUy5ipPTxhuUbYOapYedAyfoGYkaTb/ppYb+G2Rr08
5IVLOcMtSy65WlYEFYzjq+/q+vgcBWypmvsF8S2uyGUnF4abxJgNEjesBFWrgEv8
SuLm0TOLfHZazGyvS1Ds
=ys1B
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
