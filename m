Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4092F2A
	for <linux-sh@vger.kernel.org>; Sat, 30 Nov 2024 20:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732997813; cv=none; b=ZEiwHTT7QtfFcJ7Qry/sz18GqdHdffarTInTH+6La1sgY464GSdP20nFy3VLXX7yJHumVaYlw81x/ypG6m3lja9nHd+W6ExfZbTMTyD2TafGm5q7xeCisK3BDkkq5quxMkltCgk2ZJ0LbDmzZu3DhGMEjb+jXmpYZSvUz80Sc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732997813; c=relaxed/simple;
	bh=8/tRPb+yCsKsSP7+KvOEhJq/Y1zVMi8NMPOHl8RrGKc=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=C15i5aqaGusZ8eswYq/jVvhWiOAiancbCX7RZyey7NSudZGds692dyhxnzklmq8hF70fL2xI3+GuvreRAM4Uh5rbkp31u8Vo/h7y6JIo/Hw9pvYunG2TmTrfbYy99lMQdwlfOl+dpOQKlNL6g2SU647yL4EfnudGn6tzaeqrPdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Pr5FW+s4; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Pr5FW+s4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=in87gPfdMkmsyCbO9OvRdj4J7fgzaHhwQUn9uDpl5wA=; t=1732997810; x=1733602610; 
	b=Pr5FW+s4kZcoYhQvie/4FkTQW2MPh1icleBmSYDuPP72hguvS7gSVwyly+EqfRkAFRSPSoGQ9dL
	vnxsGcaW/R8U02qsFAQff8Hp+T3duf6ooxbkpeEfxZzGPusYMquqhh2aalZkYZKFoxm5K2Baap2SI
	pP6nwqqH37slTgEsE4guNKmFTzDPgYfTB739mVqcu7PE++YMGxHSf/eqSaa2uBTopfS3pf4Eqx6bK
	6RR/VRwzchmmnFuwpINSgpTXrsnh7VH0BHgJkLW/kbZVXM1cbYAj6BvjVG0oe8yipIgiyx0/wGsLv
	NlD51AxMKCes9gs4wqhD/0fU50DM7Fk0Tw9Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tHTtV-00000001FQD-3PDS; Sat, 30 Nov 2024 21:16:45 +0100
Received: from dynamic-002-242-065-087.2.242.pool.telefonica.de ([2.242.65.87] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tHTtV-00000002XAl-2ZfI; Sat, 30 Nov 2024 21:16:45 +0100
Message-ID: <d1daf444a9699b2677f9ae9f8d7e675aaeb3d340.camel@physik.fu-berlin.de>
Subject: [GIT PULL] sh updates for v6.13
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh <linux-sh@vger.kernel.org>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Huacai Chen
	 <chenhuacai@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Date: Sat, 30 Nov 2024 21:16:44 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Linus,

here is my round of updates for v6.13. I'm super late this time as I have b=
een
busy with work the past weeks, but I nevertheless managed to review and app=
ly
two small fixes.

The first one by Huacai Chen addresses a runtime warning when CONFIG_CPUMAS=
K_OFFSTACK
and CONFIG_DEBUG_PER_CPU_MAPS are selected which occurs because the cpuinfo=
 code on
sh incorrectly uses NR_CPUS when iterating CPUs instead of the runtime limi=
t nr_cpu_ids.

A second fix by Dan Carpenter fixes a use-after-free bug in register_intc_c=
ontroller()
which occurred as a result of improper error handling in the interrupt cont=
roller driver
code when registering an interrupt controller during plat_irq_setup() on sh=
.

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc=
:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/=
sh-for-v6.13-tag1

for you to fetch changes up to 63e72e551942642c48456a4134975136cdcb9b3c:

  sh: intc: Fix use-after-free bug in register_intc_controller() (2024-11-3=
0 13:55:11 +0100)

Thanks for pulling!

Adrian

----------------------------------------------------------------
sh updates for v6.13

- sh: intc: Fix use-after-free bug in register_intc_controller()
- sh: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK

----------------------------------------------------------------
Dan Carpenter (1):
      sh: intc: Fix use-after-free bug in register_intc_controller()

Huacai Chen (1):
      sh: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK

 arch/sh/kernel/cpu/proc.c | 2 +-
 drivers/sh/intc/core.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
