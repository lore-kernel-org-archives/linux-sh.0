Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D583DAAC8;
	Mon, 28 Sep 2026 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790630952; cv=none; b=O5vfkDB6DB97HNk8Y9p/s1C4x6CUgtrxdPpSSN9lwI+h8vX3a1CHrynKBh20Sniqw3iEehyl9/7suvxY/vg23JASF2SDamnIT7qx1/4rWbI5RGH7tfRU02KjeRDq20WINrDOq1kPb0UCVOaLrReSU9jY9W5kZynRbRmOOMOuRCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790630952; c=relaxed/simple;
	bh=94BTNUt57tVlWApoGV+9gTyiBgNku404d45yMzs3n8Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P20+FGpV1+5MBosZexusGgIW2oGz8KpHbknkh1gE284JA4krvjqOOamyUJdj9paFcCS391d70wtq4CnUMbt5Byv5+FzdLRkZEqc8qJVgT3j1smOn5o9MXVgcH2K1mdSANTY5OBTF3i4D+5YYnplIm2Sa2586Goph8KROwKYhPEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=OrHB54i2; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="OrHB54i2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=U+l/DafMvWMGnvh2E+IccrVXEKeqhLd0JdIY8xbHcr8=; t=1790630949;
	x=1791235749; b=OrHB54i2VakXZu6/eXhkkCIxGNmlqii85yAwfbSbUsBikZYpnLc8OkE1MC20d
	OnwmP3YxDztVXyRW0qiFxqojzSt2REbKg96MkDLLfXiMQuP/MzcqLVqqeqnJPX6JlzLnH597HW2m1
	wAwXnZCZA7H9o/3r72tKFfltm5Epq5AI5c3Der+Jt4k/wyp9QdNMqA27HFrXf6a0f1OPmzewAEpmI
	LKZk+x32wzlyzrk2NYXDHwqhWYaoAxpOhPHudGuBeNgJ041BmZ/sGbfErrkDq5TfL+J71RfR1KZhX
	ufT76pllByhfjV+xmzL0gcNqE+wG4abjoiHgdSZ9YpzncleY3Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xBIuD-000000023HV-3Wpg; Mon, 28 Sep 2026 23:29:01 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xBIuD-00000003iKg-2cIk; Mon, 28 Sep 2026 23:29:01 +0200
Message-ID: <3a78c262f00b02e9ea70756120e054c822c23192.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: intc: sort the prio and sense lists after filling
 them
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 28 Sep 2026 23:29:00 +0200
In-Reply-To: <arrZ4bFPXPsvjXvb@gmail.com>
References: <20260927191359.6144-1-kmehltretter@gmail.com>
	 <d4f35d5001924ef9ff4b28ac412a9d4b6048d789.camel@physik.fu-berlin.de>
	 <CAMuHMdVRznzGdRwZOHa3=cxhoDNBh1kJqGUoBHqowgj_nzKCRg@mail.gmail.com>
	 <ed4f818f00df446df53a9168054bee1a9a993409.camel@physik.fu-berlin.de>
	 <CAMuHMdW=amt+3ej6+i5TMaO6VUKJt3qqYvSWctFtSt8Tttrk2g@mail.gmail.com>
	 <cdb4898094f152eb617ea353c0780e7fbb000659.camel@physik.fu-berlin.de>
	 <CAMuHMdVw+-V5OKgRugm2Jz+S=0dOD7hi1p-U=Fzmh3piCOkE3Q@mail.gmail.com>
	 <a6242d982e0815131fb2436091c77f0e7e545424.camel@physik.fu-berlin.de>
	 <arrZ4bFPXPsvjXvb@gmail.com>
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

Hi Karl,

On Mon, 2026-09-28 at 23:22 +0200, Karl Mehltretter wrote:
> Which U-Boot version does your board run ("version" at the
> prompt)? Its limit may differ from the 8 MiB default.

I'll answer the remaining questions later, but here is the version:

U-Boot 2014.01 (Jan 30 2015 - 11:01:14)

CPU: SH4
BOARD: Renesas Technology Corp. R0P7785LC0011RL
DRAM:  384MB
Flash: 64MB
PCI: SH7780 PCI host bridge found.
PCI:   Bus Dev VenId DevId Class Int
  00:00.0     - 10ec:8169 - Network controller
  00:01.0     - 1095:3512 - Mass storage controller
In:    serial
Out:   serial
Err:   serial
Net:   RTL8169#0
Hit any key to stop autoboot:  0=20
=3D>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
