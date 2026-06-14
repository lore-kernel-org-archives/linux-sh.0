Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DF6175A8D;
	Sun, 14 Jun 2026 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781440356; cv=none; b=KRSOcPufsd4FsvylHGsbuGxEfgIcoafPggpim554Bcthkp+xKxOFwle4DsnguHu1bIO8Z9Qd56JvVcPt1sVe64sl1DXrTZ0mR3qwhLfeaBim4VQf1p3YtiJdFyVZP+nzUbHRzpwS186c/M2dZa8Z1ERGuTeUaXXVlJQVNVUB7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781440356; c=relaxed/simple;
	bh=JoxY8UApuFwx7OCYgSuqVYp9EeEbBh+unKDaD9jjQyQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZvzhCtNMyV9fChy77xMfLNDmEBlJ58klYP1lEq8kYk4iUVBZGbawoKr9FWJglAC/ethSWLYJPQKdTZd0GNfVLRLaQb2FNgjnBS5bXPbwhW1Yh+jKFOvaL90Ni6Ecn8ZBWEoVJn1Hn25cP0Hg+g01tDrUTvBBe2jKYNz75c7bd5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Kno0G+uu; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Kno0G+uu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=12TVOpMiX5ADydgREBd8yJZ1cemUPERFwxCuliwFQSE=; t=1781440353;
	x=1782045153; b=Kno0G+uumdzvXwTJT1Yay9dButnGoyxYXRHHFqOnmJ6W17cZB5+9mXQTGliyS
	LWibJFyrKMvlpKXaighbEjRBDkqvqUxbkUaYK8pCPfTjMkpUjFw+2gCR8X+ZmZTZkhr5qkE29UvGU
	Coirmb49m2IZ9alO8DQfCYFaa1IxBwVAl61rXU32RFQK+699qfkOGefNkKtR9GO7Clxu68UbAh7A7
	C09FZeVuZn/C03oniu4XjIyAtROMGq0heJNdu70sI6vIHPfsnPHb9dcnzvM/Ob7Sc58UodviQxoTW
	lUCtQt536za1kSwe00NzhJ9O/Kq/h2dpbaRLKR6rfpD7lOJT3Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wYk0l-00000002P9o-1VeE; Sun, 14 Jun 2026 14:32:23 +0200
Received: from p57bd94c1.dip0.t-ipconnect.de ([87.189.148.193] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wYk0l-00000002Fc0-0XhR; Sun, 14 Jun 2026 14:32:23 +0200
Message-ID: <82232ce685abc2050601abec8b4b14c0aae14e64.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 00/10] sh: remove NUMA and SPARSEMEM support
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
 Arnd Bergmann	 <arnd@arndb.de>, Rich Felker <dalias@libc.org>, Yoshinori
 Sato	 <ysato@users.sourceforge.jp>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Date: Sun, 14 Jun 2026 14:32:22 +0200
In-Reply-To: <ai6Diz0UgSGccbhY@kernel.org>
References: <20260510135546.13554-1-rppt@kernel.org>
	 <agr7XvoWn_-axX1-@kernel.org>
	 <adb1db8d1fbb9d219fa041776ae863aa2fc09270.camel@physik.fu-berlin.de>
	 <aiBI_QEmeVSBb2HY@kernel.org>
	 <865aaa7aa64ab69ca9020d64d86baa8d9b700bcb.camel@physik.fu-berlin.de>
	 <ai6Diz0UgSGccbhY@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Mike,

On Sun, 2026-06-14 at 13:33 +0300, Mike Rapoport wrote:
> On Tue, Jun 09, 2026 at 09:21:37AM +0200, John Paul Adrian Glaubitz wrote=
:
> > Hi Mike,
> >=20
> > On Wed, 2026-06-03 at 18:32 +0300, Mike Rapoport wrote:
> > > On Mon, May 18, 2026 at 02:05:39PM +0200, John Paul Adrian Glaubitz w=
rote:
> > > > Hi Mike,
> > > >=20
> > > > On Mon, 2026-05-18 at 14:43 +0300, Mike Rapoport wrote:
> > > > > Gentle ping?
> > > >=20
> > > > It's on my TODO list for this week!
> > >=20
> > > It's sad to see this being dragged since mid April (if we count v1 an=
d
> > > there were really minor changes in v2).
> >=20
> > I apologize. I am doing the maintenance as a hobby in my free time, it'=
s
> > not my primary job and it can sometimes take me a bit longer to take up
> > changes.
> >=20
> > > If you don't have time to take care of that, just say so and we'll ta=
ke
> > > this via one of the mm trees in the next cycle.
> >=20
> > It should be better this week. I've been recently busy with CVE fixes d=
uring
> > my dayjob and the workload was extremely high.
> >=20
> > I am not going to let this slip, don't worry. It's just been a bit too =
much
> > stress the past weeks due to the AI CVE reporting.
>=20
> I understand that this is a hobby for you and there are a day job and oth=
er
> obligations and you don't have time for timely responses for arch/sh
> patches.
> =20
> I just don't understand why do you insist on taking this via sh tree give=
n
> you don't have the resources to timely deal with the patches.

Because I want to learn something in the process and also perform some basi=
c
testing where possible. I know it takes longer and I can only ask for some
patience, but I will take are of it.

I will get these changes landed for 7.2, promised.

> This set can perfectly go via mm tree as it cleanups a memory management
> feature that should not have been added to sh at the first place.

I appreciate your efforts in cleaning up arch/sh, so I don't want to stress
your patience too much. Again, I will get this into 7.2. Don't worry!

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
