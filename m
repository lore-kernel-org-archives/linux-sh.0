Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C393ABDA5
	for <linux-sh@vger.kernel.org>; Wed, 30 Sep 2026 04:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790744309; cv=none; b=ATHA37AqlkbbahAMpkQ06q/WfbneTF3w+VVWR7oOfQjuH4BodlnrSCjOsT1pXtpJRrac/9WAWSLjqHmLO8A39oBicTpyOAWc2/GNkqroElV7SeaFJqgFMOLsqRiC44Zu8xpg0Jlb5lrWlTEnZuiw6SlV+QNaMroRuvbalzMGR2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790744309; c=relaxed/simple;
	bh=H0BYcRe/7TOasjrgNuHLp4ifSrRqoaHhKg1+r3cbVMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pjzijoj+VcY3584awfryJ5uk363lXyxlX/8TEljmbLiE7U6qpYgRS5O2QWHvoy5aS8xSsbT+fUbJzJOk33CC3V2Wz2iaL2w9rx3cRLq7MkjQmICXqpU003jfZb/acoCQrNN9AbgaFSR7JAaUBDcKDoWFSQsG/Wp+3slQvar7FYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcOWGxzv; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcOWGxzv"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-346c612c7a8so2209969eec.1
        for <linux-sh@vger.kernel.org>; Tue, 29 Sep 2026 21:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790744307; x=1791349107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1Za0+xKWVpSodefuNtWovgOzg/HaceXnQz64RO1gmQ=;
        b=bcOWGxzv6Pm9FTE3xik1TlW/YuJIeVTLmt+uv14+44IdAknGXZ3Il/dRuyYpdHMuEk
         JuSo6tYjJkpqcqqcNQ6r5o2zEVAeVpDSi16NxbX9t2Zj0h+GVQxnIJ6pJ6EdWLNso8gm
         HhO3+VjyeE854qGgMV1b5ganX1t58XFbBEBKBOm0goo4+7UD1FynmX/buEWAsyDyyOMc
         p/N4BD91RaPhdTKLnFrqORC08m+Cz3oCf4AEOy1WbhRM+M1tl4UcFZW5RjU+QwaEhxWN
         XEaAqyhGDRT2imZ461Y89xh4xu5f2aCdomYsWcNkoZxRSN3D91s8Hhpoh5GZ3WmM3afK
         H2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790744307; x=1791349107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b1Za0+xKWVpSodefuNtWovgOzg/HaceXnQz64RO1gmQ=;
        b=Bwaj72C0FFLCUqjkaFdKuKiuTYnoUo6/D33ZHUViRLhpzitV4Od/0VyEeS5nMhiAGt
         UriR38rIbIgeRzf79jNhdsRl2Rc0xDoaUYjUguprVlwc/3jj+jMb9d0CEOu0Fkbi6svN
         gkyy7HJIiA6dN27gVHYRPBhnUqw5ps2bWDkCus2F+r5TkzqXczlKxsun7AAk6bWcjhLz
         PipyJWjzMaMWVjJRv4nYBrs6q5luj7SfN1rnDQqf3IPUkuIh48D552dx3IOlxP7R/PjL
         dNYaQQX8fGhJIY1TepZ7CZk00KEiZQl6wS+GYrEF9NqrEzwqrRs7A3F1C0NqVTQF+M/w
         WRXg==
X-Forwarded-Encrypted: i=1; AKwUvBzEoGo9mkpP8h7DYn9L7rbCIogR8NIJmotReQLZukaq9Fz6JHVfs1mDML6t5HLxxED9j2bTwyzwNw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJEBRsZnBOSB3UD2eo3Al+qcLb5jk4nms1y1eDsfUD0lnznWMyE
	2cLiB8XiejbywgQf4YBNkJzIidnTsNf/oLfac6e8q8bikJHS5tN0IfBy
