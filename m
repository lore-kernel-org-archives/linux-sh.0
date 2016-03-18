From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 18 Mar 2016 08:27:21 +0000
Subject: Re: [RFC v4 1/4] watchdog: renesas-rwdt: add driver
Message-Id: <20160318082721.GC1388@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="t0UkRYy7tHLRMCai"
List-Id: <linux-sh.vger.kernel.org>
References: <1452287553-18895-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452287553-18895-2-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> How about "renesas,rcar-gen2-rwdt" and "renesas,rcar-gen3-rwdt".

Yes, did this now in V5. And it became useful right away. Because Gen3
cannot have a reset_handler, but Gen2 could if we get ever to support
it.

> > For new bindings, we follow practices set by the rest of the DT crowd.
>=20
> +1

Understood. I'll try hard to remember this scheme now as the "final and
ultimate solution" :)


--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW67vpAAoJEBQN5MwUoCm2cHgQAIQN+4w0jmdcfNmlE8Ab81FB
jsj+bwBCyJyuRvSlT/ZSPltq2wDDsIRo59sX/nwer8EewQpnWK9oRtN4UCB9a5pI
JLrowMQN9RUGrRlmyT/CG8GO/YLgwu04Hr8/wbWQFkjGy/tGjeN0aDq57mOoAT5q
ZVnQ/28RRXeo69v32a8mMTuiFycOMP14c0I6BDQMOy48+ibMkXEd+L3hrq0t3dc1
K+QWjTJiIZEBpBMPG/f0VJIJaMDbK/84vTA5aFFjDs/piHJ+4ThOP9trzttK9XZ9
K6x6LI8AMFlk/2ys90bi06CvTzVWtqKrSDBCYX+usvGKauQb1AV9iohAfHlFlB2T
9BykBXAQ47PKpS1CDH5uAzNWCWLdycD06NqISFe2WsjZQHL+TQ89WZLdtf0rvNRM
c6YoQnue6frVKcsM173G5yiJQfLZD+xCDo+N4qpmXTms5bUfANk3ke4iHfbWju+T
7iK2iDtCYWNTn8rWcAbHAkNcqbsk6LkZ0r7E2tiJaybLkljS/if9HtxAMsDtb+IM
UUBsM9iLcl/dGfOPTMivvVwtPWIoZy2PH1rJNhCxsl0xQch14vf85iPL1vXo8jL1
CZbbX/epGTjzr/FWFlAdvFnDNi2RAqb2P9gq5FWd2gebREwHTEQJLekoLjfbtSEU
XFskSlbZllZf0sRq7nrE
=hWSJ
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--
