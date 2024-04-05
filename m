Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671A91C6A8
	for <linux-sh@vger.kernel.org>; Fri,  5 Apr 2024 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712354583; cv=none; b=K8UnC47WmEeiqDGyi6u/qqp0rRFctXxxG+PUCka63LGErvnDu6W/8fsvqmCv+w/rltsr4mlt4GJnjywAKeMBQC2LkDtv4BxiwGm1z5I0UcGG6dQhjgVThHEUd1sRWmZVvWxP9BuaK3/sjWxUnX1PrahozR7Rf+jDGzzTvMdRL/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712354583; c=relaxed/simple;
	bh=RZ9qMSqpIX+X+MMNhfti7qzWrpPVk5okU6204ErlKR8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IeQTvs+YPoiqsYn8zwMlARPwl2/o6NckyXBMnxvvmLV0dJ0beSJ5czVvl3yLuxOHisjAL9Dmqn7zdd9wDLAwMURHD/2C+kmrI2Gm6Yoksee4yINFA+vrAcTDSeVV7IN+UG6103LFjruh6UzOAE3KS2WN63CneuOeWwIXe/ForSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=eY7ETGka; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="eY7ETGka"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=n7bRElhwA46KsmpyeyhDwxSLh5CKaZgra0rQ/OCdotg=; t=1712354580; x=1712959380; 
	b=eY7ETGkav15DdKrU6CuJKaoS7BswzJjZZqha8Qr1JUs9seZjIIgPjXVN2qel2dpRrntobzUcEQd
	AwhuHYtVRCvHg/SGt1dDvF7ZwswfleeXSH+mgZfl3qbwK880e+fCO0a6mByywf2IwNX99n9PRxBYL
	2YR/L1IGYtVAay0zdUmuOJi/GxNYPU8Iijh5NyLCiaLJ0YqTCpyZ4shnwpajd9+raiDV5Nor/mskg
	a/WqroAUQ1I1RCn6IY8iidOq+jN2oHw7hvNGygd3fmtaVGSj2EXKaddXnQXyn2kwv4bo1f9B/8U/D
	RN4dkBa0zOyCKc7CC2qX0/eT1j+6QmS9qxvA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1rsre6-000000025SC-3CHN; Sat, 06 Apr 2024 00:02:50 +0200
Received: from dynamic-089-014-127-029.89.14.pool.telefonica.de ([89.14.127.29] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1rsre6-00000002Rqx-2N0A; Sat, 06 Apr 2024 00:02:50 +0200
Message-ID: <3b054ba1e4fd2f46ef8a995022dc499b22c77bfe.camel@physik.fu-berlin.de>
Subject: Re: [RESEND v7 00/37] Device Tree support for SH7751 based board
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rob Landley <rob@landley.net>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list
	 <linux-sh@vger.kernel.org>
Date: Sat, 06 Apr 2024 00:02:50 +0200
In-Reply-To: <e5f6a857-1296-e110-a3b2-c05d08522371@landley.net>
References: <cover.1712205900.git.ysato@users.sourceforge.jp>
	 <e5f6a857-1296-e110-a3b2-c05d08522371@landley.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Fri, 2024-04-05 at 07:17 -0500, Rob Landley wrote:
> Is there somewhere I can get the kernel patch list in git or something? I
> haven't got tooling set up to conveniently fish 37 patches out of an mbox=
 file,
> and would like to test this. (I moved last month and my physical sh7751 h=
ardware
> is in a storage container.)

Try the tool "b4" which allows you to download the patch set as an mbox fil=
e.

The mbox file can be applied with "git am <mbox file>".

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
