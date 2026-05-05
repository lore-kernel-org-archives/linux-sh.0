Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE6F1F03D9
	for <linux-sh@vger.kernel.org>; Tue,  5 May 2026 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777992822; cv=none; b=m+wEtGQjMTdSVoKYKjihCD8GO4wAxAsWRaqdtPnUhkhGPhKP9zSUtTiSpnKtmEOS7V7y/O1g8MW38iaQkJ6oIrrKt3R4iCz2hviwdTSaRU7KZ+hduJo4SwEdJo7fGHn2g/QQbroOttcAX6aMcaKTEazMEFzRh9dq6++mNN0lhU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777992822; c=relaxed/simple;
	bh=rcQ1ngOf+t5aJYmbkxuG/YXhZkADgaeLqmIK4uTISW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+8Y6sB8g/Fr3ZQShXFpd1rofcNuodNrcBcA/gCp9e4MRJcZ+e1Q7kS8KLKu0kfwYvDRz6KZZHTbNaVtRmFfxNbj9QrEBtL8zpVZcssECbq6HQjeKXhMeJvwRzN8/sErEfBZ4GNtXPpcW1zCPG8h8S8P55ShZj/Bs52xojdR248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jPUCIIHW; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jPUCIIHW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777992818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y7oSfrQ7dQXBUTvGr+M49+wbahOEfOGRn1VBj32kCjM=;
	b=jPUCIIHW6QCt4uW7s9Ubusj1SGGCc5oMISG/VXh/2OcW1xtawKuLpqMrvMkd4CxJRRGeOd
	4a1W1hK6xCLhjQIHXcKDF/o4LnOyX6YgLudaJke40boXDHt/biEq7ZThBu8wSe2YIi92YQ
	ns4fom4DvWctJh2hlJ9QgpcerGu+utk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>
Subject: [PATCH v2] MAINTAINERS: move Yoshinori Sato to CREDITS
Date: Tue,  5 May 2026 16:52:55 +0200
Message-ID: <20260505145253.165736-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=thorsten.blum@linux.dev; h=from:subject; bh=rcQ1ngOf+t5aJYmbkxuG/YXhZkADgaeLqmIK4uTISW4=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJm/WFxn24hqz/mVuE7K4tyhHGnN7C8nRfn4PwomTe9yL LcXlFXpKGVhEONikBVTZHkw68cM39Kayk0mETth5rAygQxh4OIUgInsaWL4w3dk7ftUv6cC/xw4 F8s9XhR4UpjLJGSW7Ry7XZKLc3sW7GNkWLtb68g8DrlXc8/WmD7lcnK/rPwlW1fiRnLs1u2d/8W rOAA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Yoshinori Sato has not been active for a while and the listed email
address bounces. Remove Yoshinori Sato as SuperH maintainer and add a
CREDITS entry.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Add a CREDITS entry (Adrian)
- Drop the https change (Adrian)
- v1: https://lore.kernel.org/lkml/20260505132755.161800-4-thorsten.blum@linux.dev/
---
 CREDITS     | 4 ++++
 MAINTAINERS | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 17962bdd6dbd..09a7b66986b6 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3628,6 +3628,10 @@ N: Dipankar Sarma
 E: dipankar@in.ibm.com
 D: RCU
 
+N: Yoshinori Sato
+E: ysato@users.sourceforge.jp
+D: SuperH maintainer
+
 N: Hannu Savolainen
 E: hannu@opensound.com
 D: Maintainer of the sound drivers until 2.1.x days.
diff --git a/MAINTAINERS b/MAINTAINERS
index 882214b0e7db..aa5176112058 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25744,7 +25744,6 @@ F:	Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
 F:	drivers/watchdog/sunplus_wdt.c
 
 SUPERH
-M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
 M:	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
 L:	linux-sh@vger.kernel.org
