Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530830;
	b=UkifYkaYuuEj/2WItc+XXMQk6T55e6kYcUYv8S06AOGc5Z01MZsyeHMc7TdQyuH4UvdA
	 w7Ix3om3J4aAE9sofrNYdOFbbzdqAD+ce6fmkhrUrcTf5jpWmhUaU0lJChaI6KRCvOa8I
	 /5Lb60aFevVTEU2FoAQaYdTAxTtUiKFouskYzJzRk2f+9MlV1RQOXE/rHNQaxxA5Y5fUq
	 DrvVNC02G33dPgRkv7BkyoADmODfRPho9QvPrFww6lmNUcl8yLpcloXz83L+VUDTVM2Os
	 XL4Ib8sgDm3v8BDrtzZLCA2MGA0s4CDRwASXrwV5tsnK1XlHKBxbR1cK0K2xZrGXIeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7I1WAMcxDD9LAaZGydiMYcIYX5l8KkL2IW6qjlzuVEo=;
	b=E3Aqjx63pf098Q5RZoIiBQb88hpoABTEfMIXchMr5wDV7+9xrQhd8ZSulpxRq/92ChbW
	 88PW6eSXhI8rsrj7c2D28jJAJ0xeIfSe/0B2E0ikMYhmJRdkzjBhBfUV1AJS1vEM3qqNF
	 NxwF7h4nwQwjJKmRrEBKwyQTjZAtxaGNzrxMlrT8Rq/A53Q5WZ5wjtgQ1U3xREFmh+crG
	 qi9Rq8HagWWslZOMdRl2hLkwyQwk5BLi73dQTG0FSVjMLeD6z+d5ScIN3OwtS3tO1u+oE
	 /AbuUZBGfKKJ2RDcuLsX6P7nQTdekxbTJfx5aNqpLSWEejq9VKMiUdsKjOnK/xFu4Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVXBw8+u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41815606A327
	for <linux-sh@vger.kernel.org>; Tue, 24 Nov 2026 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVXBw8+u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FC71F000D0;
	Tue, 24 Nov 2026 14:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795530829;
	bh=7I1WAMcxDD9LAaZGydiMYcIYX5l8KkL2IW6qjlzuVEo=;
	h=From:To:Cc:Subject:Date;
	b=YVXBw8+uWmqlxr6X37MxcdIBATXfPtoELvgKeabIlzRPxBA5XusVQH/WbO+k2//NW
	 wZ2BHSPuP6LEqGVJSfygjzkUN0oDbwjSsZdHALCJU6U0oNxUQBS6MIT8rudGXeXivc
	 owUG/LlvF2Lt+d43w5ONm861u8KsWcdb48tlj530Wn6G/7rYTvaD5Kj0zMnhOb7L2y
	 k+oKKpWs1l25KW2PIyQYzbn58mOocEmElK5i/NqLHLolNNTsJ5j5ZNsOHN68ui2K9u
	 ct9gFp2rkWCj2p2gKVPUeGL6XzMPsfc3hUF4C96qg6UYuKFYZvVFgHm/uFSaX6S0QQ
	 yAdnNxi4pP3Vw==
From: Arnd Bergmann <arnd@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-sh@vger.kernel.org
Subject: [PATCH] sh: rsk: stop including linux/gpio.h
Date: Tue, 24 Nov 2026 15:33:07 +0100
Message-ID: <20261124143333.3197625-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This is one of the last files to include the old header. Drop
it here so we can remove the file.

Cc: Bartosz Golaszewski <brgl@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Ideally this should just get folded into one of the patches
in Dmitry's series if that makes it into 7.5, otherwise
please apply just this one.
---
 arch/sh/boards/mach-rsk/devices-rsk7203.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/mach-rsk/devices-rsk7203.c b/arch/sh/boards/mach-rsk/devices-rsk7203.c
index e6b05d4588b7..eb56b57812bd 100644
--- a/arch/sh/boards/mach-rsk/devices-rsk7203.c
+++ b/arch/sh/boards/mach-rsk/devices-rsk7203.c
@@ -10,7 +10,7 @@
 #include <linux/interrupt.h>
 #include <linux/smsc911x.h>
 #include <linux/input.h>
-#include <linux/gpio.h>
+#include <linux/gpio/legacy.h>
 #include <linux/gpio_keys.h>
 #include <linux/leds.h>
 #include <asm/machvec.h>
-- 
2.53.0

