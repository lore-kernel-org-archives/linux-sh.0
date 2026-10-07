Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0083CAE95;
	Wed,  7 Oct 2026 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405363; cv=none; b=KYkgnteNm37jclT9tcHBWVB8qr5PcAMTDzM6vV7NbtxpAA8yW9RnyZnIObNoDbLJoAnI6V7qR3FGSd6/mC0yYQyZTKSWqDVnn0CTY/uywZvZr1ZQg2gJuzd77gerohxWdl0uLsXL1GZzE66/OcNlUpCYH1ngpD8bHa9V9XIWI6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405363; c=relaxed/simple;
	bh=0HDVK8JOyehFNAsoX6u18sKHFbbR/SD8q5EZY9h9XbU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QSlhb7kXpsp8Nd/VkrcWksPkYp/etjp3NQ0EM3QiHIMZUXHBRZKx8wjyXPvhfXBlce95NgNPhiSqEutKXd+N2Ko7UHLO+ncekHpV+dnWclWoFETF6VTnBGcpep1J/3bwPAZqvefgp6LxjcRKlbvF8WEUs5/M/OLFNbW2j1Eakok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+d/K0iJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+d/K0iJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2261B1F000FF;
	Wed,  7 Oct 2026 20:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791405362;
	bh=s2dr5ZtYxDvsJVmv19YUiGWV6zK4NMpNX2VkLiAlLUM=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=O+d/K0iJTokxmwTEPDNJiuOLU9sPsSxEA318JmC+Im3Uf7yyiy0vuK8f4nKkcWcWD
	 xBEJCJsje+nyjvM1sbmNt/0/hgldaLaJ3U3hHFFzQSAnkRMQ6qtSk1pmKSr/8ELRWx
	 mFdw7cu/Gi5Qrr6KpNsC1mXMFiW9nAUciUGnpuuPYeSCW/dnpwZu5lA0gF5FWl29eP
	 nLVZwWBH9Dm0YGPvDOloVX/uhBgfcDgAryF4hqSdFZy1IFHEsT2GkknUMOUEaEdHXA
	 N9NRVgybo7IByqFEj+EIeTsfHB984Jp16zzHvkc7VdraclLWZS0jfQfARnPSN/2WLY
	 L6aBRdPbOyM5g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ADEA5CE0D79; Wed,  7 Oct 2026 13:36:01 -0700 (PDT)
Date: Wed, 7 Oct 2026 13:36:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Bradley Morgan <brads@mainlining.org>, Vineet Gupta <vgupta@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-sh@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH 0/5] Provide two-byte cmpxchg() emulation
Message-ID: <7f398d4a-7fae-4382-9cc4-8627e8aa912b@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series provides emulation of two-byte cmpxchg().  Note that this
does not (yet) allow free use of atomic operations on two-byte operands
in core code because there are still a few supported systems that do not
have two-byte store instructions.  However, this emulation does permit use
of wide range of two-byte atomic operations, so is worth putting forward.

This series is being reposted on request in order to ease testing efforts.

The individual patches are as follows:

1.	Add two-byte cmpxchg emulation function, courtesy of Bradley
	Morgan.

2.	sh: Emulate two-byte cmpxchg, courtesy of Bradley Morgan.

3.	ARC: Emulate two-byte cmpxchg, courtesy of Bradley Morgan.

4.	csky: Emulate two-byte cmpxchg, courtesy of Bradley Morgan.

5.	xtensa: Emulate two-byte cmpxchg, courtesy of Bradley Morgan.

#1 and #2 have the acks required to go into the upcoming v7.4 merge
window.

						Thanx, Paul

------------------------------------------------------------------------

 arch/arc/include/asm/cmpxchg.h    |    3 +++
 arch/csky/include/asm/cmpxchg.h   |    9 +++++++++
 arch/sh/include/asm/cmpxchg.h     |    2 ++
 arch/xtensa/include/asm/cmpxchg.h |    1 +
 include/linux/cmpxchg-emu.h       |    4 +++-
 lib/cmpxchg-emu.c                 |   38 ++++++++++++++++++++++++++++++++++----
 6 files changed, 52 insertions(+), 5 deletions(-)
