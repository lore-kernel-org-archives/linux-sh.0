Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA051862E
	for <linux-sh@vger.kernel.org>; Mon, 29 Apr 2024 08:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378964; cv=none; b=ig4Y6Vkj2vjtuQYqPfc3NWcY+REw1WR9xSwUjpQ1exyVV29MdJU4moJ4/JyTiWbDktwfYFUsoL0YOKYp9TXPBWYSEb5bHaH9qAayaMNE2FURIeYIjFTjdcbv+MSzre8Yq+uKYQVZ2zPPC0tAafkyUi3q3FPDiG6/4qFTG3H09PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378964; c=relaxed/simple;
	bh=2RxfPuygZGyHH0UXM8af5sKt8il1hmSZ5LoqUKp8NgE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N5V4eIGvF1oYeOpceF5p3F1B3VaxEiFIvKFPndw9S4btzpni0hxwDtpXkv4W4FRnGf08GhiJuQO90ETE6wo+LVMBSSKyXEYJZjoUHNt9IiXf81ZSLBvo/kN5F+rDLxkiRBYq1GhCgQ62hg9EQQYx/77TF6b8n118x3nWcXcv8TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=nJWtMGSd; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="nJWtMGSd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bfsvZ8Pe4b0u3Lowz58SDjywsFb2qzq6Slr9HyMSiSQ=; t=1714378962; x=1714983762; 
	b=nJWtMGSd1V3Naf5kYPUv/lvP5e8Ip5cNTpHgBRpst9e9Ov5juhSVDnt7IP1d3gbtIyOLneBhFBx
	fbmfjpIb/R6lei8MyeNqQpZyP+zZCnqHFYbq3c7CvYzcnzlum0GF685ElVqcSOK+aQ1p82fvfGkT8
	dPSfW81BwHdY+7tWbm5dRDtyBJsBze1ASDk+FVhdSjmvSWahGndTAmHzMUT5vBnF2/qaQlXL94UAw
	mRoqLJYRAHg/b9HQNXbMMFI+cKyMaw8Iaj5I26odXJ4UDwehmCQEE53a7zFRTEm84cQu076IRDsv/
	tg8fug3ZyIir2rcl+0jQsyLe3xLX1ha9UwmA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s1MHW-00000003cat-2TIm; Mon, 29 Apr 2024 10:22:38 +0200
Received: from dynamic-077-191-138-057.77.191.pool.telefonica.de ([77.191.138.57] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s1MHW-00000001IoP-1cMl; Mon, 29 Apr 2024 10:22:38 +0200
Message-ID: <09d677ad889a0bc2d7ae4324e0ca3e90d741b23b.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: boot: Remove sh5 cache handling
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>,  Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org
Date: Mon, 29 Apr 2024 10:22:37 +0200
In-Reply-To: <CAMuHMdXRDRfTB7WCP8O2ubgN3_9L6Hz2yEcUY3urFksM-2FEmg@mail.gmail.com>
References: 
	<23e9b3fd0d78e46c9fc1835852ba226aba92c3ca.1713959531.git.geert+renesas@glider.be>
	 <d5f53c4c490d0058956f6a501191107c4b148720.camel@physik.fu-berlin.de>
	 <CAMuHMdW5jMg4K454S=jQkU7EZUXyKYetqFVejL0ft1uxAJQpGQ@mail.gmail.com>
	 <23a3abf08f358588ef448c1a2f2ef53013ce6b69.camel@physik.fu-berlin.de>
	 <CAMuHMdXRDRfTB7WCP8O2ubgN3_9L6Hz2yEcUY3urFksM-2FEmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Geert,

On Mon, 2024-04-29 at 10:06 +0200, Geert Uytterhoeven wrote:
> On Mon, Apr 29, 2024 at 9:52=E2=80=AFAM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> >=20
> > Don't have the 32-bit SH CPUs any caches? The code itself is unconditio=
nally executed,
> > it seems.
>=20
> They do. E.g. SH7751 has 8+8 KiB of L1 cache.
> But e.g. sh7724 has 32+32KiB L1 cache, and 256 KiB of unified L2 cache.
> SH772[34] have l2_cache_init() to enable the L2 cache, so probably they
> boot with L2 disabled, and we are fine.

Understood. But what exactly was the job of cache_control() when all it
does was flushing the cache area? The cache is not enabled or disabled
here, is it?

Also, I was wondering whether this could be related to the boot lockups
that I am seeing on my SH-7786LCR which stops after printing "Uncompressing
Linux...".

I will test later this week whether your patch actually fixes this issue.

> Unfortunately I don't have access to a SH772[34] system.
> Sato-san: can you confirm?
> Thanks!

Yoshinari's input would indeed be valuable here.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
