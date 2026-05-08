Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A967396579;
	Fri,  8 May 2026 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241974; cv=none; b=Pb+Fuzx8V9Svei5yhhjw8C0gLXmcR4lvLwyR8TENSg7UYZ7cCYkUSn/iKoOLXcUFJva1DymgO8DX8dYIRdnaoDYx+NzdASj1+LGwJJbYDOgikKhCGOiGcMtEqIZ7veLSbzvHxqioWuc0UHt6m1KRakEfcQdGzpkEF4/Ywe6fWYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241974; c=relaxed/simple;
	bh=Xz/ZuG+6ZQ7VH3G8p7V5iw5ht00rerKsi1zjUFsgZqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKf8YmShIpQo55BoTvqaCEqYamVKz6pwjlANihHmCBmT7P8TINo7w5L+79po6PucrBAF75HtomZjeufjbwiRRqgj6XFZCKbsfszJA6LwjEzlh33rTh/wEwwCkvpyK81JEYqhB9n/FE1qXUHUk2gLQOU9OYsOZdeW8OVXPwmzECQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3G5wGNv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3G5wGNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E464AC2BCF4;
	Fri,  8 May 2026 12:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778241973;
	bh=Xz/ZuG+6ZQ7VH3G8p7V5iw5ht00rerKsi1zjUFsgZqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r3G5wGNv7Glsc6CLyuC5Jvh5l9eliREhjRbME3IQLORuLZKth+3wYRB7LtsroB+EW
	 LdI/FFa4g+3Sj1XJythUrGLZM+4PIxICEpRh/OiqWDyYDeFrgZVhm3XX+J5fej08zo
	 fQveQYQgZb89Axf+gf3cbR97rFslmWXizKfiq+PkORMXJQizyxry/B0CEnCvjxSgMF
	 Kuc2kwNEpmuSqDO4MVWgf4j6XTcbRK7xmdDN1vGI+JleXKvKQDkkg9WFpMS/+k8JwW
	 /eoj2EAdiDEm5JjOeSvO/hbtxuc/TZwAjHYTaffOn7tMGA5GXdygA7YyzX6u85r6ko
	 93H+9xuviHOtA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wLJy7-00000001mrE-2xM5;
	Fri, 08 May 2026 14:06:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Magnus Damm <damm@opensource.se>
Subject: [PATCH 2/2] sh: kfr2r09: fix i2c adapter leak on serial console setup
Date: Fri,  8 May 2026 14:06:01 +0200
Message-ID: <20260508120601.426115-3-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508120601.426115-1-johan@kernel.org>
References: <20260508120601.426115-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken to the I2C adapter (and its
module) when setting up the serial console which prevents the adapter
from ever being deregistered.

Fixes: e6d8460aca63 ("sh: Improve kfr2r09 serial port setup code")
Cc: stable@vger.kernel.org	# 2.6.33
Cc: Magnus Damm <damm@opensource.se>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/sh/boards/mach-kfr2r09/setup.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 62af9a9db039..8f436bcc1ae1 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -418,7 +418,7 @@ static int kfr2r09_serial_i2c_setup(void)
 	msg.flags = 0;
 	ret = i2c_transfer(a, &msg, 1);
 	if (ret != 1)
-		return -ENODEV;
+		goto err_put_adapter;
 
 	buf[0] = 0;
 	msg.addr = 0x09;
@@ -427,7 +427,7 @@ static int kfr2r09_serial_i2c_setup(void)
 	msg.flags = I2C_M_RD;
 	ret = i2c_transfer(a, &msg, 1);
 	if (ret != 1)
-		return -ENODEV;
+		goto err_put_adapter;
 
 	buf[1] = buf[0] | (1 << 6);
 	buf[0] = 0x13;
@@ -437,9 +437,16 @@ static int kfr2r09_serial_i2c_setup(void)
 	msg.flags = 0;
 	ret = i2c_transfer(a, &msg, 1);
 	if (ret != 1)
-		return -ENODEV;
+		goto err_put_adapter;
+
+	i2c_put_adapter(a);
 
 	return 0;
+
+err_put_adapter:
+	i2c_put_adapter(a);
+
+	return -ENODEV;
 }
 #else
 static int kfr2r09_usb0_gadget_i2c_setup(void)
-- 
2.53.0

