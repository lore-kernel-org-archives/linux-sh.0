Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F7633AD9C
	for <linux-sh@vger.kernel.org>; Thu, 21 May 2026 05:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779340424; cv=none; b=fzQz2LJSuJqEz9JxoPwaBLz4fDx0GTDneLr99RhsjeYOU5AorBPdvZVTdA+oAJa/IOC7RdzTjFeXlz/xKunSz+dqd7ZtzZRClkwwE5v6nwYyAwC5ll961aOXZRixaeEk/hmepcbLZa+f84IxlNXBDoXYoL8SW5zwfZNAH+gS6gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779340424; c=relaxed/simple;
	bh=V98m1+0octd7GZV73B+kVvkgTFXAFAq4EIFfr2kWVpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lolIVYp2QleUAdBYyDjeNKK5bdASh4e0Kg7BMjxLXGDFBC804RQK8zDbfUtZxz7Hb0ET2YkNuPpjPnEbmp4Zi4fbWtIY2+fYsnumva6u4aI8nQbWY3GmslcPGw19lNYNLQcwH8nn0t8FHYywRBcp6kmoVEsmsFdlQLtE695gDNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bchZZlDx; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bchZZlDx"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1363fe80fe8so80166c88.0
        for <linux-sh@vger.kernel.org>; Wed, 20 May 2026 22:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779340422; x=1779945222; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15uEAzMKA+H+ojfSPLhPEYofIvVWsChvdMIoi7uyS4E=;
        b=bchZZlDxjHZ3177c7waBx91yr2AFemv1jay3iRJ2ykiYxVtPZw+YGZmckU98YBs5kF
         ai22M3aBxNpwBsJG7G0QmFrpE/dBOuuxgDp+JPa1oHEP1zO3cQXvk/wQwtntxhTyZHX0
         9Vw2ytb2+rBRoEO0jgCVhKK2fHsQSzGUDezrwAOWyl/opC5Ue5YrU7fyt5PEtY57t6Up
         PxXpPer4/6siO4XKBg3sr/POOan38CqwXajngyR81/haI5q8Fe0MrjOs8PsVy6d6On/0
         FfwLK788Knw/HrkkTkb5V1UzR2e20G6EVMRuspn9KOQieV2aPEY0fdI0vc3Mo4KXdOG2
         zecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779340422; x=1779945222;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=15uEAzMKA+H+ojfSPLhPEYofIvVWsChvdMIoi7uyS4E=;
        b=Z3x6lWJLpy4Hi8k/yxevcB+s8A5kNp5c8xp5fLwUN1hejkHFJ4wFabweqd/dHX2L8/
         KRNbx+AwJblMO6+R53NRWbKr7nC6rzE57t+KnNsSKdk4QWhRXIzji/MCeIMYXmYY5UaV
         nBznQELYc4DoegZtgbksGbVpvcAh0q8b7Tv97cgnh+vsclPc+vAOC/AcyLfUCtskCdLv
         g7fJZ20yDJI2FgXgNiRlag/qDaCS9FsB0WlFNGaMExqLjNYCmtn01cESK7uU0yarGWDV
         f+AOvWSv0SKgYm3e4ZyaMYhDoyMFQZ5B4mzjkJ6IBb6g+x0uAx4cCfQD4gH+b7ICEYmV
         mtUw==
X-Forwarded-Encrypted: i=1; AFNElJ//b8QY/U+O17M7KJMACAi1j/msBbZvRKQCypDn49s9Fh/wu/HO4KLBNd+NJkvRW7d5/eZVHesorg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyu9yiCp4XchI8smCCwohQMDQXBOfIJ+p449us0RBT29jJZ84l
	F51XawGT5ifY/nsWXkSFlulLlpe+6p6yJSYIYT3Mra/HtbAWT73Xb6q0
X-Gm-Gg: Acq92OGY2q2PQ01TFS2AjgY8kina+9kOSOtPnrmdZks2tUKA4yKxjEALY2gu+VdtrS6
	cZICofjnck6rULs2WUehL/zUz+28W5mCbZ5cGzg/ozjtEDs09pOL0hl9LccNfup0zQAxtfW9ewJ
	XyHHKWV9c3kP51OeUV7/TYvsKYJPUB8xL2DNknvk7trxFPOcADydZ7DTGtz+X49h5O2aZGdtHjm
	zCHTtapZ4Ty31IU5BtpHYHc2HsywbSoYeK/hdifJQr26CMWQHh+DxlLliX7TJVlOHhIN1Z5Enl9
	c5p710rMyfudAipntsKACnzRKM90omfgc2N+/hqli/lP95OnRM9pltzul3Tvi6eRjgUfdUv1QyF
	RGNUractlw/b4DOzVw0eG2VeU9cy8IIWw+93BUo0Cdl8qFtkdBi7t4HQUCa0iZqvkVF/imgo24j
	w52yWUDncbfJ1B4RFuNpId+CHrs0jH1uMUMv9A8uOvYGNlLHQWPzPdta0ebjr5paGPc6+0YaYuD
	4cWqDGKRGC1oA==
X-Received: by 2002:a05:7022:f305:b0:12a:6c7e:bef2 with SMTP id a92af1059eb24-136327e4b6amr342425c88.7.1779340422089;
        Wed, 20 May 2026 22:13:42 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d457:597:d576:1eb8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-135e5c0a918sm6231360c88.14.2026.05.20.22.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 22:13:41 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Wed, 20 May 2026 22:13:17 -0700
Subject: [PATCH v2 1/5] pinctrl: renesas: gpio: isolate function gpiochip
 from parent fwnode
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-rsk7203-properties-v2-1-465f3308021b@gmail.com>
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

The sh-pfc driver registers two separate gpiochip instances: one for
real GPIOs and another for function GPIOs. Since both share the same
parent platform device, gpiolib's fallback logic causes both chips to
share the same firmware node (fwnode).

This causes ambiguity when using software nodes to describe GPIOs, as
gpiolib may apply hogs meant for one chip to the other if they share the
same node.

Explicitly set gc->fwnode to ERR_PTR(-ENODEV) for the function GPIO
chip. This satisfies gpiolib's check for an existing fwnode and prevents
it from falling back to the parent device's node, while ensuring that no
actual properties or hogs are found on the function chip unless
explicitly assigned later.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/pinctrl/renesas/gpio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/renesas/gpio.c b/drivers/pinctrl/renesas/gpio.c
index 2293af642849..4e59dadb7364 100644
--- a/drivers/pinctrl/renesas/gpio.c
+++ b/drivers/pinctrl/renesas/gpio.c
@@ -278,6 +278,12 @@ static int gpio_function_setup(struct sh_pfc_chip *chip)
 
 	gc->request = gpio_function_request;
 
+	/*
+	 * Explicitly mask the parent's fwnode to prevent gpiolib from
+	 * reusing it for function GPIOs.
+	 */
+	gc->fwnode = ERR_PTR(-ENODEV);
+
 	gc->label = pfc->info->name;
 	gc->owner = THIS_MODULE;
 	gc->base = pfc->nr_gpio_pins;

-- 
2.54.0.669.g59709faab0-goog

