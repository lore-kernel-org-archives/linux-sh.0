Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6773844BC93
	for <linux-sh@vger.kernel.org>; Tue,  5 May 2026 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987766; cv=none; b=EJIb2qNlxgdXhOGHWlDzavinB8Al9zZn6yTmEI5LAPKPiChLuq1Sn5HF3NxRKzO8vsGL6ifaErfu7ms9rdsy5CzAYqxAPEaYXqQEDhmiKbD8GDvLzaZlI0OGmNGxW/RVE8Qm/uv9dPTS8E73AxoiRdjgKK50Tnhh2ODE8Eu3M+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987766; c=relaxed/simple;
	bh=RvXCtYdYTUDHNr22uibCegqP95MBUEkZOwlJaWDt9Do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RnAauFymvsCiXVstJ/MvkwrexQXDKXEkx+o/bzduPS5UnvLjYtQ7LXEG0t/PZtDGOG0FJkCe2w4z7aNe5BUQhO6rtMqCOR2Ce2VBjrN4A+PrtW9Zhz2gmb7Dev6XcLsmtRJVIjUogolL4Q6f3srl6ZTOjpKwaYPd4chxCsO2kOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p6BMJaSj; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p6BMJaSj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777987752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gSZavFUgxLH9ocOf5jg9NbXlWUki2bAcScH4jU/hfWo=;
	b=p6BMJaSjkmJAu7N+s18sBacZivUDGCwMIOcKlG6/gcVta0L5mIarbHyjzPVFX5yr/hBv7i
	7a5lF+fjfwuXVdMrF/itRt1Cxpoi4IMOADoQZZWmrLVguLbZe8pSDIMnywmuDKElk/8ICV
	fgDTANhTcxWnI3SSxdHWdLHdx9tRxcg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>
Subject: [PATCH] MAINTAINERS: remove Yoshinori Sato as SuperH maintainer
Date: Tue,  5 May 2026 15:27:57 +0200
Message-ID: <20260505132755.161800-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=thorsten.blum@linux.dev; h=from:subject; bh=RvXCtYdYTUDHNr22uibCegqP95MBUEkZOwlJaWDt9Do=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJk/P0RXHuz+NMXZOa1M5uTyK7aZ9fI2Qo3er+9NnTpR3 fp4qce3jlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZjIE1eG/37ZsxdOPC4bz8Th vyt6jfzsiccq7x/kujr9cuOL4vnJq40ZGfqEvvPee3eYr+hsS5uE08ykdOfSszqzSy899t1eVpj +hBkA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Yoshinori Sato has not been active for a while and the listed email
address bounces. Remove Yoshinori Sato as SuperH maintainer.

Use https:// for the patchwork URL while at it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 882214b0e7db..7d6c3ab9e7af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25744,12 +25744,11 @@ F:	Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
 F:	drivers/watchdog/sunplus_wdt.c
 
 SUPERH
-M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
 M:	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
 L:	linux-sh@vger.kernel.org
 S:	Maintained
-Q:	http://patchwork.kernel.org/project/linux-sh/list/
+Q:	https://patchwork.kernel.org/project/linux-sh/list/
 F:	Documentation/arch/sh/
 F:	arch/sh/
 F:	drivers/sh/
