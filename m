Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="clQb5MA1"
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52315170B;
	Tue, 28 Nov 2023 22:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=GG6HhlQP9nDGltk5Zu
	JY29M8VLSt3lTWUXWJisYqeaw=; b=clQb5MA1av1RwF+U/rELPz3wRAyob3DRP2
	xoUjrByk+x+nNcHZQQCwy5EqRQEGFCLQH8LCF9fQ4bOnXGcs9zFGzzFTUtvYV7+0
	QxC8uk/dogawbJ6qPlQ/R4rlXOcyt9JgalrVITsz1aTZqTpXpeVG6x/pKoCzv4DC
	eEBeabQ3s=
Received: from localhost.localdomain (unknown [39.144.190.126])
	by zwqz-smtp-mta-g3-3 (Coremail) with SMTP id _____wDXDZMs3GZlqeoVCw--.42552S2;
	Wed, 29 Nov 2023 14:37:34 +0800 (CST)
From: Haoran Liu <liuhaoran14@163.com>
To: ysato@users.sourceforge.jp
Cc: dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [sh/highlander] psw: Add error handling in psw_irq_handler
Date: Tue, 28 Nov 2023 22:37:30 -0800
Message-Id: <20231129063730.31184-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDXDZMs3GZlqeoVCw--.42552S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyruF4fZFWrJF1DWF4rXwb_yoWDXrg_Xa
	s3Zws7Cw1fAwsIvF1akF9xG34fA3s7XFyYqa48Xr12yrWUKrnYqas7tr4kJr48Wr4jyrW7
	Jryku39Fy3ya9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_VWl3UUUUU==
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/xtbBcgU3gletj4wvsgAAsm
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>

This patch adds error handling for the platform_get_drvdata call
within the psw_irq_handler function in
arch/sh/boards/mach-highlander/psw.c. Previously, the absence of
error checking could lead to unexpected behavior if
platform_get_drvdata returned a null pointer.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 arch/sh/boards/mach-highlander/psw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sh/boards/mach-highlander/psw.c b/arch/sh/boards/mach-highlander/psw.c
index d445c54f74e4..e079215e50e3 100644
--- a/arch/sh/boards/mach-highlander/psw.c
+++ b/arch/sh/boards/mach-highlander/psw.c
@@ -21,6 +21,12 @@ static irqreturn_t psw_irq_handler(int irq, void *arg)
 	unsigned int l, mask;
 	int ret = 0;
 
+	if (!psw) {
+		pr_err("psw_irq_handler: No push_switch data associated
+			with platform_device\n");
+		return IRQ_NONE;
+	}
+
 	l = __raw_readw(PA_DBSW);
 
 	/* Nothing to do if there's no state change */
-- 
2.17.1

