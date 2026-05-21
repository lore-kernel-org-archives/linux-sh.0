Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC2333F8B4
	for <linux-sh@vger.kernel.org>; Thu, 21 May 2026 05:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779340429; cv=none; b=A57nCicfVUx0N3cvzaBiUlsxPW3CQRCZYUW1pBWJDL+zcgxzC0/QnfQwZjgxEnxrqk/P3abJ7E3fQxMOBwrWKI+DhECjqphCWb0IDodO6hAYNYETIGE5EoAEAaZMNRMUTINT3FIL0Z73+Zyujw23xMXB6jBHKTlvPHThlSDy4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779340429; c=relaxed/simple;
	bh=a7LlH6SOmxH0p4iNAX3qrUusbYFuA/lKO8UCM5Mh+y0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N39k9tYFHERPBVOTa1YLj9je/3Iy3nY2K4XegYAaqB44OosvL51LPsKLm2fJ907tcFd0/s4e49yj4sZWo9te6GYeG4/ExhSQVS9kEqLM7wLr1hXYR2cONTvG/HyrKSZq9zeqD6PNlFDx3bX58/KPUCEu18tMLtBZcJKOfI+glzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKhrjeO3; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKhrjeO3"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1331e851faaso2979511c88.1
        for <linux-sh@vger.kernel.org>; Wed, 20 May 2026 22:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779340427; x=1779945227; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YPZxWestxZ6ZeoppNL4aB518UjR8C+o/ws24cKnfpM=;
        b=AKhrjeO3oWo3pW7+XGNc8WEgP/k6/fsJlceeHmT0JIHBANdMvdcP+6fa1aUfysrC9J
         wGdddDCExUc58mZV41UnZXpzz0k7DySu8idWofIDSS9LYgAd/6VOO9YW6ho9jI15i4hO
         XCkwZDvGFJGzOGYyUmmXCrG4fKn1QsQkeHparjLgXEgsc7jAg00ulnkbeYn+YPRdc0K5
         UF8Rq2m9TNDbv6DoqXf0To4Y4E9HFa+BaCrHlDVsp8ihqicQyYpeKwd/tod+krYIpW+A
         dDb/VsCFSbgO5PQCovYI+0/rD5CUYRxjNb24bK5K9nR8gjVfpKUkS4rTsy7MMkY834SA
         nIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779340427; x=1779945227;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7YPZxWestxZ6ZeoppNL4aB518UjR8C+o/ws24cKnfpM=;
        b=jWr3UuBCEvlrlfKhoEfrKj+BSnl9rZh6VqpqeJ+0+HZLcct2hgGOs1bX9sIg+MbgWQ
         aQ8MjZUOQo7RB2OYsjxzKAQqfSZBVEbuLZrXZvcz6WSL0J34RbtcHvpRhmef88GN83GS
         GY8X6BmL5SoMbzEXca/Oef6WD/OetDbKTYWgwh5aqHsT91SiWLi1mfuDcauyyCqe9ovZ
         fmW9a/Xz0LY1eBdrsf7DXxLZwlxWfswrdQ8FbNRP8JhtLIrGgb3ZVCazMnasxc4+cRNn
         DaAs2vRInbKYsGXBF2RERvvvDInyI2O3KT1uAcere7RxJ8/yTXlOgbmaO8QCjHnXSefS
         fj4A==
X-Forwarded-Encrypted: i=1; AFNElJ+p0b9bfY4ahU9ALKpkiQLQiI4C+t2HSldnrnDzIfW7wvEowqkJ9Bns4wrCmwcA2OKV2Xd0UOPAFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYNRfTYsLtJ6z2kNq5OsBn9Ln1kCdOWWM3BK23LVnU3YJRwU0I
	+pXY8JjsMp4ztqEIJoz0QW0U9uZfkkBjmj5QwE4nPrnj3G8S3kF5hoWj
