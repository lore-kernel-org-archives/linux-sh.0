Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB7E35674A
	for <linux-sh@vger.kernel.org>; Sun, 28 Jun 2026 23:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782688718; cv=none; b=fsDx9NK9k1LSUjbpqlBPksIQeKiALrB9zkTzbu6N++6CnrydCYtBsDN4G6K2lD6kcNX/nf8AuLZ65i1dN0m1CSAeCrrtADJejW/DCkbprQ8sCG4JxCuaySM1ZBJsMeNHysLUkyDa5XOlcz3owYKr4BCuhYfnDvbXA/wb0URWUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782688718; c=relaxed/simple;
	bh=mavNBHOE9/77ejFSkm9NTvof71HN6+S38dT1wj0Wm3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g76KGxyVCw+REs2NCvaK25snQWPqG36FvtxvNsQee2N3y8aPvDldQXsnDuQGwu/ivctzA+ieZB6AHD9Md01DCVeApw109tMhwkjp84/jSrZZRb1MMoJNVsMcNYufv9p165cE0Ud1NCVELs4PCn6iFLL3eLlRIa3itPc7PlD2yNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NspIAdTB; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NspIAdTB"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-473ba028d46so308158f8f.1
        for <linux-sh@vger.kernel.org>; Sun, 28 Jun 2026 16:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782688716; x=1783293516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8yksY7VgTBH1NR6vINPHITxNZO8e70inOjb25amoeg0=;
        b=NspIAdTB0VZhM6KixyTbocapUQby9/HrXpTkEzFPPZLAwMO7lRbI8HlMHwWdrTJWV0
         LQUfxjiOEJes22kHcyKGlcqbJjA3r7ONsTp1iGksyvWxYqCnnsCqN5mFBqMee7bGXYeo
         PEy4lnnr0x22LCG9i8zPrwukCe3dVUCXrpsPfqIhHmryzDK6XOxIv1l3LL3Pb8fDfUD8
         Oic66AmgefXOrU75nSy8NzD5+6Gg7LhRjueSzRe+gbtbhfxK0isDO/aPy6dJdFNM9hJ2
         yB0V9FiLa9Xi4PXL4U2nAjpl1uHgphQYkZKeohZH+dzJsAH/FU4ESkDBL2r+X/KTgkDU
         GFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782688716; x=1783293516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yksY7VgTBH1NR6vINPHITxNZO8e70inOjb25amoeg0=;
        b=R2cIli2pfNjiDGFYZQFQ0fHuFxiVbePu9uvURFu/1136xYdnyfe9bUbhoN8OF0oxTC
         Obfh1vLErUiSiae36DmUdFSMMkLUsxX0jsK0uzUml/p3QtvtdqtNeRT1PAvdvP843sfL
         MY9h+eetuAFxJtlDG0CNLb2r7qwpuU3M7c6c+9SszyIBlqxSd6OgfeyTjp9ZURboaVtH
         NRjEWICX8XVvBrlxeHscnfBnZpl9sKExC+YWXydz79ACgh+Oh7nKo2bthflY/wvy3ZYO
         WSH0xiZarvvIwhHrSF5fIAt5xhhN1FEgtJjZF04yA/H6mc34/cu79Ml7bGd+eoC02JTM
         gUEQ==
X-Gm-Message-State: AOJu0YwfatWvznaVJn0BJN4qWV9g/jxLhnywE2WTDxk3E83oHF33muwM
	wi67BYRq4vxbeuzdsq08ScbOv8VgoIfAZVdkZFpxjHLQjQRKfQcLEH4=
X-Gm-Gg: AfdE7ckuu/68THhbVR+BN1Hax7f+2UkBAxA92bNBZHADaeCzYg5aJK0rK+0bcZ9Izxr
	36OxYHkepD44n23fwrYNkLEjwoc3eCG7d2f7yFsMPWis9BfBTj9KYaFJhdrq6d7MSi5fmcAl4TW
	QnDbqE/8yOL8/1gS8bpQe3X6n69Y0L/CKFK/AoTUIhmM0LceCPMfnatXLecr9m7WBs9DVjiqN4G
	xce2ZUTlYXz+b3o01ZrD333tYTMAqU0+jU/IE6s5G8tNMqTn6XVE5ACQGXBurpefZ+4N2GvUw9i
	S76qPURDSYVHu2v2NtbtguqmUew35MPgj5iFe3YQiRZbJEApBcIsvcc16zIs7kOTC1KfrSGBerD
	vb44FkU1ZJ4tV/8ClO6OFkKvqDBY40w+TSbvD9whzC+J8XxMQNYjoNTUM6STzyJeg2V2dNUVBwD
	G3A+mnI1M5VSulKtEMan4yvRA6R/hm74/piX507UuB27og7sty+zIv+ibhi/KalFAX0ZyBSw==
X-Received: by 2002:adf:e002:0:10b0:46d:d6e0:9cc8 with SMTP id ffacd0b85a97d-46dd6e09e23mr16650636f8f.46.1782688715636;
        Sun, 28 Jun 2026 16:18:35 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:5eb6:86a3:4d1f:3d6b])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46c1ee0189esm46918130f8f.9.2026.06.28.16.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 16:18:34 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: linux-sh@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	Florian Fuchs <fuchsfl@gmail.com>
