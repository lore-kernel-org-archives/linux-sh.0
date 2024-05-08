Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095D5BA27
	for <linux-sh@vger.kernel.org>; Wed,  8 May 2024 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161939; cv=none; b=sqnXRHxB1SHqWeg1hL7styQGuujg12ILMQPQmT64cF3fKsftmRluLilfcGMFl6UzGvksXkD+2xBxG1r18gwCY0udBj/2qUgeK+4fXTWX+AyeEp/X5jidTXeELv5vSQxyui2BYaVTY/41Shw6DGe/e3CqJkGUKyCrbO5GMXs+NxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161939; c=relaxed/simple;
	bh=w6nNrEoY19GvC863Jj8Cc8jgX1Vp3CW1qn+mLtKY6Jc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IbDvKMXgtjNau2ae4GSlOlMsCYj75ee7yTOWhUwvThRUZXVBT81Lg6e1ICNej4vhZfsmIGhS66lCiVMpDH7E8M/zcITfakxL+tweF9eGkiZDucErnZVpWZXaaKnVSrl+GlCzVLkRiIJ5VopIMb27+w3HJ/eAKDny2L3/9k7fE6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=hlZDaWMk; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="hlZDaWMk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fZh8NNLTmK5p1W4f2NkBLGPhlyhFpshVJ266+HwRLVY=; t=1715161936; x=1715766736; 
	b=hlZDaWMkc2x1QEGpslhT3pCLl2bC0CjZjAT8dLH//gIQsYIG766AUUm+rVPiIJ6Vb4f+1g5hWY7
	NqegxP7X8bMoyrFv0jPDGEuI+jfQjdvLm/dYwznq4tVUW5djlYq78D0h1qw9XQbmQteI6oEmKyXBV
	ob/4GQ81eWWcQ82u7Eop5KQn830VJ9AvJ79QA6xESVA2PKwdL1C2W5KUq+vTx9jd4Fmb+UFiHlmOT
	fphJT6Lb/1GgzvR3W6ChOc1GZO9+RGux7tJUaZXsGWY3xS+i79wSkvihhITeuWP/re2+OEUG3I2SD
	mqHuk5LB/pSpxTI3EUiDX55gi/MSNmkhd7iA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s4dy9-00000003zSS-3036; Wed, 08 May 2024 11:52:13 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s4dy9-000000039dG-2Jd7; Wed, 08 May 2024 11:52:13 +0200
Message-ID: <26b1b8d924bf91a60c23b5c05fb4b96ffbf98282.camel@physik.fu-berlin.de>
Subject: Re: Unmerged DreamCast Drivers
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: The Mariocrafter <kayvonkamyar@gmail.com>
Cc: linux-sh@vger.kernel.org
Date: Wed, 08 May 2024 11:52:13 +0200
In-Reply-To: <CAEgzAWy-vA=t5tBzaqe4h-esNwtC2pML5NE_uPWnAxvrUmFxxg@mail.gmail.com>
References: 
	<CAEgzAWy-vA=t5tBzaqe4h-esNwtC2pML5NE_uPWnAxvrUmFxxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello,

On Sat, 2024-04-20 at 15:01 -0700, The Mariocrafter wrote:
> Hello, the LinuxDC project got abandoned long ago (and got merged with
> the main kernel), with a few drivers that were never merged.
>=20
> The VMUFAT filesystem, to get the DreamCast VMU filesystem working:
> https://www.uwsg.indiana.edu/hypermail/linux/kernel/0904.1/02520.html
> , a reply with a critique shows at
> https://www.uwsg.indiana.edu/hypermail/linux/kernel/0904.1/02545.html
> saying that making it not a dependency for the VMU would be
> problematic for promoting it's use as a general purpose filesystem,
> but being useful for emulator developers. VMUFAT support would be nice
> for having Linux on the Dreamcast be able to manage saves, especially
> if a homescreen replacement is developed. I think it's better to keep
> it Dreamcast-dependant for now, due to security concerns, and due to
> having little use outside the Dreamcast, as emulator users can use a
> userspace FUSE driver.
>=20
> Other than that, two full drivers for the VMU's display and the SEGA
> LAN Adapter (HIT-0300) have been created, but were not merged nor
> pulled, located on the open directory site
> https://linuxdc.sourceforge.net/berger/ .
>=20
> I don't expect the LinuxDC project to return officially, maybe an
> unofficial revival, but it's better to get these drivers reviewed and
> submitted, and not have it unmerged indefinitely.

Well, someone needs to rebase these patches and submit them to the linux-sh
kernel mailing list, preferably the original authors.

Then the patches can be reviewed, improved and merged.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
