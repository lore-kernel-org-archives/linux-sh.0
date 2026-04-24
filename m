Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245A93EF0AD;
	Fri, 24 Apr 2026 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060804; cv=none; b=KxM14oRdxD9q0Qy3f8HCh2faiIuxurvy4WHAjCf7s3CLTbz1oh5abMGYakCxAOI5e3ygUFmDCnESvgOf1lxTzMqWpt8EkfgOFgFCgvtxJFsUAR3p7+Ggyj03/wVqdpoiyzAKrp2xrUucfbYBR4hhQzImhrBS/uwERS7Kr5TNNQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060804; c=relaxed/simple;
	bh=1PxuzsAetI3VwQEle0IpYULxi9Q1zJtXjwxlPOZ1ebM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GgEIl26C3AikjSo2mtV+j4pRWFx6oYLrY/vlENLQkC8fFAS6bXmSlT2mcOtCCAyR//mTjuaJ3MEnZZGPcUPuHXCLhZ1FNx0NJiJJrKNmL/BW6jLE49q0FIWpTUNzsMZdnuBd81rOEDTyut2khPVD1J7YuZYD3YsMukVJjwLzMZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Wk1o669w; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Wk1o669w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=QElOcqTGz1RW21C8WSZuxzMUPfytvHUMB+coL0YpqrA=; t=1777060801;
	x=1777665601; b=Wk1o669wB19f9UBQ8vkNvrqjKe/wXSEuUgpigBZ65fl45Ym108NPbaCNdL5Lx
	dnv+AuGMUah1q0TqvvdGLsiSXK2Z64kqEv1iGRdi25wUG1dD7mpR4tpL4v1z74rtqRj7xhcmqHlk4
	n4phiC/YBVUYVMNXy4FLdWi7TRCC1O+vvW8PdxWXCJ0a5LzO2i7TEBkhVBP5h8m518KVCqCqtYGmY
	Nokm96zQFGodDcKgpQPOgQ4fA8ypPDosv8nb/0V9UXy28FTJQQcpuYUEyMtXkELpbTRZ2Xt7+s8/w
	MtJIeZZqLX84ARVX4KLub6Y+kBF+OynDdmYn9C6vUXWmB9bhBw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wGMgu-00000001rjn-30Jq; Fri, 24 Apr 2026 21:59:56 +0200
Received: from dynamic-002-242-158-062.2.242.pool.telefonica.de ([2.242.158.62] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wGMgu-00000000q14-268W; Fri, 24 Apr 2026 21:59:56 +0200
Message-ID: <39b8846254ceebd7f4bee44c6348ef1f9802910d.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] maple: switch to dynamic root device
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Artur Rojek <contact@artur-rojek.eu>, Johan Hovold <johan@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, 	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 24 Apr 2026 21:59:55 +0200
In-Reply-To: <c67bd8df5fbfc357dc20ad7973eb5adb@artur-rojek.eu>
References: <20260424104142.2617115-1-johan@kernel.org>
	 <c67bd8df5fbfc357dc20ad7973eb5adb@artur-rojek.eu>
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

Hi Artur,

On Fri, 2026-04-24 at 21:08 +0200, Artur Rojek wrote:
> On 2026-04-24 12:41, Johan Hovold wrote:
> > Driver core expects devices to be dynamically allocated and will, for
> > example, complain loudly when no release function has been provided.
> >=20
> > Use root_device_register() to allocate and register the root device
> > instead of open coding using a static device.
> >=20
> > Note that this also fixes a reference leak in case device_register()
> > fails which may be flagged by static checkers.
> >=20
> > Signed-off-by: Johan Hovold <johan@kernel.org>
>=20
> Hi Johan,
>=20
> thanks for the patch. Verified on real hardware. LGTM:
>=20
> Acked-by: Artur Rojek <contact@artur-rojek.eu>

Maybe add a Tested-by as well.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
