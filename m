Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FDA3E929E
	for <linux-sh@vger.kernel.org>; Thu, 23 Apr 2026 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776945913; cv=none; b=ANe7p1n4u9NgyK3TZ5HULurJO8c9BJ3Qzp84XM94f1mACDfHjM8h0crrMksWRxgp5iZMS5SCBhW5QaMnRSVlSJEqEk3bzJHefyVBoMUp4h+0HBcxQmBN67L4NSSYMD0lEHiOJZ5tMoeAGqzZad0jKg0QEX8QS3ontgfn6mZioHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776945913; c=relaxed/simple;
	bh=wuL9cGucZxMkHpVY+zF4yLAmTMoJOb6bCA8faIzUBL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvN+Ub2pEsyMdGd3/+gcUctS6YVJOklPf9DPVy5BoiHW0Ccdt5+Acdui/Ukv+YTMIGFKQ2pzE3Ya4H5tyKfuUNexGKvMJID6LKcWK+IQOpOzKv7vAg5uFGRRHo4jAJBgTiGqdm5h/ta9dcV+esBoBtLg2eP2cFs5qBGO85E+5xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bJL2cdmc; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bJL2cdmc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776945909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b2/kD7CX88KbW9/qxpDOdDaEVHtB14vcEeoRQqxsTL8=;
	b=bJL2cdmcwGhZp1SFkU3Gw72NjtvRifyWFrmSQdl4+BfN//KpEk7yEpxwyh86Oqgt8OAEw+
	GXiufS3y476EuO9lmmWb4DoF1alwO812gjwbNGc8S/EOZnkZntQq+IqkHUkVZ8SRRaYnfx
	CCc7qsY9nU5EQG7wfoyOZBL5vUKhnuU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sh: use sizeof() in memchunk_cmdline_override
Date: Thu, 23 Apr 2026 14:04:42 +0200
Message-ID: <20260423120441.212278-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=744; i=thorsten.blum@linux.dev; h=from:subject; bh=wuL9cGucZxMkHpVY+zF4yLAmTMoJOb6bCA8faIzUBL8=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmvuG5OnR9j1Oh+LleT1SchbwKHpGfBh0nsm3M4TCdaV xwsabrXUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABN5cZCRYfqb5VfYdEMDX9sa KDdsnVFxcr7pp+TUMNec22br9zQ/N2JkeCfRk3ygpFfsWNnFftOrSrx8JeXy0Z9+b/9s+Fz89Yo KTgA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the hard-coded string length with 'sizeof("memchunk.") - 1' and
remove the comment.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sh/mm/consistent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 0de206c1acfe..8f3a5bcbccfe 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -23,7 +23,7 @@ static void __init memchunk_cmdline_override(char *name, unsigned long *sizep)
 	int k = strlen(name);
 
 	while ((p = strstr(p, "memchunk."))) {
-		p += 9; /* strlen("memchunk.") */
+		p += sizeof("memchunk.") - 1;
 		if (!strncmp(name, p, k) && p[k] == '=') {
 			p += k + 1;
 			*sizep = memparse(p, NULL);
