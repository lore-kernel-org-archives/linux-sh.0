Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3FA265CA5;
	Thu, 13 Mar 2025 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862200; cv=none; b=iXsVXwsOtLyiMgWt1OKjsOculL58UyPFrliIngG193Hc8mK0g39Nwgnk81+8Sbxp6vkVwYXyQBtp97c9YITrgyl/IB6OAWkeaYef0tFhDS7FUf5zoExxiNBd0hJHollVPciUyCaUuyFwP6CEpxbfvx4WAcmcAuA5J614be8w8O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862200; c=relaxed/simple;
	bh=l0DHiZu/JiKMpTLyuC81m4OmC+Na2qkiqog7TlcMWL8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UoSv5n9mHIAhpcK5+eRHMlHwGxNxjFWxaMFGzR1VzfyT2zCcv5R7EyAsux65UG3T4Hqv7N9ZFwx077J+8IFcSBq5V08vwPYT2sbpsdQfN9+D8L8qQGWW/YLUrVBS/nuulAXyi7Z/JiZMkN3h4u61sIIHyfSnblDUgL9j667qLrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=kVqxRxG5; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="kVqxRxG5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uxqSOkreDmEncYOtcr9kowkpb/EgbzfBW4XWcy713g8=; t=1741862197; x=1742466997; 
	b=kVqxRxG5Q2Nlmmwwa8K9DGSDbFcBJv1RfRTKbRxgU5QPkfefVBB9f7pPa0LEH886uasM4fRuTFq
	uTbSY258RwlrgVjHJE+khh/G+Eeh5YbaXfwYJg0/ehkRYA14CXAGcsjtkCWvoDryraAyBqCaE9Yeo
	rsfpgF7EJcpA4t42IXsbKxxQ5jxrl32mP0z6+tNs0ZvcUAM+aW+A4tgjCdsvFww4gKsBDfyw6ZDf/
	ntvvbCPfov4FyBc0bx91ybzRgO/VdIh3XMGQRaHCxV7PBZQGBprvOBQhQv0CtTkf9aVZ6nsYZFTwK
	/4D/ZrAs+IttdzqKV2b9WAMg+Qs5FcXuinMg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tsfvK-00000002er6-1CbC; Thu, 13 Mar 2025 11:36:22 +0100
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tsfvK-00000003rl6-0FN1; Thu, 13 Mar 2025 11:36:22 +0100
Message-ID: <cb1d47ddc86ad1b2235dbd430fed28f6d6cd1c80.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] sh: align .bss section padding to 8-byte boundary
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Artur Rojek
	 <contact@artur-rojek.eu>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>,  Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas
 Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,  "D . Jeff
 Dionne"	 <jeff@coresemi.io>, Rob Landley <rob@landley.net>,
 linux-sh@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Thu, 13 Mar 2025 11:36:21 +0100
In-Reply-To: <CAMuHMdVmKk9vML=p1MsnkGATzUh3HD+Pa==7C=QMYjjzqzxk2A@mail.gmail.com>
References: <20250216175545.35079-1-contact@artur-rojek.eu>
	 <20250216175545.35079-2-contact@artur-rojek.eu>
	 <5365422a9715376c76a89e255c978fc39064e243.camel@physik.fu-berlin.de>
	 <433bc8a0732bf8a63c64c4bf0e6ad4a7@artur-rojek.eu>
	 <CAMuHMdVmKk9vML=p1MsnkGATzUh3HD+Pa==7C=QMYjjzqzxk2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Geert,

On Wed, 2025-03-12 at 09:06 +0100, Geert Uytterhoeven wrote:
> What about moving (or duplicating, e.g. sbss_align alignment is
> done before and after __bss_start)  the stop_align alignment
> from BSS_SECTION() into BSS() instead, i.e. just changing
> include/asm-generic/vmlinux.lds.h for everyone?  I don't think that
> would hurt any platforms, while fixing the issue for good.
> IMHO it is a bit strange that the size of the bss section can differ
> from __bss_stop - __bss_start.

This sounds reasonable. Could you send a patch? I assume that would go
through a different tree as we're touching generic code.

> One last question though: what about sbss? How does the TurtleBoard
> loader handle that?  __bss_stop - __bss_start is not the size of bss,
> but the sum of the sizes of sbss and bss, plus extra alignment in
> between. The latter might cause trouble, too.

Does the compiler actually generate the SBSS section on SH?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
