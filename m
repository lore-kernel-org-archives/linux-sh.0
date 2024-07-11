Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A17158D9F;
	Thu, 11 Jul 2024 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693588; cv=none; b=nMJ0YjtUZBTlVmdltD6dS0k96lnwfmJZZCt5mlQsYHnjx48RMdlc/9Jr9mTQXhqSWkHaxxAL8LNXfgtz/+RTPQ0su1PI8/y+zt67xQBEAlZIm+A4h19EqM8XTntuxIQYRS9zFbMNj7UCc5P6Q8cgLNt4ytm1brKtZnd1ZkCXXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693588; c=relaxed/simple;
	bh=v6Jo7U6TT2Vkgzbro1d0MWT3zaUe6TJuSdV8eGnONW4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QJTCz3CS2AcaDwMGfgGHumwuUhEhE0sqJphxb94qDyOcnzqRJ4Q/gZHUxtyTw+7mtkJvJmGkEo/pHTSC5lTlPty93487KqFkmS+yezK/saiN7uCTsVo+XFym8apjF/YXpaIHrH5D5wbUmmpsRb5GtbNvx4cLUoGymkEOzkSrLF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=FiaQTHYm; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="FiaQTHYm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5neouFoxFdfZBVXEqnaYLxMNKHfvtG+Wak2dfk250Rk=; t=1720693586; x=1721298386; 
	b=FiaQTHYmIhngoGabpFit7p75rLhSo9gPy+1FSleR6sdef2ZuTUhOg7lK90u6WX5+KwaAUfiT7O/
	oUCv4AjleUlqIpOU/Bjze2l/4BXS5Nrtr36Fx8tRT04d3JCG2GQnGEMJB0+p2ek71GQJdJDDDDyFF
	YgL4shEWjgrEnie4M7we8wa9Svlg/LlgxKAF9owOJ/aI6QfVEvyDmIwqMqfZN0vwyukk0DByc6Uzu
	g7oZJLCYjmhBkbQ1hQ9/zGb9itqM/JGuB77zGmsbK+nirH2/OV7Bt/g7Qjpor40l1K+LOawctHABP
	MaHxg5JPxPKxpZ5jX+8K2lA872H97T65sPOw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sRr0I-00000002K40-3zfO; Thu, 11 Jul 2024 12:26:22 +0200
Received: from p5b13a475.dip0.t-ipconnect.de ([91.19.164.117] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sRr0I-000000010Fo-1rdq; Thu, 11 Jul 2024 12:26:22 +0200
Message-ID: <aea743f7f514cfea239ece0fe8f697b9a8acc09f.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3] sh: Restructure setup code to reserve memory regions
 earlier
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, 
	ysato@users.sourceforge.jp, dalias@libc.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org,  kernel@quicinc.com
Date: Thu, 11 Jul 2024 12:26:21 +0200
In-Reply-To: <20240520175802.2002183-1-quic_obabatun@quicinc.com>
References: <20240520175802.2002183-1-quic_obabatun@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Oreoluwa,

On Mon, 2024-05-20 at 10:58 -0700, Oreoluwa Babatunde wrote:
> The unflatten_device_tree() function contains a call to
> memblock_alloc(). This is a problem because this allocation is done
> before any of the reserved memory regions are set aside in
> paging_init().
> As a result, there is a possibility for memblock to unknowingly allocate
> from any of the memory regions that are meant to be reserved.
>=20
> Hence, restructure the setup code to set aside reserved memory
> regions before any allocations are done using memblock.

Let me test this first to see whether this causes any regressions on my
J2 board. Afterwards, I will review and merge the patch to my SH tree.

Sorry for taking so long for this.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
