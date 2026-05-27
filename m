Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDC43B83FB;
	Wed, 27 May 2026 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866838; cv=none; b=Zy9xm+GEi5iTuKYY/+2yPyeyV6b0Fut/+y8tXo17D2Ljoju/506Q/oTAhHjYCfb7KdEX9hNgQrth7eiaGQegusmVgDiDlnosP6oyU3w++1KmwDA4FdY6X7QtKyLtsZ4DJZB/Jsu4GYTRksQdjWuSuFAzjA+H9bUvjEFcZAZexew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866838; c=relaxed/simple;
	bh=Y2A3B3ypeaC2SunWs93jCADZV/Bq7TXZWi4vlWi7dqw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FxC1kpRKIytjsipOSc/tDwgIZqh64DzWZ7WkJYPmP3Y4Ae1PTYoWKKaKhZPBQWAICeRaQdQiII2CSju9Ca3NRZMqRzDmVWX4qourbH+K2Z11+KFTV6Ue5VXhyxmxzUVlku00y5tuUfI8wYNrhY0OSQxqJmJ03+4XY0p7te3VNH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=SpZV3CHv; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="SpZV3CHv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=qNrsF495IfivakQmGDbAXyK215MsZVkAtP1UMTpyiqE=; t=1779866835;
	x=1780471635; b=SpZV3CHv56NXm12YHD79dDqVqNxnsKG648fTpVs0gibH6dIwRSCW8emOr4WNC
	zRlrD/5FJBCjWi3y97v1fUltA45be+2ZqTAIb8wqsnSHSPpCB8hmccZL8YohLNiowkHel1FOxaT7j
	8H2Ny5Kz1veVmsgMhCVEOO/Rhtmq+2jjpF2CzQ4iOzuFEflEAfWGa3IRXLFNp/xoBt9D3zJ433TbJ
	0G0uVOU2TsirGXL02AG3CRcyYU4Iv27QT/zDyiUMudRzV40IvQo2vqzd6bIYhFsq+FZzwSFHTJGs5
	Kqu2qoOVjGo8svx2mO3LIEzbplVXHxV/8SLvzbHIJuPIILAaqA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wS8fM-00000000pQ7-3P1K; Wed, 27 May 2026 09:27:00 +0200
Received: from p57bd94c1.dip0.t-ipconnect.de ([87.189.148.193] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wS8fM-00000003FQw-2Ph3; Wed, 27 May 2026 09:27:00 +0200
Message-ID: <07dc3a3a89cc4426955820a39c2b59c20995ab2e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/3] sh: ecovec24: remove FSI/DA7210/Simple-Audio-Card
 support
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Bartosz
 Golaszewski	 <brgl@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood
 <lgirdwood@gmail.com>, Linus Walleij <linusw@kernel.org>,  Mark Brown
 <broonie@kernel.org>, Rich Felker <dalias@libc.org>, Takashi Iwai
 <tiwai@suse.com>,  Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-sh@vger.kernel.org, linux-sound@vger.kernel.org
Date: Wed, 27 May 2026 09:26:59 +0200
In-Reply-To: <87y0h5e4ff.wl-kuninori.morimoto.gx@renesas.com>
References: <87zf1le4fu.wl-kuninori.morimoto.gx@renesas.com>
	 <87y0h5e4ff.wl-kuninori.morimoto.gx@renesas.com>
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

Hi Kuninori,

On Wed, 2026-05-27 at 06:45 +0000, Kuninori Morimoto wrote:
> Ecovec24 is using Simple-Audio-Card with "platform data" style
> (which is mainly supporting "DT style" today), but "platform data"
> style is not working correctly working during almost 10 years.

We have an out-of-tree patch series by Yoshinori Sato to convert SH to
using device tree but the patches still need some work, see [1].

Do you think we could save the drivers when switching SH to device tree?

Adrian

> [1] https://lore.kernel.org/all/cover.1716965617.git.ysato@users.sourcefo=
rge.jp/

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
