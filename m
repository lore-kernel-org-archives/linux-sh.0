Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8227015C0;
	Thu, 30 Jan 2025 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738229470; cv=none; b=YvRkz0VWOqmRFEx7HOnRJStBxcbqTgPpW+oKh+aSnc44JY8tpvXSiqe88j1q/0YyWV3eN56Fy3JGqXM+r8FIXkmfH/nZD89Mv/kHnt0hTub3FDROAyuLWaLhuQQjsbvcutdhBI2p94LFiQkZXyGf01ykcFq/1g/aE1/iQRoc5Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738229470; c=relaxed/simple;
	bh=GDt9ib0bL/dDXJhJY/ounxjXWQB/Y7b4HOYzw4pGSWM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MGxXlQwN0xieFdPYOw0KXBAIaYiuTbTF6WAEh75W0q0kxMUqBzbBqIVRnzjgIKfMh7nU4gT5FMkr0I0A2snGHEYs0A32fgSa84Tga8ID8QcvIQ0pSgiSodaguttS4tHVcFGisRUSZ6s6zJZRwXAiA1p3/FwNJU/wy42EzlSMrEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=MoDcBSr0; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="MoDcBSr0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=He3bzMOoahLBMrsjDrEx04DPzCPfdGHG6MJpS2UpCHE=; t=1738229467; x=1738834267; 
	b=MoDcBSr0A6sQJuCv4K9uXKXdq1Qq2e73ho27vnh8U34jobUDTZOwUMc5EY58R2SNVfQG7HwxKKp
	6JcZT4T+UqyQsS9+eVnanVWr7WHOJV2amToXGEB3WboxG8LoZBwT95WU1RXh1qvS6rpu/AFkZuLPM
	EtZwJpy2tXXAnketQmqLi0djsqK86HeZUsZkUpniWSOSgpTfzounrBtWUy3hXnU6Izja6eGfIL0Xa
	so7zsYCJ6ZkqSsGaR93wgnLlerclQhsRdT44utvsRnF/q1w7JviSrSeQ8Xsl0dJfJcdvhRvcTAnnI
	XJk53jZ+ik9J4aloKjy22Kg96nepshoqwBLg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tdQt5-00000000csN-110r; Thu, 30 Jan 2025 10:31:03 +0100
Received: from p5dc55198.dip0.t-ipconnect.de ([93.197.81.152] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tdQt5-00000001twk-03JG; Thu, 30 Jan 2025 10:31:03 +0100
Message-ID: <57243d0602f768e6d87842008f0d2c76a1e7dc8d.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: Remove IO memcpy and memset from sh code
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Julian Vetter <julian@outer-limits.org>, Arnd Bergmann <arnd@arndb.de>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 linux-sh@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Thu, 30 Jan 2025 10:31:02 +0100
In-Reply-To: <CAMuHMdXOx2MFDnRm2dxVTE9tFfAud595huEVagnTd8RKp3yQsg@mail.gmail.com>
References: <20250128101306.1475491-1-julian@outer-limits.org>
	 <8c4279dd244eed4b1a6ef7e2ea6dafac0b5fc79e.camel@physik.fu-berlin.de>
	 <CAMuHMdXOx2MFDnRm2dxVTE9tFfAud595huEVagnTd8RKp3yQsg@mail.gmail.com>
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

On Thu, 2025-01-30 at 10:13 +0100, Geert Uytterhoeven wrote:
> Hi Adrian,
>=20
> On Thu, 30 Jan 2025 at 09:44, John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > On Tue, 2025-01-28 at 11:13 +0100, Julian Vetter wrote:
> > > Remove IO memcpy and memset from sh specific code and fall back to th=
e
> > > new implementations from lib/iomem_copy.c. They use word accesses if =
the
> > > buffers are aligned and only fall back to byte accesses for potential=
ly
> > > unaligned parts of a buffer.
> > >=20
> > > Signed-off-by: Julian Vetter <julian@outer-limits.org>
> > > ---
> > > Changes for V2:
> > > - Removed also SH4 specific memcpy_fromio code
>=20
> > I'm not sure that I understand the motivation to remove hand-optimized =
sh4 assembler
> > code for memset and drop it in favor of potentially slower generic C co=
de. What is
> > the reasoning behind this?
>=20
> See Arnd's feedback on v1
> https://lore.kernel.org/all/ffe019a1-11b4-4ad7-bbe2-8ef3e01ffeb0@app.fast=
mail.com

I read Arnd's feedback but I don't really know whether GCC produces better =
code than
this hand-written assembly. Is there any compelling argument?

I'm just worried we would slow down something as fundamental as memset().

> > Also, it seems that this patch would make your other patch
> >=20
> >         "sh: Remove memset_io from sh specific code"
> >=20
> > obsolete.
>=20
> Yeah, that should have been mentioned under the ---.

Thought so.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
