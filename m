Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC8647F2DE
	for <linux-sh@vger.kernel.org>; Thu, 13 Aug 2026 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640659; cv=none; b=h/LCfOrz/8tZ998mmwO5w/NexkhDWySWiVSWP6GDydKC36dvzqFLLKRQ4UflISdzptuecJrfjG6mib2pxXJaOw1lzPK3rfKTTokbm+s6nv7jjyvZznSH7cye6dLzyf9U5ukae/K6WneNDaytwIqw5LHvj+F6aCEdW80D+Lv+HxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640659; c=relaxed/simple;
	bh=9XBV5I17RwFW6E8XHjBQf72B0dwOKDgYR3HERS1dxTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=XEPI6Rzu2a4Qcmz2UA3BDFzXTAQMwu6njUG42MdSiD52jhoWWXF3B79+nTnUyy7GjQZ4f8yKw5l+rVNRzKEVfZOet69K+vqyshQWEHLcu0Kc0MtjBj7UHuFVrlTYwh6g57TCnBwaj8ZTiw/DghHgEqn62fOQY0oI4cc5ms5wSEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKUxgjO3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKUxgjO3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GgHNIRpaiGrsleuWQ8qibHY2uklIV42xG6wSQPY4e1M=;
	b=BKUxgjO3dqoTLkLUJgWqtOHURbCDFl/prclNf05JvL8G1uKsHak6O+OiyGpgmwyS7kVesQ
	F9va8Gk5AZXBzgqtx6/4dzNYxnBa4xytrtgzposdtuMqjkLaeZRireWYCfIg2NZQb1LgUn
	y7IH8d/HQvAmxONfj+oTuTTjM0ThmVo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-v7F3cTZiOfi696D6EVHhdQ-1; Thu,
 13 Aug 2026 13:04:13 -0400
X-MC-Unique: v7F3cTZiOfi696D6EVHhdQ-1
X-Mimecast-MFC-AGG-ID: v7F3cTZiOfi696D6EVHhdQ_1786640647
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FFB5180066A;
	Thu, 13 Aug 2026 17:04:06 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 07750195608A;
	Thu, 13 Aug 2026 17:03:51 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	bpf@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	sgrubb@redhat.com,
	oleg@redhat.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	guoren@kernel.org,
	monstr@monstr.eu,
	tsbogend@alpha.franken.de,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	tglx@kernel.org,
	peterz@infradead.org,
	luto@kernel.org,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH 02/13] alpha: pass all six syscall args to audit_syscall_entry()
Date: Thu, 13 Aug 2026 14:02:52 -0300
Message-ID: <7dec380a50e3db536bdec61a33b8f3b2e2e7ec65.1786626275.git.rrobaina@redhat.com>
In-Reply-To: <cover.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: CsOuxBzTnSLH2LGsrDDqZAKRFeBzJ58GALqgLlROqK0_1786640647
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Update the audit_syscall_entry() call to forward the 5th and 6th
syscall arguments (r20, r21) now that the audit core logs all six.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/alpha/kernel/ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
index 0687760ea466..d90e2194b528 100644
--- a/arch/alpha/kernel/ptrace.c
+++ b/arch/alpha/kernel/ptrace.c
@@ -396,7 +396,8 @@ asmlinkage unsigned long syscall_trace_enter(void)
 
 #ifdef CONFIG_AUDITSYSCALL
 	audit_syscall_entry(syscall_get_nr(current, regs),
-		regs->r16, regs->r17, regs->r18, regs->r19);
+		regs->r16, regs->r17, regs->r18, regs->r19,
+		regs->r20, regs->r21);
 #endif
 	return syscall_get_nr(current, regs);
 }
-- 
2.55.0

