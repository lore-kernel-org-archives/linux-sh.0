Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E361923D281
	for <linux-sh@vger.kernel.org>; Thu, 23 Apr 2026 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776982635; cv=none; b=ctfGSphLyux+B/a9JH7SU0gCxsZ+qFpoPybIU+8t9zXeKJ+nSFC0sDs3Lp0ftEz5O7XuHe6lXHp68YWghDMGVHl0CG4rd4kxTFqWfNDqtd7CohLBLKVCfWUEGYN9ZnWkn1wQn347EZ0dgOhfgLDoC9t3innDCgWkhlfL6/fFvTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776982635; c=relaxed/simple;
	bh=aGUP17n9uuI6ThJZOdlvgxqGQNTx15AIMIpOnwoSP2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QO6ZsL+VRtZB9uDiHjrtyV2AkMFN0glS69ZManZL7Z/k3106GjDb6pjyrqkDnY+PwfjzS+t46fG2fuZzXOR7blAqYapuiDD06XO7JFArEY1I5HzncHznuRLZIKN5OS9Nsoii1Kpe915Q4HOqDhKHnH4XHEPddjvWv8tfws99Toc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rQBTA7eL; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rQBTA7eL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776982632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VMh8FEMLKMAW17nyiVN2jX1QeY54x6FtwDW0ZG81DIs=;
	b=rQBTA7eLs1QgPYVj7KIK+jAzGgezCIc8D0KHLHVpKClcTBA5VqZuDvSScf7BE4lqY0i+A4
	Gajv+ggbLdZ+7fe4JhhIhD7S7jpMIuNim647ytvZvj3gLzEHI205m0ekn5EiZdMP6DpyDc
	JhzjeHbuQwgo/j2nRhto+KK+ts7lkOY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Florian Fuchs <fuchsfl@gmail.com>,
	Artur Rojek <contact@artur-rojek.eu>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>
Subject: [PATCH] MAINTAINERS: add GD-ROM driver to SUPERH
Date: Fri, 24 Apr 2026 00:16:29 +0200
Message-ID: <20260423221627.303146-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=544; i=thorsten.blum@linux.dev; h=from:subject; bh=aGUP17n9uuI6ThJZOdlvgxqGQNTx15AIMIpOnwoSP2g=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmvZlkn9O9mrTn1+v6RTJZzi989XtkrH96hxtDN2v+od rnHB6O5HaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRTyIM/6zaHX5duPV70vm3 X2//0Lsc47VVVTR87+rW5X8/LrgadaKKkaFPX2fygR1VHiW5TCv0WxtyBc7ZpsYuX79+4le29Mq j6swA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

SuperH is the only platform where the GD-ROM driver can be used. Add an
entry under SUPERH accordingly.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f031c86b37d2..584ac256d239 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25801,6 +25801,7 @@ S:	Maintained
 Q:	http://patchwork.kernel.org/project/linux-sh/list/
 F:	Documentation/arch/sh/
 F:	arch/sh/
+F:	drivers/cdrom/gdrom.c
 F:	drivers/sh/
 
 SUSPEND TO RAM
