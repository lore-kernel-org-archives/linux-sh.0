Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F2221F26;
	Thu, 27 Feb 2025 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740642948; cv=none; b=F4GV85fXCbNM2T/ENC9aaQxOoSgc3Er0fPEJLxqRiHwlw+ZsYMPbQtNiI3DrU4d4K6n00A8+vr1/9J0IXyaMBBSWnDvpSPXMmbsbFH5s/GPpYXXDwCcN17xXuW7RfAmzsl11UCcVmevOmx+1fHmaAGMhSbM7102yFeX3OwWzDqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740642948; c=relaxed/simple;
	bh=xI5HhNdKctaYZZh8qMdR+YfI/h8lxZX2RnqCQfmSGTQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HtP4Wx+lGMLfFHob9soLJGcg7+h1J9K5Cu7Eof7wgTgVJcoM/hYJ6oeT/0t8gJE0PYJqZrk6oiy8qhde4AO2VbyQTRWcfLFh3tTGIm0vz7lP02/NgNRIocQ1kCVnSZN760CJxihC+2v+DBoC7M+kzy1FWcyzQSOlJL4H72qtk94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Z+a6qNXl; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Z+a6qNXl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FqSc7JMhq3/DGs0M9ECHpUHU9QBIzBw5prMUBxfWzAE=; t=1740642945; x=1741247745; 
	b=Z+a6qNXlgpaBtdeJ9YSTqdAXJ3QaaqSU1207JCogqHry4xVWu7NyQK+PQNQaUWEwl5lWPRQc95Q
	GclwyljhBUrpUtEse5aDxXp1NDBTxhnK/9lg3ClBPHNtzchoKRbTha4r+8l5sWjaZ/HdlWb2IZROp
	5RKP6jfh0FMv9/hiVcB/1/wa5cWaRrY1HO7XNdOd0ZcboEYrNr8DiyQtfBClmREyIix0KVLUbiZDa
	Qkt5KmImjKxg7/6qr3ZdRkrR/LLNa9wqzR1hCYlsNPgRDpzsYlusrvPhDQmvIShrillMneMn7v/H/
	gr+NA58YQl0++SjoSdaA8Ml6FwSatUoW7+ew==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tnYgk-00000000Ryt-0P9a; Thu, 27 Feb 2025 08:52:10 +0100
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tnYgj-00000001gus-3brW; Thu, 27 Feb 2025 08:52:10 +0100
Message-ID: <f574808500e2c5fb733c1e5d9b4d17c2884d1b9f.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] J2 Turtle Board fixes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Artur Rojek <contact@artur-rojek.eu>, Yoshinori Sato	
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Daniel Lezcano
	 <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Uros
 Bizjak	 <ubizjak@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "D . Jeff Dionne"	
 <jeff@coresemi.io>, Rob Landley <rob@landley.net>,
 linux-sh@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Thu, 27 Feb 2025 08:52:09 +0100
In-Reply-To: <20250216175545.35079-1-contact@artur-rojek.eu>
References: <20250216175545.35079-1-contact@artur-rojek.eu>
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

On Sun, 2025-02-16 at 18:55 +0100, Artur Rojek wrote:
> this series fixes boot issues and allows J2 Turtle Board to boot
> upstream Linux again.
>=20
> Patch [1/2] enforces 8-byte alignment for the dtb offset.
>=20
> Patch [2/2] resolves a problem with PIT interrupts failing to register.

I can confirm that this series makes my J2 Turtle Board boot again!

> Even with the above fixes, Turtle Board is prone to occasional freezes
> related to clock source transition from periodic to hrtimers. I however
> decided to send those two patches ahead and debug the third issue at a
> later time.=20

Yep, it just got stuck for me right after these messages at my first boot a=
ttempt:

clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:=
 7645041785100000 ns
futex hash table entries: 512 (order: 1, 8192 bytes, linear)
NET: Registered PF_NETLINK/PF_ROUTE protocol family
clocksource: Switched to clocksource jcore_pit_cs

It boots past these messages on second attempt, although it's now stuck try=
ing to start
/init. However, it's still echoing <RETURN> strokes, so it might be an issu=
e with Toybox.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
