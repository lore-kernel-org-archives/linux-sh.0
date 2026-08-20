Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1470441612;
	Thu, 20 Aug 2026 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234452; cv=none; b=C/W1Yj18yTZjkuxIZm649wOZ2raWm4tzQilMj1Bv0JPe2wVpYnjrQ/KzuoZPN9Gr/P+E6vfQQSyp1zmEKaXA9kzE4avRXA/yKRTpxnZfIlyYXXKJ8sYky8Jt3WuGa7cMkmfx7kjz0lk2N7yiNM4EyV2n/UvRcyR/EN97nV/jxgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234452; c=relaxed/simple;
	bh=++0wsOp4tV5c83TG0ZYmCfj+QGpNLSVJgeH12kDn6ts=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XIoOIXOv1I1rAGfvIzc0U4G2ToFEGUeih6+5nIEXf8TlBOpnl3EZDwg4D8VAkEKf1/roa0leLZwJmXx1rzHtScMZLgsQG5YZ92eW1OXcVlTvUtnUdRKQNrT9yAltdAfaLuLxyA0NXjOk5aaKdonKcEOE24wS/xvjgSu+n9KTUKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=aRoOcZ4F; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="aRoOcZ4F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=3SGewXPpVk5ht4sQLxQ1LHMs6GTnES7UAXG9xnRwrtU=; t=1787234448;
	x=1787839248; b=aRoOcZ4Fk1DVBzRpsXTdXnLtSFnKDObhJBawoKXJz2XKFLRnEkYF/PwcnHyLA
	qdglqDLa9D+gu5q2J71PRZeiCfivJx3+88SXF5k4YVm30AyDhakXqmtrK5A8djg57/nPojo9CtnXW
	0sWdMKfRYm6yLzBBmLIJ5OR0aXDq+XVZo1JIFCGW+W8KVhLYnCCIhPyna1BvTtELVNuk067i6nmi2
	XwAunxB+9y1ynwZjekfTFArm3i0Yl+SRN2NOVeOSz2eZDytEYUj0KM1iJLnmUk39YB/wSImFJ1N2J
	ATaRUTGty0wp40i0Pc6/wNWrB/YW/xSHYAZpI5g2xrA9JmVQzg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wx3Jv-00000003QHR-0KP3; Thu, 20 Aug 2026 16:00:39 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wx3Ju-00000003jZe-3bZL; Thu, 20 Aug 2026 16:00:39 +0200
Message-ID: <047975cb5fdeb0e3cb52cb78d55c3a45023cc992.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: remove unused setup_profiling_timer function
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anthony Iliopoulos <ailiop@suse.com>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 20 Aug 2026 16:00:37 +0200
In-Reply-To: <20260820123931.142532-1-ailiop@suse.com>
References: <20260820123931.142532-1-ailiop@suse.com>
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

Hi Anthony,

On Thu, 2026-08-20 at 14:39 +0200, Anthony Iliopoulos wrote:
> setup_profiling_timer() is not used by any code at this point. Since a
> default weak implementation exists, there is no need to keep this
> arch-specific definition around. Remove it along with the now-redundant
> profile header includes.

Do you have any clue why it was still implemented for LoongArch which is
a rather new architecture? I'm also seeing that it's not used anywhere,
I'm just wondering why it was not removed before and why it was even
included when LoongArch was added.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
