Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C705B400DE1;
	Sat,  3 Oct 2026 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021464; cv=none; b=QGFxP1LkbSYPkBVBPA7GEhyjp6rsH+FqGf6egl/eS8FzKUZ2ozuCrEPm3ZlJtPhyvoHlEyWO02wXfVJL0HV4N5i5nzpxhqeqLbJFjqLCb+nQf3R4kNnowM6umDL7djpHXJkJlDzwYoMK2TnaspNVBQkTkkuJ16IYVDMIjthWtqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021464; c=relaxed/simple;
	bh=6FcXyGndsLsN2Qm3ZMMOOr852wG7L9jBOlncq0DJvPU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r/X+ZEEPHbhm3VTZoIBblbiTVFeLHtOiV2O3gZ9bUpOepGKMlcEfnUuv4fJwlF1s+bEPnoip2QnqTZVC+rSQzNCgTLPNKYL2RAoLGBuGx0GjULPBz+0MVcDmOJg3KVcvrAbo1Fiv7joyqxPASqt1o6T6cy9zXydybJKMQmVRxgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=fzqBrxY6; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="fzqBrxY6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=lgUk64lzhxOZlU1FcjCchOOx5jvBKithIYkafyrFNRA=; t=1791021460;
	x=1791626260; b=fzqBrxY6DzdLKTssJNsX7r9cAzhqrNamKNcyOt4nzR/Omt0SE02A1m+4ehQ7q
	1N2homShmgd0q8jEIui3Nr+DuLEDVCShi1fIDj2KSX3wn+KkxFtZDFou8Ngzph64+gmkFnzevgCjA
	74tcOnflaUr9m1D1tz+jrDBmOYqXAJ5ndua4l92Cz+nepR6HGrgPC1OQ4+rSAoPo3aP3Ra/SKdMjB
	Idhkho6//XbnOoURpJcUrs06h3tOfysU2p2QunidpTE6FzZvgo7PZRRT58mM3T0MlSnsNufrXNpGy
	vFghCnIyqVWFHFmWMgLRg6VNKwJQ6nViQ9tPSuNOC+Kbdfb0zw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xCwUn-00000003Ehv-2vZX; Sat, 03 Oct 2026 11:57:33 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xCwUn-00000002nSI-22oh; Sat, 03 Oct 2026 11:57:33 +0200
Message-ID: <e3d9387cc5c461f99dd878c37ffe8c6d67128fd1.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: sh7785lcr: register the PCA9564 as I2C bus 0
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Rich Felker
 <dalias@libc.org>, 	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 03 Oct 2026 11:57:32 +0200
In-Reply-To: <asDOl5bvtlbauh9x@gmail.com>
References: <20261003082833.21511-1-kmehltretter@gmail.com>
	 <a4dcd9e615dc4e3c98c00e75cdd0c7fdeef02254.camel@physik.fu-berlin.de>
	 <e3c88969f18c493859f7c382db7ed2afeb15b4fa.camel@physik.fu-berlin.de>
	 <asDOl5bvtlbauh9x@gmail.com>
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

On Sat, 2026-10-03 at 11:51 +0200, Karl Mehltretter wrote:
> On Sat, Oct 03, 2026 at 11:38:43AM +0100, John Paul Adrian Glaubitz wrote=
:
> > > Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> >=20
> > I have to admit though I don't fully understand the description of this
> > patch. Either I don't have enough coffee or it's not precise enough.
> >=20
>=20
> Thanks for testing and reviewing! I agree the changelog doesn't explain
> why -1 is wrong and 0 is right for this board very clearly. I'll give it
> a day or so to step back and submit a v2 with your tags and a better
> changelog.

Thanks a lot! I'm glad it's not just that I had only one coffee today! ;-)

I will try to start looking at a few other patches this weekend. I'm not
sure if I will be able to pick up all at once for v7.4, so some of them
might end up in v7.5.

Either way, thanks for all these fixes! I didn't even notice that accessing
the hardware clock didn't work.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
