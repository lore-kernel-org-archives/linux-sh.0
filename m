Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3A6A2D
	for <linux-sh@vger.kernel.org>; Fri, 27 Sep 2024 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727443082; cv=none; b=o0+q3Xe1HR2grpeQp9xNMa59B/AbM41asXFsRF7Kl6/DLIvrCf+U7NuegP7Et9Lhn9SxCqBWns3zdNCMdgyTYAIT5im3f5h5CuKGEeMpuLjUh2HjOt6qD+96l0dLsYlybMX63xJ2nfGaFi2lHSYdPr6psJPgmT4TrdTV4cjBDc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727443082; c=relaxed/simple;
	bh=/YSFxjai4ZWykabA5Q8op2feBg0szzJ3f3+oTSV4RhI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=jP9jdPDhJ/UMnm8iBC+CfYESapHeYiBtSNWo1ekntNXpbBdrTB/oyFMN7J9BwJvSB//EJBxXTDVZYzHWeZUk42m/bMSQr9T7gREGmDMKRBbCxOR+/rBAXhYxftRhXa+P2tEp6HC6NdHrQJqW6rhtMAMAiCLoktnfG7XmMmHTnAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=NgyDZCfU; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="NgyDZCfU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kPwcekGPosHAYzTpH1uQ8JMMUTGDT6ty0IVAGLuQyfA=; t=1727443079; x=1728047879; 
	b=NgyDZCfUbQi3bnZjK8C7XLe6RlYqgbqjVnczFphP+/5gI+KhMHzHu3EmK0Dlof3y5iN5qnucpv/
	fB0TIhAAinUhPeH8U3U5/vSTbTkSl8wMeNc3+Ii+raZShdX/Hn5ORgwSOXSk86PWqg5xgAMk+Jimd
	RoaPCXqvcuY7h/NNCVX74ZOxro9c6OwjP0gRWnW5lmFokAn5vLTUhKS5wa590HU3czv+HCOorI8AK
	aB5k1a6JP0vkclH/xoYgIwCDPgPOjNVesnEM/r7BQ2Ra8Qy+BygMKvFNgIqcCcZ1RFIJpp5m7ip8f
	KITczcjg1WWfyvJ1zPx8Y1rBYvKM1/O9R2EA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1suAqy-00000000Qrv-3hed; Fri, 27 Sep 2024 15:17:48 +0200
Received: from p57bd904e.dip0.t-ipconnect.de ([87.189.144.78] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1suAqy-000000022nM-32rx; Fri, 27 Sep 2024 15:17:48 +0200
Message-ID: <37b245abd7eaee997eabaf74aeb02bd7d5f2e983.camel@physik.fu-berlin.de>
Subject: [GIT PULL] sh updates for v6.12
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh <linux-sh@vger.kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh
 <linux-sh@vger.kernel.org>, Hongbo Li <lihongbo22@huawei.com>, Gaosheng Cui
 <cuigaosheng1@huawei.com>
Date: Fri, 27 Sep 2024 15:17:48 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Linus,

here is my round of sh updates for v6.12. This pull request is again rather=
 small
but we have more patches in the queue that still need to be reviewed and te=
sted,
I expect to send these out for v6.13.

The first change by Gaosheng Cui removes unused declarations which have bee=
n obsoleted
since commit 5a4053b23262 ("sh: Kill off dead boards.") and the second by h=
is colleague
Hongbo Li replaces the use of the unsafe simple_strtoul() with the safer ks=
trtoul()
function in the sh interrupt controller driver code.

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b=
:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/=
sh-for-v6.12-tag1

for you to fetch changes up to c3e878ca7b6663d2ad77a6e17460fc47a2347f4a:

  sh: intc: Replace simple_strtoul() with kstrtoul() (2024-09-26 17:25:29 +=
0200)

Thanks for pulling!

Adrian

----------------------------------------------------------------
sh updates for v6.12

- sh: intc: Replace simple_strtoul() with kstrtoul()
- sh: Remove unused declarations for make_maskreg_irq() and irq_mask_regist=
er

----------------------------------------------------------------
Gaosheng Cui (1):
      sh: Remove unused declarations for make_maskreg_irq() and irq_mask_re=
gister

Hongbo Li (1):
      sh: intc: Replace simple_strtoul() with kstrtoul()

 arch/sh/include/asm/irq.h   | 6 ------
 drivers/sh/intc/userimask.c | 5 ++++-
 2 files changed, 4 insertions(+), 7 deletions(-)

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
