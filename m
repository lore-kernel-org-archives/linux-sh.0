Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E71381AFC
	for <linux-sh@vger.kernel.org>; Mon, 18 May 2026 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124274; cv=none; b=gtWW8kF961+YPLlmcX5yw1MxwMqf3IRGHUp2g094eCcadkfefSWfOHFOpndSZEngUDSYJRBADw7rFDZc5Vtn39m7l6onji4rzwoRLqS/RXUd1dI4zf48n796kjZhR5X3YD9I51UGTeX8XeU0ez9gz/yeW0na/8z8GBbE+Lhl1aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124274; c=relaxed/simple;
	bh=RHwR0XLMX0h6ZOG0tw5AW8ldgKfGKRUEc6Qy3cEpaTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paqT3cMg8dhAbdQZoYHwsdntr4FTo5aL6jsfQrCXppegheJw0/zVouGfC8Le0KczSLPIcHhJfQq0h3MriV85vk5GLqEPb6fBGLOCLb/6G+PCPZxaSAf4yybvW3LWw9rAVJhYbH6vVIJyP8OeDzwwEmTqEtRXxgEA9U/LiLfnjeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XXGoaK6D; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XXGoaK6D"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779124272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BiigflQZoBKUXM0Z8RF9f73Zc0sMQG4tbSQ7hohtZ2g=;
	b=XXGoaK6DgWfFvDgvyWjBxUNmQBpMm5c18d0fqsDAyDvLyrQ2v1LBzsSFfqssJA3dZdJGZS
	1RiU0RLMBnybeUo2SV8pnqeWtmFR2git+f2Xt7gKY/jfIW64R/ZFB8nQGgIDAUo43QrvSH
	sBh5XSs2TSPydJyla0R+S9bYHxZ9Q1o=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] sh: dma: drop redundant size argument from strscpy in request_dma
Date: Mon, 18 May 2026 19:10:43 +0200
Message-ID: <20260518171040.81917-7-thorsten.blum@linux.dev>
In-Reply-To: <20260518171040.81917-5-thorsten.blum@linux.dev>
References: <20260518171040.81917-5-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; i=thorsten.blum@linux.dev; h=from:subject; bh=RHwR0XLMX0h6ZOG0tw5AW8ldgKfGKRUEc6Qy3cEpaTI=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFncHpI6dXbS5q9V3ed7HhfbwT3x8DznH+r9h0+4vPc9e rN7ld+UjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZhIIwMjw369sjd7Lz5zvMWu daOsQzlRPDFkkncax+2KM/ckYnRSXzP8M2O77/RdJLAnvGDd7aQd95j+hCnO6d98zPZRyG7+K6W iHAA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The strscpy() size argument is optional if the destination buffer has a
fixed length. Use the two-argument version of strscpy() to copy 'dev_id'
to simplify the code.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sh/drivers/dma/dma-api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
index 87e5a8928873..15e2c10c9805 100644
--- a/arch/sh/drivers/dma/dma-api.c
+++ b/arch/sh/drivers/dma/dma-api.c
@@ -96,7 +96,7 @@ int request_dma(unsigned int chan, const char *dev_id)
 	if (atomic_xchg(&channel->busy, 1))
 		return -EBUSY;
 
-	strscpy(channel->dev_id, dev_id, sizeof(channel->dev_id));
+	strscpy(channel->dev_id, dev_id);
 
 	if (info->ops->request) {
 		result = info->ops->request(channel);
