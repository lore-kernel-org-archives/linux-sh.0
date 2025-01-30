Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADD71BD03C;
	Thu, 30 Jan 2025 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738230787; cv=none; b=kpCyUT+TkSks3Q+YMx60DOAeZcYv9Y/oc3RaNL/1jYfNbhy+gs6ojk4CNTw/uahniY4+UmNUk9NjKi4jKIPmGAajisb35VQnltZIyEOZEWCvhnd6ZdtqkaH9Y2E67gQ9DI0KVXmg1+jTY9bGHaexKEZ2Z4Dhp+HxCXmcQv4OZNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738230787; c=relaxed/simple;
	bh=tsUCWCWybLuaKDtlDfYpWlQo0fDUB8i0WRg3k7cmmZo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V09ZH/nVj2vxa4m+xOe687eFCO7zzNiMQZI3nIq4BixPYwjfZ7p4P+1erlN2uNe6eyGxo0mOCKM9YPqmG7dAGqBXeAF3T+8wftZ7cpoNDJQ/Aeq+BGO4GyI0h5d6fHUP1r+m2MAtksUnflM2f/oGIW3VCIMJjGKse+V8t9REAd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=ZjsSy/DL; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="ZjsSy/DL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LQITD/1GiU3EgPyhE8zr2Aiq6UTSY+uAdE7is4oeS94=; t=1738230785; x=1738835585; 
	b=ZjsSy/DLQfR5SYWPjM71IraU8czScpwW7ifn+ts/FA6+GTb9S6m+0xOHRqZmhy7MW77SDGdfHVr
	68wgN2KvGZajGTr7IrtnGlLeo6P9hoO4+fp092Tu1LzovO86xnFQUWkvNGhMl3Xpafshkzkb2442w
	KNvEVALPtY7c76ajy27xN7/5eag0uYcqlGwXsI1Y0oUIPUnNvkbcc9tmE6zmLEiF8Vl428+fq695a
	ACRQgFsFriOH9ymtl9IQxpvxY6mfzNq30zi/XmiPzWZwDRjbHwTj9bzuRJqEQQHQtTPtwehl8omUV
	FcS6LSvn+3UpTn/5vcyF26WvMJtfRALoYvFQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tdREK-00000000liS-2dcq; Thu, 30 Jan 2025 10:53:00 +0100
Received: from p5dc55198.dip0.t-ipconnect.de ([93.197.81.152] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tdREK-00000001xSf-1jAy; Thu, 30 Jan 2025 10:53:00 +0100
Message-ID: <c715bcf9716ebefa8272146ce48f674c56a04c52.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: Remove IO memcpy and memset from sh code
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Julian Vetter <julian@outer-limits.org>, Arnd Bergmann <arnd@arndb.de>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 linux-sh@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Thu, 30 Jan 2025 10:52:59 +0100
In-Reply-To: <CAMuHMdXfiqM2Weoeq-PRw-p9wqMrBwMBcSWjFF8f_uvmVrRS7A@mail.gmail.com>
References: <20250128101306.1475491-1-julian@outer-limits.org>
	 <8c4279dd244eed4b1a6ef7e2ea6dafac0b5fc79e.camel@physik.fu-berlin.de>
	 <CAMuHMdXOx2MFDnRm2dxVTE9tFfAud595huEVagnTd8RKp3yQsg@mail.gmail.com>
	 <57243d0602f768e6d87842008f0d2c76a1e7dc8d.camel@physik.fu-berlin.de>
	 <CAMuHMdXfiqM2Weoeq-PRw-p9wqMrBwMBcSWjFF8f_uvmVrRS7A@mail.gmail.com>
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

On Thu, 2025-01-30 at 10:35 +0100, Geert Uytterhoeven wrote:
> Hi Adrian,
>=20
> On Thu, 30 Jan 2025 at 10:31, John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > On Thu, 2025-01-30 at 10:13 +0100, Geert Uytterhoeven wrote:
> > > On Thu, 30 Jan 2025 at 09:44, John Paul Adrian Glaubitz
> > > <glaubitz@physik.fu-berlin.de> wrote:
> > > > On Tue, 2025-01-28 at 11:13 +0100, Julian Vetter wrote:
> > > > > Remove IO memcpy and memset from sh specific code and fall back t=
o the
> > > > > new implementations from lib/iomem_copy.c. They use word accesses=
 if the
> > > > > buffers are aligned and only fall back to byte accesses for poten=
tially
> > > > > unaligned parts of a buffer.
> > > > >=20
> > > > > Signed-off-by: Julian Vetter <julian@outer-limits.org>
> > > > > ---
> > > > > Changes for V2:
> > > > > - Removed also SH4 specific memcpy_fromio code
> > >=20
> > > > I'm not sure that I understand the motivation to remove hand-optimi=
zed sh4 assembler
> > > > code for memset and drop it in favor of potentially slower generic =
C code. What is
> > > > the reasoning behind this?
> > >=20
> > > See Arnd's feedback on v1
> > > https://lore.kernel.org/all/ffe019a1-11b4-4ad7-bbe2-8ef3e01ffeb0@app.=
fastmail.com
> >=20
> > I read Arnd's feedback but I don't really know whether GCC produces bet=
ter code than
> > this hand-written assembly. Is there any compelling argument?
> >=20
> > I'm just worried we would slow down something as fundamental as memset(=
).
>=20
> it's not memset(), but memset_io(), i.e. clearing (slow) mapped I/O memor=
y.

Could you review the patch as well, so I have some peace of mind? ;-)

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
