Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44E31494CF;
	Tue, 27 Aug 2024 06:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740660; cv=none; b=YfJ0TLQ3t/uJ34WbmeiAgDJEWKAOQJcvqNnQwZyTJG97ceNvmYciXMMwRETARG9g86sGT117zZLn8rrIkNg67vAzUt8iWUwC/LBgtGiVra05cX91jAVM7no4ljXqvsZQAHdwjVP52RqXEchQ+uSFRKQwMxQ2xBH3Fh8ZxqJB6bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740660; c=relaxed/simple;
	bh=mc6aGlu9mnEKgX3Eg3gP9s+f+MSRAI/3kze8p2Zbk+c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tkIbaLWS/Nzzu/pttMX7yf+anvgpG6BteTljmZePXg2FrT6AhaNIF1q8WIAsL+TO0xR/oSde/eo84AQjMXnnwz0F28lMA+f397ARofBIBuGkMUx9m6Hlw7cMVaRAwSYJso5mQAlg4uViNX/B9ey2Z8buXsAif0VWuuvMFUf3l1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=C2IfQhDG; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="C2IfQhDG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7hvoZKt8KDniC16/zwNml85JaHiw3Nuh33M3Lqd0yuY=; t=1724740656; x=1725345456; 
	b=C2IfQhDGdwSX9edHWqgl944WXLzeCMYNX2DPZa+IYxr60hw9DNTbLF5AINmsLquod0XBoAbZJgy
	5mDwFUx31PHeaeDdMQJocHAi/Q0Fe7jebFDG3WmohnuquHvJVBqQDLMw7L40sNcVwSoCFkBmubT+I
	MJJscA6+PrvbHlPQxpJQpBWoNUchaoEPxxYbNkEZqeoLVA1PKX/0i8psCzPzRV3Y8mugTWWrD3DhZ
	fl0uKzZEoYWOxu2OBuXwsxihq0km7OCoDxG5saC/k4ZmRUNo62xBeRvIE6xwyrft0FMSMFXL+C3uX
	mqegyH+tkPLuN5b6vzRbdqKswp9Bq/a1VJyg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sippT-00000001UP4-2QI3; Tue, 27 Aug 2024 08:37:23 +0200
Received: from p5b13a2bf.dip0.t-ipconnect.de ([91.19.162.191] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sippT-00000003ckf-1VoH; Tue, 27 Aug 2024 08:37:23 +0200
Message-ID: <f355e26eead641f5f281372aadf9dee7de19a4c7.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Baoquan He <bhe@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Dave Vasilevsky
 <dave@vasilevsky.ca>, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org,  mpe@ellerman.id.au, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org,  Reimar =?ISO-8859-1?Q?D=F6ffinger?=
 <Reimar.Doeffinger@gmx.de>
Date: Tue, 27 Aug 2024 08:37:22 +0200
In-Reply-To: <Zs1wpHxfTcwKr517@MiWiFi-R3L-srv>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
	 <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
	 <09c29a3c4879d4ce5d8b97fd60d8ba5e38bed979.camel@physik.fu-berlin.de>
	 <Zs1wpHxfTcwKr517@MiWiFi-R3L-srv>
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

On Tue, 2024-08-27 at 14:22 +0800, Baoquan He wrote:
> About why it's enabled by default, as Michael has explained in another
> thread, distros usualy needs to enable it by default because vmcore
> dumping is a very important feature on servers, even guest instances.=20
> Even though kdump codes are enabled to built in, not providing
> crashkernel=3D value won't make vmcore dumping take effect, it won't cost
> system resources in that case.

OK, thanks for the explanation. But as we have found out in the mean time,
the assumption was wrong to enable it by default for all architectures as
some architectures cannot boot a crash dump kernel with their default bootl=
oader
but only through kexec.

Can we have a follow-up patch to disable crash dump kernels where they're
not needed? I mean, not every platform supported by Linux is obviously a
x86-based or POWER-based server.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
