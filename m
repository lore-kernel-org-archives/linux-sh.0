Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792899868;
	b=3Lv5lthg5mN1nitHFmGZWHz9NlgvL+xec7p149XmnqkAApJ5p0J/nKF1Z1pczBFmwH9w
	 u8J80l1QX4wdlb5Gd8o+bSUkaEJiORT+oMnCTnG7tBqD+A7lky4/5CFOWtySXfJxUDRxI
	 Cu0sOsZUvkb6ogdnOhVi1dDvlk+uAgBzguON8xrj3nKH0V0YodKSQwoHKRqK7zZs6TW04
	 ZSpXFelbkXaZq5Lchw4DBkJmFCyL1ZaOELvBYXEMOhQYqIMruzyJZdMPF0nIq9imUtBzW
	 pqfoAfr3W97Zze1wGqQNEvbE6jal2etJkjUIjx7Ndo6uKwoUnzTJnF8GD4CCUp34ifA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792899868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mzxcYUCwTt0YqgjKp0GiJp4QFX6CqOyEppZJrIxJY7A=;
	b=cZIGCupJLfBSCOdcBpiY5SRaJQhTjS8hHeCI0ro1LuAf8rIGdvjn2UpdfY7x6i6vY4JC
	 GedT/a4DN2G1FBdmaKsxaYl7X4+gLxx5Bd/ipkVBpjy/9HdRrNALtiPBp/W49GYTjIk8L
	 sOIecpHz1Nirn0XGYTxu4Loq9mM2DIghAbJjOc0xCs3TtOYfNVWTy/YeTJL7zWrIzQn3f
	 RJ9aqs2Sg6yHdGCbcKmrvFMI85M7hJaA7NtAGlZdoXEQqQCBmPcJ0wwwU3Tj+nNlQCQAB
	 H9x78e4AA3vUan5pRBJBp78mdAID/5lCDe1oXmG9WGnaFpJYHYNY9I7HbPEINSoe0SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=0x0f.com;
	spf=pass smtp.mailfrom=0x0f.com;
	dkim=pass header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=inpmsh23;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2EA606A31E
	for <linux-sh@vger.kernel.org>; Sun, 25 Oct 2026 03:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE2EA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=inpmsh23
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ab41538192so1527256a91.0
        for <linux-sh@vger.kernel.org>; Sat, 24 Oct 2026 20:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792899867; x=1793504667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mzxcYUCwTt0YqgjKp0GiJp4QFX6CqOyEppZJrIxJY7A=;
        b=inpmsh23JZihZWIdxCXdcljqgx0ZfDMt/YGILuWXDgk8+0JzAgMh0ettSpv+Tv+NSY
         mQw7yi3bz6cK+qKRZrcd7gvHgnrcWDWdhG6JnkS0V0/Qo5LGOgTw7Qt4yqCuTrEO1lrS
         RIHQDLJdnMNWv5RGy6z3OJ7kBzFvi37Eb6vLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792899867; x=1793504667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mzxcYUCwTt0YqgjKp0GiJp4QFX6CqOyEppZJrIxJY7A=;
        b=GBL/u5TEHi43fq9Fu+eXfAhdvffincCQn4ZPfbYCK3lP6jDnaIClyzcgjSvdvmq1V1
         seorrsgwcQ6RzGfuuODwWlJ5i4VhBYGY3F0CFuLK6tu0qtpAUgMaFdWm+SOhA4yvpcSq
         6xWGshvjlqng2qpAZfdGnsOcOk69KsPRyHhGrjoEtX/LN4veATBXr+G6azdukHSP7fMI
         C5j+X9KS4OxxHWLNOseTawH3satlTAAqsUNzRy2wa2gbfsnwviQ4JQjmLA0UW/vmUDs2
         5X1pyGB6qb907Eq4Teq4b+sw1jsptzgfy+639/wj4Bvme3fym1JmdW8Wn5pRksKIMJjq
         EB5A==
X-Forwarded-Encrypted: i=1; AKwUvBzRfpfj4Tcl+wse96W3WywGYONe5XRL2lHxS0/gDzFlzx91qt1LOUrN51at9Unrki4fcS8Y3NJMYQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLs/3sAg59eOkZl/G0UdC32fIxFcTDm8b5Tu5Nvj6sPbvFxCoX3
	n5g0cH5wr+cIXsjypm1RLLmqgJQUgX6NyTH7tBNaS69GByOrSgLSN8UcUGO9AlvtLhA=
