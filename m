Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38581DDB3
	for <linux-sh@vger.kernel.org>; Mon, 29 Apr 2024 07:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375389; cv=none; b=mzelpkQaLmt+IWL/RmVriP8ude0XHIHHjp/Nmvj4/IfDcTkD2nha9C07YfaRai2x13UlLcF3RYHTi5LKZ92A/1Cw35+j474FBG/kQu5hfpCXjNGzjUeSt0bRxTxy/hulwR9Vlqds4pQ3MxeH2TNfM52Van85ebqS5/0+hyLgoTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375389; c=relaxed/simple;
	bh=wYLCMJws/PYWf0lww/lMr1Mq5rnmX2YtIjXldJkGeFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEAEmy1NLHUV0jwhUVocb7jYBuB5i+hD1Y4gvtKKedsnFiKGl8AV7efXzu0MZd4Q8e626mz7sWPFp2fungdTMC3ly2rdKfVYe8kcJOrGtFoBCYdf7EJ/yl7RUc6KmbZ8YdYL8qMdbffQetI3kNP78j/f21w1dpCmkJkDyNujyyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1LLd-0004nV-5t; Mon, 29 Apr 2024 09:22:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1LLY-00Ew7l-7h; Mon, 29 Apr 2024 09:22:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1LLY-00BDuy-0T;
	Mon, 29 Apr 2024 09:22:44 +0200
Date: Mon, 29 Apr 2024 09:22:44 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Duoming Zhou <duoming@zju.edu.cn>, kernel@pengutronix.de, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org
Subject: Re: [PATCH] sh: push-switch: Convert to platform remove callback
 returning void
Message-ID: <pc2glhr46ei3pyl46a3mb6wfkikzr4z6s7ltjlsdglwwd6aroy@yfvjdcwe4gid>
References: <20240306211947.97103-2-u.kleine-koenig@pengutronix.de>
 <fwfwlvyuznwzwejg3iqvnvgolxaqfo3aod5gbydgbwpj5l4xmr@y7fuszpv7kry>
 <293d667c491ab0c2e02a7c6b64ec384aedaa6fb7.camel@physik.fu-berlin.de>
 <cca269f66f5acb6f38bbe169f7c739f1e65eb0ac.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dw4itv7gfmsqdk3i"
Content-Disposition: inline
In-Reply-To: <cca269f66f5acb6f38bbe169f7c739f1e65eb0ac.camel@physik.fu-berlin.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-sh@vger.kernel.org


--dw4itv7gfmsqdk3i
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 09:49:13AM +0200, John Paul Adrian Glaubitz wrote:
> On Thu, 2024-04-11 at 09:47 +0200, John Paul Adrian Glaubitz wrote:
> > On Thu, 2024-04-11 at 09:18 +0200, Uwe Kleine-K=F6nig wrote:
> > > Apart from Geert's positive review reply I didn't get any feedback on
> > > this patch and it didn't appear in next yet.
> >=20
> > The plan was to get everything approved before merging it for next
> > as a partial conversion to device tree for SH would probably cause
> > problems.
>=20
> Oops, sorry. I confused patches here.
>=20
> I'll pick it up for 6.10.

The patch didn't make it into next yet. Is this expected?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dw4itv7gfmsqdk3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYvSsMACgkQj4D7WH0S
/k57Igf+M9Av50nBMztZS/wcdLc+PJLhGhEhYH1g5xzHY+irziuQz4V/20+OwBKi
3atu2oLpSBd4X8DWASjvfmFH+Ot7lNHHWrH7o0BuIkV/EmHVv/ihDJ6CwzTcZif5
8Gzgm8/DTeAcOuDg0qYhrOP0kmwwrCPYixyNJH/uQDNFNdwcszR/CrwYwqknPi6l
qa3+o/8kflhEUnUtN7zvhpmLIiy4OPFjpNWJjzqKINwnnUcrc2cid+nDKQwKbLS0
Id8ft058t97QQ1SDNHh7EhnU5Nw7ss2O4lxZmrkrr9TUwVAi3XD6Xn1ilsAoWWyr
/RSv18x7pMlNxDrRAn4A8iN6xtIeMQ==
=tqcu
-----END PGP SIGNATURE-----

--dw4itv7gfmsqdk3i--