X-Gm-Gg: Acq92OE0Zk8SBqvdQxEzLzYAPrn8MdgJ5kcQXtf4V77plozcbUCtR21hOBqsoGkrgtd
	XTGGbFve8+3aGzTAV78xhSL6RWPaTzHrcrAVZQG8K/1Z3ucyjbOqMFOrVtUPbf89EzkJ0Q1/Om9
	LNnoQ3X6nyFNe37NCI8Yd2xlkKBujYI0GI3KflweCCVFYlTPq9G+6yMB0DSdnT7B76MTnUMxzxS
	h4wgXfpx6k2J1KxVJqcxiE69BkHyI/h5ywgkxS60j3zFp/Wdaj4AN1sYm8w0NW+142Slhq2Twep
	xRZJnQvWLMrIJScs54czcrAU58teWSW/kw1I5Qzwbq8dKRoXv6oOoJQQ7rBKa/zoyjTO+bIppAA
	RMzIhubx8xgMuTjxsdjaUuO8zyO5laYEyWsejYIsLUtcW1PCMjGyxJN/GZW1BWgy6cA3oTqUG4s
	mdgsH+gjH2NzpjDc+nqCbqclViXrY0n6WFvfDMP3kER/CE2vKHA/WIv8vHCrsWsjZ2cRF622Aps
	HgXHRLKOWelcAp0rra6Xj/P
X-Received: by 2002:a05:7022:f91:b0:129:1d25:f1da with SMTP id a92af1059eb24-13633a69b63mr617788c88.3.1779340426708;
        Wed, 20 May 2026 22:13:46 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d457:597:d576:1eb8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-135e5c0a918sm6231360c88.14.2026.05.20.22.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 22:13:45 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Wed, 20 May 2026 22:13:20 -0700
Subject: [PATCH v2 4/5] pinctrl: renesas: gpio: support software nodes for
 function GPIOs
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-rsk7203-properties-v2-4-465f3308021b@gmail.com>
References: <20260520-rsk7203-properties-v2-0-465f3308021b@gmail.com>
In-Reply-To: <20260520-rsk7203-properties-v2-0-465f3308021b@gmail.com>
To: Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Arnd Bergmann <arnd@kernel.org>, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org
X-Mailer: b4 0.16-dev-6911d

This patch extends the sh-pfc GPIO driver to support software-node-based
configuration for the secondary 'function' GPIO chip.

While the primary GPIO chip typically uses the firmware node attached to
the parent platform device, the secondary chip should target a specific
child node to avoid ambiguity when defining GPIO hogs or properties.

Update gpio_function_setup() to look for a child node named 'functions',
but only when the parent is a software node. This ensures the behavior
is restricted to legacy platforms being migrated to software nodes.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/pinctrl/renesas/gpio.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/renesas/gpio.c b/drivers/pinctrl/renesas/gpio.c
index 4e59dadb7364..b49a3e14da91 100644
--- a/drivers/pinctrl/renesas/gpio.c
+++ b/drivers/pinctrl/renesas/gpio.c
@@ -271,18 +271,40 @@ static int gpio_function_request(struct gpio_chip *gc, unsigned offset)
 	return ret;
 }
 
+static void sh_pfc_fwnode_put(void *data)
+{
+	fwnode_handle_put(data);
+}
+
 static int gpio_function_setup(struct sh_pfc_chip *chip)
 {
 	struct sh_pfc *pfc = chip->pfc;
 	struct gpio_chip *gc = &chip->gpio_chip;
+	struct fwnode_handle *fwnode = dev_fwnode(pfc->dev);
 
 	gc->request = gpio_function_request;
 
+	if (is_software_node(fwnode)) {
+		fwnode = fwnode_get_named_child_node(fwnode, "functions");
+		if (fwnode) {
+			int ret;
+
+			ret = devm_add_action_or_reset(pfc->dev,
+						       sh_pfc_fwnode_put,
+						       fwnode);
+			if (ret)
+				return ret;
+
+			gc->fwnode = fwnode;
+		}
+	}
+
 	/*
-	 * Explicitly mask the parent's fwnode to prevent gpiolib from
-	 * reusing it for function GPIOs.
+	 * If we did not find 'functions' node, explicitly mask the parent's
+	 * fwnode to prevent gpiolib from reusing it for function GPIOs.
 	 */
-	gc->fwnode = ERR_PTR(-ENODEV);
+	if (!gc->fwnode)
+		gc->fwnode = ERR_PTR(-ENODEV);
 
 	gc->label = pfc->info->name;
 	gc->owner = THIS_MODULE;

-- 
2.54.0.669.g59709faab0-goog

