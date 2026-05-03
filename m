Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF3A78F4F;
	Sun,  3 May 2026 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777818777; cv=none; b=DUZkwCQ+kDVa1H3a4/4aTvrxAZSZlBiRYHdjj/7c1zP9PzjEzmyfE4yxQt1DhZgsSu334f0MoUppqfYweiMSIa1B64zsY4YWCMaly3/YNMcOXFeqgHDZ7N6YjzE6jXAViIfsT+TxX4Dk8PDLyK4iUZDk1xrMqo6aydiVc1BLGdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777818777; c=relaxed/simple;
	bh=3AQVm8GzH6oppzwS2Il2bhBnIdkwIbe4WZacOq7XqrA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J7OQM/Xi7bsoL12ErtL0hrvkoE3ZUhjpyazGdD1qrlQQvLnpQrgAM++daGoahkIRDcFDE9pVLi80WFLqGmCFTidsGsb9xC5XbAmoKCY+fRk8ClqZEjuRgPT+k6blDbuerTN/Xo8yJTNofpB4GiaN2Lrmd7B5AelWp6y/Vjvk4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=TeFQiDxU; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="TeFQiDxU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=vk2yC2jqfzlGFoHRDIOZ1Z1VJYGkp2/apvpI3jlwHk4=; t=1777818774;
	x=1778423574; b=TeFQiDxUW2IuyhwXk1kdEvVmV2rnpXUaqZsTESmLU4v5LMe7y10Fz0VnnqjhG
	UbyELss2UA7uXHWmx7DuFBGcUA5pkKiqh4PRWGDgTNlSkWpL0JLA7gtAd9FSU08lT3zqw8/D6iNKy
	LoZPi3TvS6a+Y+mTnB9st08bJio79+JJ3A1gldaVfhtpgaUxVqew55tHEUqud3KzTg3TtGN1Nmq3C
	LQq99JgZqy7XHQMoP7rMn/bW3oHTnQYpqzFflEQzM4ekkPrErCUFUQ1Gjb1UYvT2DC5E/IsxvLI2N
	Gm62bY9KTSdsH0yE19HA3OMybyNAzOaGCJClkm89gWp6YDAJuA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wJXs9-00000002jmL-1xam; Sun, 03 May 2026 16:32:41 +0200
Received: from dynamic-077-183-073-066.77.183.pool.telefonica.de ([77.183.73.66] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wJXs9-00000003kE6-12xg; Sun, 03 May 2026 16:32:41 +0200
Message-ID: <f18d87ac562cf8952e0edf48f94f8b3255d61ec8.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: fix fallout from ZERO_PAGE consolidation
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, Rich Felker <dalias@libc.org>, Thomas
 Wei?schuh <thomas.weissschuh@linutronix.de>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, 	linux-kernel@vger.kernel.org,
 linux-sh@vger.kernel.org
Date: Sun, 03 May 2026 16:32:40 +0200
In-Reply-To: <20260428080150.d9c0a60947aa3db4a2b87071@linux-foundation.org>
References: <20260417103208.1217010-1-rppt@kernel.org>
		<30ff5e1e6c0c3d4e0fb3b6f36a5372ed6bf45d19.camel@physik.fu-berlin.de>
		<ef7d133aabff5ce58a91f0274f3ed05947c8aa48.camel@physik.fu-berlin.de>
		<aeNeKYwMJA3JXO8d@kernel.org>
		<92295dd525d946777e84269cff6e9a3f2f585286.camel@physik.fu-berlin.de>
		<20260428055535.0daa3699bb6ff62f03ff1edb@linux-foundation.org>
		<99cdbec216d678e714ae14024e62d9ffcbab6d90.camel@physik.fu-berlin.de>
	 <20260428080150.d9c0a60947aa3db4a2b87071@linux-foundation.org>
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

Hi Andrew,

On Tue, 2026-04-28 at 08:01 -0700, Andrew Morton wrote:
> Yep, I saw that.  I wanted to unbreak linux-next.
>=20
> If/when this turns up in -next I'll drop the mm.git copy.

Sorry for the late reply. I am currently having trouble building a kernel f=
or
my J-Core J2 board. My custom J2 toolchain is choking on the current kernel
and I can't test the patch myself now.

However, since Geert has confirmed that the patch works, I'm merging it now=
.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
