Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E973F1D7E21;
	Fri, 28 Mar 2025 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743157418; cv=none; b=mW5mCsJzi2wF+MatAqjwXBrbR6bmtdNvedKr68syQfqQkMFWxfvOjTYlFoHNdpfNZFSqZZvYJXgsFKWO8SiJ+wVGXnkIKJjNFbfe3IFNobO7WgK/++vmA5kOThlaLtwzomB0TtlMhNkSwO7eXzpmXBQhGufE1ekVZVtf1UfNjaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743157418; c=relaxed/simple;
	bh=kfnA0dse3vgZ+fkK7/yQkYuHHTaaxE5askDA+8RMtOI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=AVxYM9KjYbfkHxDFtNUeP4PBI5wAxqRNi5YTzS5cTG+Y7cRJCs+ycRUnlfBkws3DR8ZMyvY3U372pIcfCxVkH+/Wpe3yp4xMN8wNqRq/hMmgtugEXtbuBQAq5D68+Pv6ucULTeKttL/uS1UkFm/+owIjlCb665craZKfqr1/yCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=wzoozC5J; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wzoozC5J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1743157107; bh=H2OTz8qixQSaNYMYOwPN0zr3Spnwqzfy6K+SC7egpi0=;
	h=From:To:Cc:Subject:Date;
	b=wzoozC5J5Zs7kwXxyhsn82cmtx415X86A3m1UJQ6SALiSXk+tCg2tAG5/OUlk/cTK
	 hf1RNxs9XLy2v4phSGZJKrN7nOJk3q9JbtDmTPfYVs53G6H+SWga/YWgbr7C6fmbDP
	 WllwYWpoPS9N4hDMQQbrNxfXw1bB2hMETlOjAfyY=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 48F3BC99; Fri, 28 Mar 2025 18:18:15 +0800
X-QQ-mid: xmsmtpt1743157095tkan4cn01
Message-ID: <tencent_40B6A6E7C79AEEEFEC79A07DE00724909A05@qq.com>
X-QQ-XMAILINFO: N+tZcXNNUKPOq0E9fe2tInSMWeGR7AoKa9CfwgyWxam3RDeGnbizC0ptDSI3QN
	 1ARp8tXQwHqJGGNx+qDidrqn3GSLqIJCA7wf1X+0YEkfLm7aL/J7/GbHzFCgAX68+L+ymbrCu6Up
	 G8Y5ytwIulU/PbiNmGVLk00ajkY8m5Y/ZPkR0RbMpZuosL6f7Po7OGWgevShtf0uq9dpB1fLNQjK
	 8CDyNeya8aYkgwxMNHbN3hdrnkn40IGu2hPa0NCP4Ji/pjiloqLrtN3z3xyHmn+16C/48ngaUoV9
	 N3fCvlYtlTNrjDehAIbuiclypNvAq1NxIeoq6Pvjr7rqQ1AAYl1MpFaPJl63n90BkfKZUMu5zr5Y
	 OrzcQfeaz0qMFCPTn/uIRAB1STWWI8GlB/N8St2r46paTE1kHD0NUtp+hFKqEqe6AhjFtgh2A3oR
	 BzuBfKYitBOC6T75WZT6PxizIE0zrj2kCnUG+fNzjoUYAwDBwIIXMFg97w7pER8PrBAcivYcf4cS
	 XIurcpjMFseJ50nohhEp8iFF8sR9kiPeXD/iR9eVH4OR/rmFeXsXV3C1DR8yQSHPv9bgYBqgyWOe
	 dkfRbNdrB9qPjqELvi3ycic+w2ZibX5QptwEOK8OthFXo5QlP9X+KoOJOoPONdNiBNRwnGDgbrzg
	 wbIStjkEno1+nsz6vwRauN28Bn//LoVKIHAl6xNCXImdHvJD4k+A0ww+4nHbA+VTU/T9WjBfTWo0
	 NwsJgV9F/2OYo3B7indAoG+5fvlCrgqJCz2uIC1wOujf8RP37xCEI+DxK6ucQ9YL7vBXdSqAnHCR
	 wUtlkb0u4/T/EnRYT6ni/sBocqv0do2htnslkqDWkzYmycG50xX/VZAsA7WU0SqpRe9VmXkIZ97M
	 J/8Ds09TwQoHpQTaxbHgPn0/BIPV4MkRtWpWuHC3Wf5GuhKknhDuWQ2X2CCLnydza2R8/jKbybnI
	 CaoXYe34zqCltPvXyB2Oc7j4b4GyrIeJU/YxsEUpGlcV/iN1W2HgMKrzGufcsB
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
Sender: yeking@red54.com
From: Yeking@Red54.com
To: linux-sh@vger.kernel.org
Cc: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Paul Mundt <lethal@linux-sh.org>,
	Pawel Moll <pawel.moll@st.com>,
	Stuart Menefy <stuart.menefy@st.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] SH: Kconfig: Fix help text of CMDLINE_EXTEND
Date: Fri, 28 Mar 2025 10:18:11 +0000
X-OQ-MSGID: <20250328101811.53017-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>

It is the bootloader arguments concatenated with the given string,
not the given string concatenated with the bootloader arguments.

Fixes: d724a9c9d572 ("sh: Allow for kernel command line concatenation.")
Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
 arch/sh/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 89185af7bcc9..81e5e205416e 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -727,8 +727,8 @@ config CMDLINE_OVERWRITE
 config CMDLINE_EXTEND
 	bool "Extend bootloader kernel arguments"
 	help
-	  Given string will be concatenated with arguments passed in
-	  by a bootloader.
+	  Arguments passed in by a bootloader will be concatenated
+	  with given string.
 
 config CMDLINE_FROM_BOOTLOADER
 	bool "Use bootloader kernel arguments"
-- 
2.43.0

