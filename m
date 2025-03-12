Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E41D1CEACB;
	Wed, 12 Mar 2025 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741767726; cv=none; b=u5YrxPTIzMbXznZKNxF5HcGakP7+HAX0jYIDFVTD3pLLGsFEoiDvNhSqYt9WhWGzchjQzaJIDP5/hvdO+b+OqEe0yaMb5ux5wcq8sIWrjqYj9FqtMEDud2mmEewOHyXy16bJoUNXF/3/jJV5HOKCp6KFnA6/RjZpGsVf7IotrbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741767726; c=relaxed/simple;
	bh=w7WzLN9n+4nSFJkSuWwgvFWWF1gNWe8awDV97BmeFes=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uwzXw6Qr72Mm1jvHJkFQs3DbVbk9KQ9BhoOZ/MmQQvApFboqgvM1a51f73sein4UD29wFn9eBiEGsFU5pfWuVzTDOTTGPt+vTI4t+nBLD+uQ8qn103X4lSpNdAckVW6OtGU6vuaWKZg6dnpPmFal0ChLoojCV530jaBqXTmlKGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=NLaizaIT; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="NLaizaIT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ANRo1+lkY6D9I8jJBra+QPECjwVmHJ88jfKXDl+/AT4=; t=1741767723; x=1742372523; 
	b=NLaizaIT+LvtmkwLdTlv950R3JhbYo3DikavFrvjkvkQ6ZHFs1ubBUxFGjeZJODl3ihhEQuoRMR
	kJO4IbxCHfqaWns4Sq44omHnkyZLryWS0APfDf2J30cTMtGYOIgPGJ3r/zCpt1C0aipHH9P/soVpY
	+DhLKeWCfc8O6aCP6BkedrGu/QRXfg/Nozuu3HUj2iyqelz9KiERGb2dz3AhpUu+HtTLZcD+a1K80
	NEvZ26bZMeA6AzRR/4dgijIY4RK3Vo28u+9EKU781qHt4grVve2QkGp9cRzSx8LzapGJbQ/jyTILO
	AwZDD3ybQB2inHxOFknxv02npFWpiVzz+4Nw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tsHLg-00000002Zo1-3aIU; Wed, 12 Mar 2025 09:21:56 +0100
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tsHLg-00000000BI8-2aFw; Wed, 12 Mar 2025 09:21:56 +0100
Message-ID: <967e29681c8bc39edfdd9c645d943f17d341c2ae.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] sh: align .bss section padding to 8-byte boundary
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Artur Rojek <contact@artur-rojek.eu>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>,  Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas
 Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,  Geert
 Uytterhoeven <geert+renesas@glider.be>, "D . Jeff Dionne"
 <jeff@coresemi.io>, Rob Landley <rob@landley.net>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 12 Mar 2025 09:21:55 +0100
In-Reply-To: <433bc8a0732bf8a63c64c4bf0e6ad4a7@artur-rojek.eu>
References: <20250216175545.35079-1-contact@artur-rojek.eu>
	 <20250216175545.35079-2-contact@artur-rojek.eu>
	 <5365422a9715376c76a89e255c978fc39064e243.camel@physik.fu-berlin.de>
	 <433bc8a0732bf8a63c64c4bf0e6ad4a7@artur-rojek.eu>
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

Hi Artur,

On Wed, 2025-03-12 at 00:40 +0100, Artur Rojek wrote:
> On 2025-03-11 18:28, John Paul Adrian Glaubitz wrote:
> > Hi Artur,
>=20
> Hey Adrian,
> thanks for looking into this patch.

Sure. I just want to understand what's going on before signing it with "Rev=
iewed-by",
I wouldn't dare that without fully understanding what the proposed change d=
oes ;-).

> > What this effectively does is removing ". =3D ALIGN(sbss_align);" first=
=20
> > from BSS_SECTION().
> >=20
> > Then it inserts ". =3D ALIGN(PAGE_SIZE);" after the "SBSS(0)".
> >=20
> > If I understand this correctly, SBSS() inserts a zero-padding and if=
=20
> > I'm not mistaken,
> > inserting ". =3D ALIGN(PAGE_SIZE);" will cause this padding to grow to =
at=20
> > least PAGE_SIZE
> > due the alignment.
> >=20
> > Is this correct?
> >=20
> > > +	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {
> > > +		BSS_FIRST_SECTIONS
> > > +		. =3D ALIGN(PAGE_SIZE);
> > > +		*(.bss..page_aligned)
> > > +		. =3D ALIGN(PAGE_SIZE);
> > > +		*(.dynbss)
> > > +		*(BSS_MAIN)
> > > +		*(COMMON)
> > > +		. =3D ALIGN(8);
> >=20
> > If my understanding above is correct, why do we will need an additional=
=20
> > ". =3D ALIGN(8)"
> > here?
>=20
> I'll tackle both of the above questions at once.
> I'm by no means an expert at GNU Linker syntax, but the intention of
> this patch is to put . =3D ALIGN(8) inside the .bss : { ... } section
> definition, so that the section itself grows by the requested padding.

Makes sense.

> In the original BSS_SECTION(0, PAGE_SIZE, 4), the last argument inserts
> a 4 byte padding after the closing brace of .bss section definition,
> causing the __bss_stop symbol offset to grow, but not the .bss section
> itself:
>=20
> #define BSS_SECTION(sbss_align, bss_align, stop_align)			\
> 	. =3D ALIGN(sbss_align);						\
> 	__bss_start =3D .;						\
> 	SBSS(sbss_align)						\
> 	BSS(bss_align)							\
> 	. =3D ALIGN(stop_align);						\
> 	__bss_stop =3D .;

OK, that's really odd. So, the __bss_stop would be moved to the desired
position but the section itself still remains small? What exactly does the
linker fill the region with? Sounds very strange.

> TurtleBoard loader is only concerned with the .bss section size - it
> doesn't care about any symbol offsets - and hence this seemingly cryptic
> change (you can display the section size information with
> readelf -t kernel_image).

Looking at the actual kernel image with readelf is a very good suggestion!

> The rest of the changes are simply to "inline" the BSS() macro (as I
> needed to access that closing brace), and the former sbss_align,
> bss_align (that's your PAGE_SIZE) and stop_align arguments are passed
> accordingly, the same way they used to be passed before. The only
> visible effect should be the move of ALIGN(stop_align) inside of .bss
> section definition, and the change of stop_align value from 4 to 8.

OK. FWIW, do you understand what SBSS is for? I couldn't find any explanati=
on
for it.

> Arguably the TurtleBoard loader should read the __bss_stop symbol offset
> instead, but in this patch I'm trying to solve the issue from kernel's
> point of view.

That's absolutely sensible as this avoids having to update the firmware.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
