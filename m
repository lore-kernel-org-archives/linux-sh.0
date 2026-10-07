Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282D33E51F7;
	Wed,  7 Oct 2026 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405399; cv=none; b=dArDLAltqIduhO2X6Mw6x7U+HteENHXcwXTDfIiJOd/t1O675iRqTVTKRwtiByOB6jyIUDSHlA6w1UBSnCiUuzNvi0K0NmOzehxs5aP/BgfAcswmswQJO5mZbTmYDY839Mo1vq/EGSC4ore3rGnKiSUiqZimlkm7PjeWG0iebpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405399; c=relaxed/simple;
	bh=cwaW2J6XmZk5kb74aor1umDC6A1Ee8i5SR5y94ujwz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ntzt7O0ICa7uuv7sT0T7Nu+5PSwC0LLD1eW4sg1byE3GqeY/PVeIwgnhrQRBYoS2jl0+12Uj1nGXga/wTubrocVkR9zz5J4NqAW7YwuDXA6wQJHfD0UtkLyy7JWaLYqb1Mds4SGq7OB8e6kEzeBaq7QRLKZsrMTNdGhX+yRQGPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXbODRQa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXbODRQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64551F0089E;
	Wed,  7 Oct 2026 20:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791405397;
	bh=GTffbaoiVvRePJUrsdmv7S1xtr+0/6F7pccxHu/PeBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jXbODRQamIQ0FFBocApZWXP2HYnebX+irIL0ajT4d94EIw5gkO2dIUYcewqp3ztag
	 +8Zgsr1nANqc3jnS+tFqisNgxHfvYv1/5o2upFlixZp50zBXuMVSe3IBCfxNb4abXO
	 lJMBFC7qx5GRVKVgKs+i99f58+h21twgsLa8/wubOImK0eYRGiy3IbSwWz19BdefZE
	 yMYbjul8pVUwkPM49WcE+nfSjS9SKaWJKcNULb58D2d07SzyYceJcsHzslgubYSwy0
	 dIC+Au7bA6nau7WWp5AL66AhbXj+QwB6eiqnOzsH1zRUgOXETFHeziSLNcG0RIfONT
	 8ZIlo355idolA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 69A03CE1DC2; Wed,  7 Oct 2026 13:36:37 -0700 (PDT)
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
Subject: [PATCH 4/5] csky: Emulate two-byte cmpxchg
Date: Wed,  7 Oct 2026 13:36:35 -0700
Message-Id: <20261007203636.1982188-4-paulmck@kernel.org>
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

C-SKY has no two-byte atomic compare and swap, so the __cmpxchg()
macros let case 2 fall through to BUILD_BUG() via default, and a
two-byte cmpxchg() fails the build.

Route case 2 through the new cmpxchg_emu_u16(), which narrows the
old and new values itself, so all three orderings, relaxed, acquire
and full, keep the (uintptr_t) casts the case 1 path already uses.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/csky/include/asm/cmpxchg.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
index db6dda47184e4..6f3ca79e54acf 100644
--- a/arch/csky/include/asm/cmpxchg.h
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -64,6 +64,9 @@
 	switch (size) {						\
 	case 1:							\
 		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
+		break;							\
+	case 2:							\
+		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *)__ptr, (unsigned long)__old, (unsigned long)__new); \
 		break;						\
 	case 4:							\
 		asm volatile (					\
@@ -97,6 +100,9 @@
 	switch (size) {						\
 	case 1:							\
 		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
+		break;							\
+	case 2:							\
+		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *)__ptr, (unsigned long)__old, (unsigned long)__new); \
 		break;						\
 	case 4:							\
 		asm volatile (					\
@@ -131,6 +137,9 @@
 	switch (size) {						\
 	case 1:							\
 		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
+		break;							\
+	case 2:							\
+		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *)__ptr, (unsigned long)__old, (unsigned long)__new); \
 		break;						\
 	case 4:							\
 		asm volatile (					\
-- 
2.40.1