X-Gm-Gg: AYBFou0x9HfIBw0jnpvZiF6mfxpZMajg6UE9xzt8udFE8mUMgTkyE50iedKnPau/N4e
	eV4Pdqysoy8IuZ3EWveUVgL01XYFE7At49Vj8Ip51fX0F6YndjxQPl2ALp5rrLuVk/KsuZe4W15
	4rXF1tUDTHqMMgbpRpR0L71wI2UjY7Xn/d7n1ZZBnxGLoupgDtrk+Ulx00N6vIPCfApWLl2/Qzh
	/9ROJjgtlwl0kOYl4VQp8Q7a+La/4FYIbAo372VmUW8Vg8H+B5/LKWta6gJ5Kd25naGX1jeAS9l
	fwGxt2eSzkpFa1sCMZxAqt59EN4/Vxh+189FhI4FlllA8dU4U5xOPt3SYts9mFaFmanWdpsNvp4
	mA20Dk/ziOf6cJpU5qc0NdU5ReP3niCW+AuYv3AW7XzbvfevfNYykvmHPYLxVuOErHznNWzs43T
	LC2MhZ9ydasEgDacp1peV/gbq5jok/mA4fpY5EfnD12bSkWMf7lO46uGo7lhs3Lc5GWRvja+Q5n
	mDnzTRp4p7ipeTCedp0Y/FuLWfkhuh/WGjInL9E/FtNZSKZM/Y+4OmkLMEheow=
X-Received: by 2002:a05:693c:6391:20b0:34b:f279:2c16 with SMTP id 5a478bee46e88-34cd9180affmr524335eec.5.1790744306877;
        Tue, 29 Sep 2026 21:58:26 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:101a:5ce6:a15e:d8ca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf514b783sm571056eec.13.2026.09.29.21.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 21:58:26 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 29 Sep 2026 21:58:01 -0700
Subject: [PATCH v3 2/5] sh: pfc: attach software node to the GPIO chip
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-rsk7203-properties-v3-2-02f84aeb8e47@gmail.com>
References: <20260929-rsk7203-properties-v3-0-02f84aeb8e47@gmail.com>
In-Reply-To: <20260929-rsk7203-properties-v3-0-02f84aeb8e47@gmail.com>
To: Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Arnd Bergmann <arnd@kernel.org>, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.17-dev-6c14f

With commit e5d527be7e69 ("gpio: swnode: don't use the swnode's name as
the key for GPIO lookup") gpiolib requires that firmware nodes from the
GPIO references to match firmware node in gpiochip structure.

Define a software node for the pfc gpiochip so that it can be referenced
by boards using static device properties.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/sh/include/cpu-common/cpu/pfc.h |  3 +++
 arch/sh/kernel/cpu/pfc.c             | 20 ++++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/sh/include/cpu-common/cpu/pfc.h b/arch/sh/include/cpu-common/cpu/pfc.h
index 879d2c9da537..d57e38c05bdb 100644
--- a/arch/sh/include/cpu-common/cpu/pfc.h
+++ b/arch/sh/include/cpu-common/cpu/pfc.h
@@ -11,6 +11,9 @@
 #include <linux/types.h>
 
 struct resource;
+struct software_node;
+
+extern const struct software_node pfc_gpiochip_node;
 
 int sh_pfc_register(const char *name,
 		    struct resource *resource, u32 num_resources);
diff --git a/arch/sh/kernel/cpu/pfc.c b/arch/sh/kernel/cpu/pfc.c
index 062056ede88d..5a8d804d607b 100644
--- a/arch/sh/kernel/cpu/pfc.c
+++ b/arch/sh/kernel/cpu/pfc.c
@@ -5,21 +5,29 @@
  * Copyright (C) 2012  Renesas Solutions Corp.
  */
 
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 #include <cpu/pfc.h>
 
-static struct platform_device sh_pfc_device = {
-	.id		= -1,
+const struct software_node pfc_gpiochip_node = {
+	.name = "sh-pfc",
 };
 
 int __init sh_pfc_register(const char *name,
 			   struct resource *resource, u32 num_resources)
 {
-	sh_pfc_device.name = name;
-	sh_pfc_device.num_resources = num_resources;
-	sh_pfc_device.resource = resource;
+	struct platform_device_info pdev_info = {
+		.name		= name,
+		.id		= PLATFORM_DEVID_NONE,
+		.res		= resource,
+		.num_res	= num_resources,
+		.swnode		= &pfc_gpiochip_node,
+	};
+	struct platform_device *pdev;
 
-	return platform_device_register(&sh_pfc_device);
+	pdev = platform_device_register_full(&pdev_info);
+	return PTR_ERR_OR_ZERO(pdev);
 }

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

