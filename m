Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="J9DwR28a"
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC9A219BC;
	Tue, 28 Nov 2023 23:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=sY8yr857R8VHDvrkt0
	s1ifvVPgK5Ibl5ySBhctpkUvE=; b=J9DwR28aKP99aETr2iBC7oR7gBkMMQst+K
	sXG6Z+jQzFoHx4sIu49JJVYJq+cdWQtxh6ZhJCCnQWXinzsUL732E96L/mYMrFIg
	A29fJN+hk2EuHRz6pU3HUXNowoLVxfnknzc+KjsgdMgF9CFKGAXMTBlB0vf7ggJa
	dftVvvx6U=
Received: from localhost.localdomain (unknown [39.144.190.126])
	by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wD3H5Nc6mZlRNtgBQ--.14956S2;
	Wed, 29 Nov 2023 15:38:06 +0800 (CST)
From: Haoran Liu <liuhaoran14@163.com>
To: ysato@users.sourceforge.jp
Cc: dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [sh/highlander] psw: Add error handling in psw_irq_handler
Date: Tue, 28 Nov 2023 23:38:02 -0800
Message-Id: <20231129073802.31874-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3H5Nc6mZlRNtgBQ--.14956S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyruF4fZFWrJF1DWF4rXwb_yoWDXFb_Xa
	s7Zws7uwn3AwsavF1akF9xG34xA3s2qFyYqa48Xr12yrWUKrn5Xa4Iyr4kJr18WF4jyr4U
	JrykC39Fy3ya9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMpBTJUUUUU==
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiwh83glc661bqDwAAsd
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
index d445c54f74e4..fa18a56a0894 100644
--- a/arch/sh/boards/mach-highlander/psw.c
+++ b/arch/sh/boards/mach-highlander/psw.c
@@ -21,6 +21,12 @@ static irqreturn_t psw_irq_handler(int irq, void *arg)
 	unsigned int l, mask;
 	int ret = 0;
 
+	if (!psw) {
+		pr_err("psw_irq_handler: No push_switch data associated "
+			"with platform_device\n");
+		return IRQ_NONE;
+	}
+
 	l = __raw_readw(PA_DBSW);
 
 	/* Nothing to do if there's no state change */
-- 
2.17.1

