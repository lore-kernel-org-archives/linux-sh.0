Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A3B282F3A
	for <linux-sh@vger.kernel.org>; Mon, 20 Apr 2026 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697940; cv=none; b=UxFTfreEXXyQAFl4es75civXVicKwumHNlRt9V6Ujimmdirl24L0yIngoPzQZ5kD6Q1nXaLw5Hr6HzuTEw3Man0ET9Wc94haN3QsKDll/KSkCAkOm3RTBToc62omMqU0ULjoyZKHGNjUDpBfms7UZqPwPR3DcLVGBdOyaLKTJx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697940; c=relaxed/simple;
	bh=ctPUIrAH9YIrs+dB61Kdw9Q3GpQNS20K2i5gKBVHkBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6FYL8UYldXS7kJBXBWJ7aNAvB9WoEbcETOjsRF3Ii9xQAihiUsQNJZ1c/sr5CaIkiKUxd5tsR40O3ekW9qfV8PPI2tgHR7s65Gck3rjya+hcHC+nFicV528uPqJoTxswV7uci/pWn0sLSLBsC9uLfunouE3yr6aH0LvKFfN4yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nwcwWtYH; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nwcwWtYH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776697937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/WympVL8LZPKmrYIY5YpPMYJgYP4GwQNqb10OZW28E=;
	b=nwcwWtYHNesJx1M/jfaJHySVNv4srew93nQ/b6AGTJB1qpnEfdTMXMaRhfM0Ne5Fn6+bxL
	O0g0Q2gMYrzpVP+IwiIx0mn/f3Gx89xyZ3juPb47aiXz80DqMYYUWH4h4QX9WHXyc5iIsC
	D3P3WwnY+7IGLPRnrIjyY2dlWz7TbJ8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] sh: dma-sysfs: use strscpy in dma_store_dev_id
Date: Mon, 20 Apr 2026 17:09:59 +0200
Message-ID: <20260420150958.17072-6-thorsten.blum@linux.dev>
In-Reply-To: <20260420150958.17072-5-thorsten.blum@linux.dev>
References: <20260420150958.17072-5-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=thorsten.blum@linux.dev; h=from:subject; bh=ctPUIrAH9YIrs+dB61Kdw9Q3GpQNS20K2i5gKBVHkBM=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnPHM8e6ZVkbHgp8e+u3+tIk4eMpRLzihoW1S/tiVixZ mqQzDXVjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZiIxw9GhvOdLQsb1oS8uFf9 5dG/Q6HiPxlKRRP+3dg690VunMYGZyOG/zk+Mx+9/fXqgEblnAufvD5eLdu7nzPlvZupfdz9yU+ FeBgB
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() has been deprecated¹ because it performs no bounds checking on
the destination buffer, which can lead to buffer overflows. Replace it
with the safer strscpy().

¹ https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sh/drivers/dma/dma-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/drivers/dma/dma-sysfs.c b/arch/sh/drivers/dma/dma-sysfs.c
index d4e16cfc7a12..d1d6b9bb0d7e 100644
--- a/arch/sh/drivers/dma/dma-sysfs.c
+++ b/arch/sh/drivers/dma/dma-sysfs.c
@@ -74,7 +74,7 @@ static ssize_t dma_store_dev_id(struct device *dev,
 				const char *buf, size_t count)
 {
 	struct dma_channel *channel = to_dma_channel(dev);
-	strcpy(channel->dev_id, buf);
+	strscpy(channel->dev_id, buf);
 	return count;
 }
 
