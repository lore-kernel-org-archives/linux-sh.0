Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACBB3D547
	for <linux-sh@vger.kernel.org>; Fri,  1 Mar 2024 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325812; cv=none; b=tPNkLEUxC3fRhkim0gmws9WxdLvS8nncHV/eATBH+jDClX0kOo8RPCfetMTE5iTHPq2b4849Q6eLrxr0mm++RcP0O4XalReXU+AbQ6dHH0Ky3cdC2gJJTjx8XcTmwtSTGNZwp92VJ+ciusYU/PQEdUyVPy1x+6DLB0ue+sPBxcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325812; c=relaxed/simple;
	bh=jBducU6AissFsRYWwrJSlsUVKj30198x189rdgDINZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XWmo/JCkkRwLjpvKUYiMhWr1SlEjk8iVshtLwgwYEAa4pfFeWMtRhShy0JcrcPezYDlMs0LU0s002b8+Wb2inx10VkpmuptlMUGgTBiS3kG/Oo6Tpaj2I6RGJ1jxppkPhMFudWhyAuJVk7Pg7BTe6UG9o+l5oFroYbP0prP1cOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:db22:6af9:7d18:6ee8])
	by albert.telenet-ops.be with bizsmtp
	id tYjM2B0021TWuYv06YjMa6; Fri, 01 Mar 2024 21:43:21 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rg9io-0024bO-2H;
	Fri, 01 Mar 2024 21:43:20 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rg9iy-00D2xT-Q1;
	Fri, 01 Mar 2024 21:43:20 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC] locking/spinlocks: Make __raw_* lock ops static
Date: Fri,  1 Mar 2024 21:43:19 +0100
Message-Id: <c395b02613572131568bc1fd1bc456d20d1a5426.1709325647.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sh/sdk7786_defconfig (CONFIG_GENERIC_LOCKBREAK=y and
CONFIG_DEBUG_LOCK_ALLOC=n):

kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_spin_lock' [-Wmissing-prototypes]
kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_spin_lock_irqsave' [-Wmissing-prototypes]
kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_spin_lock_irq' [-Wmissing-prototypes]
kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_spin_lock_bh' [-Wmissing-prototypes]
kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_read_lock' [-Wmissing-prototypes]
kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_read_lock_irqsave' [-Wmissing-prototypes]
kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_read_lock_irq' [-Wmissing-prototypes]
kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_read_lock_bh' [-Wmissing-prototypes]
kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_write_lock' [-Wmissing-prototypes]
kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_write_lock_irqsave' [-Wmissing-prototypes]
kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_write_lock_irq' [-Wmissing-prototypes]
kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_write_lock_bh' [-Wmissing-prototypes]

Fix this by making the __raw_* lock ops static.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.

Is SH really the only SMP platform where CONFIG_GENERIC_LOCKBREAK=y?
---
 kernel/locking/spinlock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 8475a0794f8c5ad2..7009b568e6255d64 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -65,7 +65,7 @@ EXPORT_PER_CPU_SYMBOL(__mmiowb_state);
  * towards that other CPU that it should break the lock ASAP.
  */
 #define BUILD_LOCK_OPS(op, locktype)					\
-void __lockfunc __raw_##op##_lock(locktype##_t *lock)			\
+static void __lockfunc __raw_##op##_lock(locktype##_t *lock)		\
 {									\
 	for (;;) {							\
 		preempt_disable();					\
@@ -77,7 +77,7 @@ void __lockfunc __raw_##op##_lock(locktype##_t *lock)			\
 	}								\
 }									\
 									\
-unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock)	\
+static unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock) \
 {									\
 	unsigned long flags;						\
 									\
@@ -95,12 +95,12 @@ unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock)	\
 	return flags;							\
 }									\
 									\
-void __lockfunc __raw_##op##_lock_irq(locktype##_t *lock)		\
+static void __lockfunc __raw_##op##_lock_irq(locktype##_t *lock)	\
 {									\
 	_raw_##op##_lock_irqsave(lock);					\
 }									\
 									\
-void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)		\
+static void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)		\
 {									\
 	unsigned long flags;						\
 									\
-- 
2.34.1

