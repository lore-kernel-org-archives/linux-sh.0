Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C853CF952;
	Wed,  7 Oct 2026 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405398; cv=none; b=IJ5fP4nyQEmTtb0MmNFIufKn4khaF+G1y6QuZqvcZts2fex5ABHDDqp0s/cgfP2qn/tRRgwpaCsBBCEbXMr4Cp6iRBGKme0rwWcI0dRPOAhf0wKgPVT93Tyve1pyEGnUYiaG4rfdJEowzVmT6izn1H7hEimlsTjQuWcAuSaCt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405398; c=relaxed/simple;
	bh=XhuzpkKmOFKTsfdQXBfY6gt1wInW+R6JB6OWwC6iHK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s4TV2kMFVfovl4dSb5MromPFaW2XMjfbBQleFF68oqz6kz+8KHIvijQTLzSBsID0KL/CTUw+FKltRnW2Nf1MJiWTZScWt633zFVsX/7Bfov75RX5PUcQqihGPmSxcXoQhoqMEv68mFRRcZs8I2x3k5d5Bs1tYscUUKUcFCSvtok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eaprc0Sx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eaprc0Sx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99EE1F0089C;
	Wed,  7 Oct 2026 20:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791405397;
	bh=upIye1vBByZq8u9I7ewvweyxNsW1uHQn3v6eHNja+6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Eaprc0SxvCsFv6ngGQs+vgo/PT/Vo2xHgN3DA6sHitMW8/Z5UJuSLWAcaOTdrl3se
	 3Eo1KEVdR5/l5hekbHimkZEdU9JpRhJMXButNWBNNVacCMCZw5JBmujXDq4W32sjeI
	 oztaqjcIxWdaQ9YU8KEnlx1CC6gyw/se01qOCtk4mnSc8iytAZXUtyxvtKH3qPsJ+t
	 AMYUtOSDbdTILWuqsfya+74CVLCrsLx3MlcR243lLb3d+/IxMdpwWA+8f0jtvbRHfv
	 byhOu2u77TttTGI+upIPDPHwINLgPA7BjceFKJ1xoumKW/6RnM1ILelqqJWlfJRhOg
	 kJOCxj0xAKFHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6666BCE1735; Wed,  7 Oct 2026 13:36:37 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Bradley Morgan <brads@mainlining.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-snps-arc@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-sh@vger.kernel.org,
	kernel-team@meta.com,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 3/5] ARC: Emulate two-byte cmpxchg
Date: Wed,  7 Oct 2026 13:36:34 -0700
Message-Id: <20261007203636.1982188-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7f398d4a-7fae-4382-9cc4-8627e8aa912b@paulmck-laptop>
References: <7f398d4a-7fae-4382-9cc4-8627e8aa912b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bradley Morgan <brads@mainlining.org>

ARC has no two-byte atomic compare and swap, so the
arch_cmpxchg_relaxed() macro switch lets case 2 fall through to
BUILD_BUG() via default, and a two-byte cmpxchg() fails the build.

Route case 2 through the new cmpxchg_emu_u16(), which narrows the
old and new values itself, so the dispatch keeps the (uintptr_t)
casts the case 1 path already uses.

The sizeof(*(_p_)) fix that v4 folded in here landed separately
through Vineet's f050c3e61d2a, so this patch is now only the
case 2 wiring.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/arc/include/asm/cmpxchg.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 76f43db0890fc..7157718f147c1 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -50,6 +50,9 @@
 	case 1:								\
 		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *__force)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
 		break;							\
+	case 2:								\
+		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *__force)_p_, (unsigned long)_o_, (unsigned long)_n_);	\
+		break;							\
 	case 4:								\
 		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
 		break;							\
-- 
2.40.1

