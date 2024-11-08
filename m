Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0D518B09;
	Fri,  8 Nov 2024 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083224; cv=none; b=mfMv/BXM5hKPyUWlgQ8rIXkBuOOFl19TFH7/6Nq9f1lE7cJLPb5MzfGj4C2TOd921CdisD4sBrr49AX14JalijFXZa5HcR/cvVL7vFRc9TrZeuehIo1zHKRDYDhNi9Dwm2yg218X22sqOY2aT9GOB2Qp0/NXiPMPoqvUKwNGkoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083224; c=relaxed/simple;
	bh=DfJHjYOmAlsVRCI3XeE835lwR8vvvm3fLeD8TiDrT+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kHHLyqYUmrQWR+i72akcKplyIbmiz55yAn6G292X238OfRIruJWnY9Jk6U1KgvWDYHU9u7q0pTgknZgNYiAtaE9fZcOMLDLPuT/op6zKdCR68Ddmhzk/8KEek4awzBwNJ/nayOb0R73elR6bWog8rH3+fI45m4oF9lfhnqapSIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AJivxkt7; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AJivxkt7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=tU8wN
	nXs4Z86o4ooMpHEHHRtJBNcDoExw/myy03v5Uc=; b=AJivxkt7Xccg3s+HffUVa
	e8lDtHOsPug5AkgCjW3LaEoCR974kLgfuKwvXY+0FoijcTedN5IrSX/BVeCzDfNh
	oFG5vrco9VgPimv+TtXvFRwZ1gJyqZxFm5UB74sWGv3qMxx/f+HK1UFdsYsB9dOP
	8eIdAQvOkq8SMvlVk+ARVQ=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3__a8Oy5nDCbuBA--.59255S4;
	Sat, 09 Nov 2024 00:26:43 +0800 (CST)
From: David Wang <00107082@163.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de
Cc: linux-kernel@vger.kernel.org,
	linux-sh@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH 13/13] sh/irq: use seq_put_decimal_ull_width() for decimal values
Date: Sat,  9 Nov 2024 00:26:34 +0800
Message-Id: <20241108162634.9945-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3__a8Oy5nDCbuBA--.59255S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gry5Cw1kJFy5tFy5uw17Jrb_yoWfJrcEga
	s7Cw15KrW5X39xtFyjk3Wft34qy34qvr9Yka4I9FW0y3ZxJw45ta9xJF4rJr1kWF15urZ3
	Z3s5Zrs8t3yIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_ZqXDUUUUU==
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0guRqmcuN-c5-gAAss

Performance improvement for reading /proc/interrupts on arch sh

Signed-off-by: David Wang <00107082@163.com>
---
 arch/sh/kernel/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index 4e6835de54cf..9022d8af9d68 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -43,9 +43,9 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	int j;
 
-	seq_printf(p, "%*s: ", prec, "NMI");
+	seq_printf(p, "%*s:", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat.__nmi_count, j));
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat.__nmi_count, j), 10);
 	seq_printf(p, "  Non-maskable interrupts\n");
 
 	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
-- 
2.39.2