X-Gm-Gg: AYBFou1xF9Mu57V5Q1hi7OTo+wqSsNdLtelzsLuDpqLZhijH2V1FnY6QBidkugVmHuz
	eNoUF65Z5aV1tSjOsIjhIa6k1RzhOepyDAA7mBva05oEDux44u1K3TWE/0FprAkgaZPpMkxx+Hv
	ao9Hd4TAekginRYfGXDdKhAGfWbYsHBW9Xe3yRnS7FQR64NUCd72YmIdOU7qp0vwn5gV5P7zph/
	i00HU1pjyFDPonY1ra0Ljyr0COPEjtR4ypXW0SxnOH229kL1hZmARISpPEpeQes/YzsPFMkdVk1
	pRv+6I96cr9y67yHuIT0pIpQ8cHYmYyN4GnV2ViJqNW+Rr2JzrzQlsmZs3bTP1icrNjFY0TilLW
	ifQHnwWLhOjlTzcx6yOQl364gKDPrm31b4AT+opBAX6PyZ9REDDZBoWk8WXbWydVz5/vqT09squ
	Kj/eDTHdOtitSznPMVZofPxvrjI/2IzPNfLjcq63Y+A8NcHVJC9UOR2Lq3K/WcND9V5Byv9hm8b
	gU6TEb3XhuYNJ32ff1BrrRtjSrv7EO0sC0pcoYBGlHH/eHFou57IN+aWGwnSZ/etYHqah9Q+MFO
	0asdBysOFY9Hwy1kmceP
X-Received: by 2002:a17:90b:4c8b:b0:3a4:f8da:2478 with SMTP id 98e67ed59e1d1-3adeae9c560mr3198326a91.29.1792899867044;
        Sat, 24 Oct 2026 20:44:27 -0700 (PDT)
Received: from shiro (p1469046-ipxg00b01sizuokaden.shizuoka.ocn.ne.jp. [153.223.97.46])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3adebe8f0b2sm4181927a91.8.2026.10.24.20.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 20:44:25 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linux-sh@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Florian Fuchs <fuchsfl@gmail.com>,
	Colton Pawielski <colton.pawielski@gmail.com>
Subject: [PATCH v2 0/2] sh: Fix IDE on landisk (HDD models)
Date: Sun, 25 Oct 2026 12:44:08 +0900
Message-ID: <20261025034410.808796-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I dug out my landisk to look at kexec for Geert. Since I'm lazy and
LLMs are good at fixing bitrot I let my LLM work out how to get
it to boot again.

There are some other issues (perf is apparently borken, there are
some issues with the decompresor and big kernels..) but this
seems to be the only thing stopping it booting with the defconfig.

Disclaimer since we don't need to give LLM tags anymore:
- LLM debugged the issue.
- It has been checked on real hardware.
- I have checked the IDE driver patch, cleaned it up and
  cleaned out massive walls of text that LLMs seem to like
  to add but I have left its summary of the issue in the commit
  message.

Changelog:

v2:
- Fixed up the patch to pata_artop.c so it looks a bit nicer.
- Updated the text in places to reflect that this covers the
  models of landisk that use a PCI IDE controller.
- Florian said that the pata_artop.c patch might change the behaviour
  if the pci_iomap() fails. I think this is ok, if pci_iomap() fails
  there is no point continuing into the core driver where it'll just
  fail again.
- I'll address the remaining style issues in pata_artop.c later.
- Somehow I have now ended up with the CF based model (USL-5P) too
  and I have tested these changes don't break it. As Geert mentioned
  the CF models need their own patch to fix IDE in the defconfig.
  I have a few other fixes for the USL-5P that I'll put together into
  a series and send later.


cc: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Florian Fuchs <fuchsfl@gmail.com>
cc: Colton Pawielski <colton.pawielski@gmail.com>

Daniel Palmer (2):
  ata: pata_artop: read the ATP865 mode register through pci_iomap
  sh: landisk_defconfig: enable PATA_ARTOP for the ATP865

 arch/sh/configs/landisk_defconfig |  2 +-
 drivers/ata/pata_artop.c          | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.55.0

