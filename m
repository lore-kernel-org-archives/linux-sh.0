Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B4744CAD9;
	Tue, 28 Apr 2026 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380660; cv=none; b=rVfpewup7pJwuA165SzKkBhHK8a9BGdt/aMFng+bQhmqeg3Dc2UO0A/l4u4CJ+ZLsQoVWSBdGAwTXfLZw9CeOQojZ55rmq4WeZCQofCFhbWaKsKLQZKcnRGf9IlXw/oSWtRG5fpxfUAlvucFVyap6GqsdacjNhaH0iJs6E2Yz88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380660; c=relaxed/simple;
	bh=hqH7AZ/WIwHRTeimO1m6okxDA4UsM2idXcUWbbxiglo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aI8yEGF8dvLEX/VKEO+IQ1Ue+CaaL2t+j+9g4LT+W/TmGbGFsXkKvC97GNUP86/HLQznCdPNNH+jbdPjURzhnKQy9pUqOary8YM1GjTIM20NlK1mOD9Cuo9xqRvZFRyskxPWOtfGhRx8kwqRgycAjIk1lMR4qqPeTJ3hneSuQ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=mG5rq5gG; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="mG5rq5gG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Jl5YWkW80T7Cg72NtMYTxIN5Vm0suUY2RHqIjpSXz08=; t=1777380655;
	x=1777985455; b=mG5rq5gGo900cOZt0w0TkujEPa+uVhErR/M/jCp/nHuWrPfINihyMiXniv8G7
	f8nEDtQrVLgQZk51bCGTOOGHkVPL5F/Ghja0Jd++ivketTfvDEU/mhYrHp+XdvNqQaHfiKGzYOHgE
	rHe0IMdtzFO8MtE6lrH4btvinTdNSNtvyym/wWkWD/LTq4C3XNLpCYGX8USHV3hF8NgXdnNTrcwbx
	Y94M9Bbr/9U3+9DrhBkgfl0D1KY8N23gO3BroY3OD6l6sYUVSqNwmdQ2K8MRNdq6n1vuszVv/YS2E
	llz3MTm137mCEOYX4Ith4j8AY6m2/ak8BAzFH06RTMJwJOz+ZA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wHhtj-000000024Bp-1IsK; Tue, 28 Apr 2026 14:50:43 +0200
Received: from p5dc559e1.dip0.t-ipconnect.de ([93.197.89.225] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wHhtj-000000016Qu-0HPb; Tue, 28 Apr 2026 14:50:43 +0200
Message-ID: <9c6727df3a4b68690c31710a108ad6675f371d38.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: fix fallout from ZERO_PAGE consolidation
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Mike Rapoport
 <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Rich Felker
 <dalias@libc.org>,  Thomas =?ISO-8859-1?Q?Wei=DFschuh?=	
 <thomas.weissschuh@linutronix.de>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, 	linux-kernel@vger.kernel.org,
 linux-sh@vger.kernel.org
Date: Tue, 28 Apr 2026 14:50:42 +0200
In-Reply-To: <CAMuHMdWhesrzzT7a9dAiKFWVeTzNykj+_StBDSSRRb=TjqOzJg@mail.gmail.com>
References: <20260417103208.1217010-1-rppt@kernel.org>
	 <CAMuHMdWhesrzzT7a9dAiKFWVeTzNykj+_StBDSSRRb=TjqOzJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

On Tue, 2026-04-28 at 14:18 +0200, Geert Uytterhoeven wrote:
> Hi Mike,
>=20
> On Fri, 17 Apr 2026 at 21:16, Mike Rapoport <rppt@kernel.org> wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >=20
> > Consolidation of empty_zero_page declarations broke boot on sh.
> >=20
> > sh stores its initial boot parameters in a page reserved in
> > arch/sh/kernel/head_32.S. Before commit 6215d9f4470f ("arch, mm:
> > consolidate empty_zero_page") this page was referenced in C code as an
> > array and after that commit it is referenced as a pointer.
> >=20
> > This causes wrong code generation and boot hang.
> >=20
> > Declare boot_params_page as an array to fix the issue.
> >=20
> > Reported-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> > Tested-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> > Fixes: 6215d9f4470f ("arch, mm: consolidate empty_zero_page")
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>=20
> Thanks, this fixes booting on Landisk and QEMU rts7751r2d.
>=20
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

I'm going to pick this up later this week. I just wanted to give it a spin =
myself.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
