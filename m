Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C385813D886;
	Sat, 17 Aug 2024 07:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723879089; cv=none; b=jmvbqULPwkzFS69ObP7MtMnk7JA00IG+t1F1/lQgYgp5ksui/yiVyQwA9u2+RVcCg6YWH0SeP6Y7pwb2TRoovv5qCdLpLSe+4G4m8kplyeLuIoHBxPbNo/kMUpusohxC18Oy3QOVNch2JShMMNdhVAWVETJtaI+vBYOlcTFzGJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723879089; c=relaxed/simple;
	bh=iep9HEh6PTtLOtgubvSnPRt/PF3dSSz7gtDA6JdfAb4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lUQR+5zA0/C9T+Y40QVQp6WZLvPQFDG4gU6hRUJY3lrRX842EGTeUGqsIuSBJm+RJwlQY2eYjECRJqwcgzSNXz6UHeyGvlj43fLN09b4w3/T7KmL+DONglRpK0eUjlszmpmvEJRz92uFS2/QNGDgFb+FODknMOLtby/hRddgOA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=QqKLW3YZ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="QqKLW3YZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N64/orJE2dSRemHF5EZJAKDhD0XlDaCW2eGwq0sHYVM=; t=1723879086; x=1724483886; 
	b=QqKLW3YZ9VSgQCMBn52c7xRPBR50PoDy3n7pYWEVkrnIg7HYcDMDnf48NmRIGAAB634P71e8jIN
	pLORzKiQswIkGvPnLUMrLKTC+NxZcroP1Lrr+aGKxKhzf2jYyJCT6On5VkEHazsewDIpqBHaYW/rJ
	1rlJtHxZtw7s5oPGLo2WZQfRW1J6ntMhoesPKA7onFYm5O1PmalHiYaVmghtrfj2lsNBU6WW/PJ0P
	Bnv/i+31OPDqPp4emIl7FhyteHGVg22ApuHssyvDk1nA8rPq/3AEONcP5jhpkFInQUkdja4IcIJ6G
	704BdCOOll+Xm/93tCj5piJRDtY/54XuBDaA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sfDe0-00000001iWP-2BX2; Sat, 17 Aug 2024 09:14:36 +0200
Received: from p5b13a2bf.dip0.t-ipconnect.de ([91.19.162.191] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sfDe0-000000011MC-1EVE; Sat, 17 Aug 2024 09:14:36 +0200
Message-ID: <a9c6a1132d8fab355d5d770f08777daacf4c6038.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v4] sh: Restructure setup code to reserve memory regions
 earlier
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, 
	ysato@users.sourceforge.jp, dalias@libc.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org,  kernel@quicinc.com, Geert Uytterhoeven
 <geert+renesas@glider.be>, Artur Rojek <contact@artur-rojek.eu>
Date: Sat, 17 Aug 2024 09:14:35 +0200
In-Reply-To: <5ea6b07e-7583-45f6-afd1-05f2856bea27@quicinc.com>
References: <20240711214438.3920702-1-quic_obabatun@quicinc.com>
	 <a68b7cd0e3b143f023414feca279deb768d43575.camel@physik.fu-berlin.de>
	 <121b8077-bc6d-42a3-8ec2-c792e84bd947@quicinc.com>
	 <831887db73d9eafc50940315ed44139107bd5f2a.camel@physik.fu-berlin.de>
	 <636943c1-6e32-4dd1-abdd-5a110e9aa07c@quicinc.com>
	 <d12de025cfb71bcf2a86aa54251aac20f16d32b7.camel@physik.fu-berlin.de>
	 <5ea6b07e-7583-45f6-afd1-05f2856bea27@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Oreoluwa,

On Tue, 2024-07-23 at 09:59 -0700, Oreoluwa Babatunde wrote:
> On 7/23/2024 12:57 AM, John Paul Adrian Glaubitz wrote:
> > Hi Oreluwa,
> >=20
> > On Wed, 2024-07-17 at 19:22 -0700, Oreoluwa Babatunde wrote:
> > > Thanks for your feedback and for working with me on this.
> > > I have uploaded a new version here:
> > > https://lore.kernel.org/all/20240718021822.1545976-1-quic_obabatun@qu=
icinc.com/
> > >=20
> > > Please let me know if this properly addresses your comments.
> > Thanks. I'll have another look this week, including testing.
> >=20
> > But I have decided to send the pull request to Linus for v6.11 now,
> > so I don't have to hurry with the review.
> >=20
> ack.
>=20
> Thank you!

Sorry for the very late reply. I'm currently having issues booting HEAD on =
the J2
Turtleboard, most likely it's an issue with the serial console. We're curre=
ntly
trying to figure out what's wrong and bisected the commit that introduced t=
he
problem although it seems to be unrelated.

Both Artur and Geert (CC'ed) are getting their own J2 Turtleboards within t=
he next
days, so they will hopefully be able to help me debug the problem and come =
up with
a fix.

I previously did test your v3 patch against v6.9 where it did not introduce=
 any
regressions but I would like to test with HEAD just to be sure which is why=
 we
need to get the kernel working again first.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