Subject: [PATCH] Input: maplemouse - fix NULL pointer dereference in open()
Date: Mon, 29 Jun 2026 01:07:15 +0200
Message-ID: <20260628230715.2982552-1-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 555c765b0cc2 ("Input: mouse - drop unnecessary calls to
input_set_drvdata") dropped the input_set_drvdata() call in probe
because the data appeared to be unused. However, dc_mouse_open() and
dc_mouse_close() were using maple_get_drvdata(to_maple_dev(&dev->dev)).
This actually retrieves driver data from the input device's embedded
struct device. After input_set_drvdata() was removed, that lookup started
returning NULL and opening the input device dereferences mse->mdev.

Restore input_set_drvdata() and convert open() and close() to use
input_get_drvdata() so the dependency is no longer hidden.

Fixes: 555c765b0cc2 ("Input: mouse - drop unnecessary calls to input_set_drvdata")
Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
This fix was tested on the target platform. The following is the error I
get, when using the unpatched kernel:

BUG: unable to handle kernel NULL pointer dereference at 00000004
PC: [<8c26eec4>] dc_mouse_open+0xc/0x28
pgd = f700ee57
[00000004] *pgd=00000000
Oops: 0000 [#1]

CPU: 0 UID: 0 PID: 45 Comm: Xfbdev Not tainted 7.1.1 #84 PREEMPT
PC is at dc_mouse_open+0xc/0x28
PR is at input_open_device+0x7c/0xe0
PC  : 8c26eec4 SP  : 8c7bbd9c SR  : 40008100 TEA : 00000004
R0  : 8c26eeb8 R1  : 00000000 R2  : 00000001 R3  : 00000000
R4  : 8c6b0dc0 R5  : 8c26efa8 R6  : 8c7b64c0 R7  : 00000200
R8  : 00000000 R9  : 8c6b0d70 R10 : 8c6b0c00 R11 : 8c6ce604
R12 : 8c390a64 R13 : 8c6b0d3c R14 : 8c0e9ba0
MACH: 00000006 MACL: 8686868d GBR : 29609ff4 PR  : 8c265fc8

Call trace:
 [<8c265fc8>] input_open_device+0x7c/0xe0
 [<8c26b2d0>] mousedev_open_device+0x38/0x68
 [<8c26b77c>] mousedev_open+0xa4/0x110
 [<8c0e9cc6>] chrdev_open+0x112/0x15c
 [<8c0e2e42>] do_dentry_open+0x27e/0x2fc
 [<8c0e9bb4>] chrdev_open+0x0/0x15c
 [<8c0f32d2>] path_openat+0x1d2/0x7cc
 [<8c0f3956>] do_file_open+0x8a/0xf0
 [<8c0f3100>] path_openat+0x0/0x7cc
 [<8c1efeac>] strncpy_from_user+0x64/0xe4
 [<8c0ffc7e>] alloc_fd+0x106/0x124
 [<8c0e41ed>] sys_openat2+0xb9/0xbc
 [<8c0e3fc6>] do_sys_openat2+0x76/0xd4
 [<8c0e40ee>] do_sys_open+0x2a/0x54
 [<8c00e25a>] syscall_call+0x18/0x1e
 [<8c0e4118>] sys_open+0x0/0x10

 drivers/input/mouse/maplemouse.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maplemouse.c
index c99f7e234219..c41182766538 100644
--- a/drivers/input/mouse/maplemouse.c
+++ b/drivers/input/mouse/maplemouse.c
@@ -48,7 +48,7 @@ static void dc_mouse_callback(struct mapleq *mq)
 
 static int dc_mouse_open(struct input_dev *dev)
 {
-	struct dc_mouse *mse = maple_get_drvdata(to_maple_dev(&dev->dev));
+	struct dc_mouse *mse = input_get_drvdata(dev);
 
 	maple_getcond_callback(mse->mdev, dc_mouse_callback, HZ/50,
 		MAPLE_FUNC_MOUSE);
@@ -58,7 +58,7 @@ static int dc_mouse_open(struct input_dev *dev)
 
 static void dc_mouse_close(struct input_dev *dev)
 {
-	struct dc_mouse *mse = maple_get_drvdata(to_maple_dev(&dev->dev));
+	struct dc_mouse *mse = input_get_drvdata(dev);
 
 	maple_getcond_callback(mse->mdev, dc_mouse_callback, 0,
 		MAPLE_FUNC_MOUSE);
@@ -88,6 +88,7 @@ static int probe_maple_mouse(struct device *dev)
 	mse->dev = input_dev;
 	mse->mdev = mdev;
 
+	input_set_drvdata(input_dev, mse);
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
 	input_dev->keybit[BIT_WORD(BTN_MOUSE)] = BIT_MASK(BTN_LEFT) |
 		BIT_MASK(BTN_RIGHT) | BIT_MASK(BTN_MIDDLE);
-- 
2.43.0

