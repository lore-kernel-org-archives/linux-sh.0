Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF996242D65;
	Sat,  3 Oct 2026 06:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791010412; cv=none; b=J4VObAnwgIV5XTha1PUKiagR582msm4ym4JOyXnNOSs0pJhIrpiKMm+g4hsCqokBXQ8GBNmik7X/wFdG0TORNHoMTcblmpYo13jM2mhY39RxszQsTmwN4cMueNeFysSwHgHctkKX6kdVpWyzN93WkYQLQG5D2+/BOAZ092O7zFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791010412; c=relaxed/simple;
	bh=bXha1EY6nXZ/AZjy7rx+mVa/APqVcRw/2VuVAvUIhYw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fXMWHtLv1/TZkdqkIirKjBNZnlISOeXNQQHhgEWy5aLTYnONEn+y4WtCTUMB70gtUaFFPQ3JZGBGbN8E2+9JlS9OFgwQg422pr01HOf9qipzF/upRDdhD0mQiGtqOJDvhf0fAyuKRX2PadCxWIzLX2X5rvCZn8eOoy+P8m60DKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=dPuGswNJ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="dPuGswNJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=o7vN1OvZy3wNyqGmBfQfsd9NUHv/OmOZdpb3tKj+Fms=; t=1791010408;
	x=1791615208; b=dPuGswNJ7JsDbSwSz11o9rgorqIe1u0ZKm0NKsiIyNMw4AwIVsVxvHNzRJOM/
	ALXUB/t5PhPiTiC34llOyxf0o6W0DNe7eIZrHMPFVf5oY7k44FCAjs2bH1t6GuyADfgHncR5IagkJ
	m6vkwZRu0B0CdGLc2kAOX8vUxMbGCOuvyFCvqynQ4WF5aTBwCaifsg7LYmws2+4RWgzeHDM61fcFc
	w+akAGQV5hLMWV51t5Jplxd4W31ixgRiij752lfR3KU/YRibyjE8CIKyVBr6VS4WYUjvuxMnKPqgj
	FRqZo3iy+jjp6C3j2GAKOc5SXf92S4egnmf+nZocPX9/A4PIJg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xCtcV-00000002hYR-1eb2; Sat, 03 Oct 2026 08:53:19 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xCtcV-00000001y8h-0ifD; Sat, 03 Oct 2026 08:53:19 +0200
Message-ID: <f1e0019607971c4719f96f32af2b948a071501e7.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: intc: sort the prio and sense lists after filling
 them
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, 	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 03 Oct 2026 08:53:18 +0200
In-Reply-To: <asAk-lpM0rBnQTT3@gmail.com>
References: <20260927191359.6144-1-kmehltretter@gmail.com>
	 <3bd32eaf159db61ed1d423e1d52a869b3689c682.camel@physik.fu-berlin.de>
	 <asAk-lpM0rBnQTT3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

On Fri, 2026-10-02 at 23:58 +0200, Karl Mehltretter wrote:
> thanks for testing. A cold reboot is not needed. The reported object was
> allocated by usb_get_configuration(), so this warning is unrelated to the
> INTC patch.

OK, so how do I reproduce the INTC issue?

> I sent a fix for the USB R8A66597 bug and copied you:
>=20
> https://lore.kernel.org/r/20261002213225.27834-1-kmehltretter@gmail.com/

Let me check.

> > Are you sure your patch actually fixes this problem?
> >=20
> > Or do I maybe need a cold reboot?
>=20
> A cold reboot is not needed.
>=20
> The INTC allocation remains live after boot, so SLUB does not necessarily
> check its redzone automatically. To check it explicitly after boot, run:
>=20
>   echo 1 > /sys/kernel/slab/kmalloc-32/validate

So, running the validation should trigger the INTC issue on an unpatched ke=
rnel?

> Could you please test once with only the USB patch and once with both
> patches, using slub_debug=3DFZPU and running that command after each boot=
?

I'll test the USB patch first and see if that fixes the issue when booting
with slub_debug=3DFZPU. Then test the INTC issue with the command above.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
