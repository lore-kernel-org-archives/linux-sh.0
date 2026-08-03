Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689523C503;
	Mon,  3 Aug 2026 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785738031; cv=none; b=O0u/gPADJuDWM86ijU10RB+92xsTVsYO2YhODqjRfnmohWk+/Li8u6G0zscUDvMTMZ2Hqlx3LzMENyR90xfZnuXNrm1yQRP4pQGdDgmMOtOtPJaep1g7PRY9w08URkM6579Ku75dhNilaaGXBPdHwdtW1RTk6i4/4l/ktcwFHSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785738031; c=relaxed/simple;
	bh=JG4GjC6MqLZzqatQUppK359J3niiku3N5F1o0fSuxOo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ARGUTew6dEtj2NXXeHpryAldJNnUV2YvgBAQRz7RaYX0G5ycbM7QKvOXm044ZurQ/2Ld3QADWTjOcXHppTMwSZ8CHU6Vp2WzWVzyJ6DKGurvnQkWINQKV46h0u3zOGhtKRCADPMjqdnQNLK0LarkBij8oALqmKB1DDxcFlV/WxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=HSi4sdnA; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="HSi4sdnA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=tnywEtEoQfdGq/4GgDZbiJwlJCIuIHZPdjLDRcrt+uQ=; t=1785738028;
	x=1786342828; b=HSi4sdnAf1FSrpdo23hex4TQzafIc+2MFRpVnp0Z1P/aEnC/8NBTt+8pHugw9
	tkph1oUh83W7NJDLRZgYvSUOCDVSiEGcZXV7CQCvYzUtt9ejL68cVQLI2YIDyqJ8f6Mh8ufptgGT8
	3Qftj9+C4N1Pb6vFTc1K2jCA9nHg84maeESAAE78n2Fks4s/Pna/1JYvBDi/VKay0qMQhX2stfQbV
	Ai1f03slgmRpJMoLoeqi1GLzlq+Emlz7XBVO9mZhbRcZ468RH01M3NHbbUaCdUO+N7iDBcOY5Vc6l
	VImgpfIVcebQ+KitmMh4Q49CFpLlNPkaxLFUPY5uVK+i+7n0pg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wqm2D-00000000R9B-0Wn5; Mon, 03 Aug 2026 08:20:25 +0200
Received: from p5dc558fe.dip0.t-ipconnect.de ([93.197.88.254] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wqm2C-00000002G53-3mIQ; Mon, 03 Aug 2026 08:20:25 +0200
Message-ID: <70cb2e4d8a6fd11cbeb534dbf269f67148a00a8d.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: mach-rsk: rsk7203: avoid using inline compound
 literals
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>,  Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski
 <bartosz.golaszewski@oss.qualcomm.com>, 	linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot	 <lkp@intel.com>
Date: Mon, 03 Aug 2026 08:20:24 +0200
In-Reply-To: <anAvJM0u_TIgL4ck@google.com>
References: <20260802-sh-rsk7203-swnode-props-v1-1-7a790cbac9e6@gmail.com>
	 <32a0d810bfc56029453aa72cefa49cb40466f64e.camel@physik.fu-berlin.de>
	 <anAvJM0u_TIgL4ck@google.com>
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

Hi Dmitry,

I apologize for my previous harsh mail, but the way these patches are being
pushed in really puts me under actual stress. There is a second situation l=
ike
this now where another kernel maintainer is too impatient.

On Sun, 2026-08-02 at 23:07 -0700, Dmitry Torokhov wrote:
> > Isn't that the patch that was forced into the kernel, overriding me
> > as the maintainer of arch/sh because Linus Walleij got impatient and
> > merged the patch into an immutable tree?
>=20
> Yes, but incompatibility with older GCCs is not something that you'd
> recognize on the spot, would you?

No, I wouldn't. But I would have most likely caught it as I'm building the
kernel for my J2 board with a GCC 9.x compiler as I don't have any more
recent GCC version for J2 at the moment.

> Also, you seem to be hung up on the notion of immutable branch. This is
> simply a branch that creator promises not to rewind/rebase so that it
> can be easily shared between different subsystems.

Well, it sounded to me like he wanted to make a point that there isn't goin=
g
to be any discussion about this anymore which I really thought was not okay=
.

> While we are at this, there are a few more patch series for SH that I
> would like you to take a look at, pretty please...

Yes, absolutely. I absolutely appreciate the work, I am just asking for a
little patience. As SuperH maintainer, one of the most important tasks the
past weeks was to get the GCC backend moved to the new register allocator
which is finally done now. GCC upstream is pushing to migrate all backends
to LRA now so it meant that this had highest priority.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
