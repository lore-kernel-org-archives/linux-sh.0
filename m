Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5666376490
	for <linux-sh@vger.kernel.org>; Mon, 18 May 2026 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124273; cv=none; b=X+VePCUxAQOFlSJi/B/aKen+Wkt8kdqj3CJ0Dnn5yJ/ej5Kq9DuXctq3c22s8vHXnV1Hu1rdyYqB3jZ7rI8TziikxwMCEsEyyDcNIVzGW91sLLiCPNDTMK3I73lsHB6fFWHysAMdIvVwtYvOR+W2d2Pxln71nZ3H+FGu5TYmKPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124273; c=relaxed/simple;
	bh=gHcFIxHS+uzmMbMxDDVfnDjk70QhFruRR+TTL961w60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDUK/PziAKpV0lT4EiXne/nCPB23VpdXDlXmDyVUSkgjk3cLfJmedVGVxtr7YcoHVmFYJgYuROh5hY0XGeNgubG2hx63l0HcwRCghMSf6AU7DmcuTY39XLGdJORmPxao3FYLDzvj3T4CScLW1ht7q+S/E87mwiQJzPmVNBGTrzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dlc9Lr4n; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dlc9Lr4n"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779124270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5SkA2dJFz80GQZbru+VwXcVcV8tgtPLqZ7+EHwJPQA4=;
	b=dlc9Lr4nh4puN4Vdbql1uSTXLhU+AleGPOj0CoZ2GGZN4ZEC26LuDIFL49ZC34U5+sQKav
	ERq2A9O1EjesY9F2kEHTcMUzpJa6CTlwu13WDCwAMR6mRpeO7U5vSyV5hq0IX0Myp2mWzu
	kWA+Y6QedWaUb1+3UUAJJiQu5GwjWd0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] sh: dma-sysfs: use strscpy in dma_store_dev_id
Date: Mon, 18 May 2026 19:10:42 +0200
Message-ID: <20260518171040.81917-6-thorsten.blum@linux.dev>
In-Reply-To: <20260518171040.81917-5-thorsten.blum@linux.dev>
References: <20260518171040.81917-5-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=918; i=thorsten.blum@linux.dev; h=from:subject; bh=gHcFIxHS+uzmMbMxDDVfnDjk70QhFruRR+TTL961w60=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFncHuKrrn898ajMSvQNkwqr0cqWVf/e6p34JvX3mcVk6 2MGy5t1O0pZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAi2yYzMnw5/LHi896nYifV FCVO+Wntezzz/BX7dT5XDPwNDunXZl9l+MloIazv8rs1lYM/3eegpN/WLVETfpo4WvNNcCve4Nu 5hhEA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() has been deprecated¹ because it performs no bounds checking on
the destination buffer, which can lead to buffer overflows. Replace it
with the safer strscpy().

¹ https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
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
 
