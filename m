Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF619DF6A
	for <linux-sh@vger.kernel.org>; Wed, 30 Sep 2026 04:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790744314; cv=none; b=f4e5E6q4amP6J6p/4DkCUciRTCbbgfhyahYJP4pZR5WbgXi5sDJu1PB6lDZNnZ8RX8JAWhmt+i0DPRW2rS/MsSfFxNlCSKAJMoWvjol8hMMUXgzvOiPQO55m+1E5RPY7oyb2gKYR5x3n+Fr9MXa8k/uy+0BM1pminjQFZ7l3P/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790744314; c=relaxed/simple;
	bh=+d/B0EyrO8v0rwBj0UZLa2+ev9ays+neQ9d64Tmh2Tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CI9KqPIagMN6wjcbCRyfb1z91oZFGJuT700KGdahYOCc6n2AwLj+fAu32EQwqUOZUGsPVkLMdEMpB7t54ZaAjy5BRdc61VchJcYP5KTwG1668jv08zoNIb+zCRyAoDTUVln8kQv3YJ3nbYNol697nmv8FEqCUXsqdHHbC7XleXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuScn2ZH; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuScn2ZH"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-34b3e517e6dso733612eec.1
        for <linux-sh@vger.kernel.org>; Tue, 29 Sep 2026 21:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790744312; x=1791349112; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wb+aoLgtZDdjk4LEKDzfD9vu8cYmjgubpEwv6XHPhUA=;
        b=kuScn2ZHHF3foKiN8FH1xy+vWAlZKJdkctLkRj+adF+y3yzoG9PRAI9s086WXBsFBE
         qqjsZ5TMZLIV3htzDhXfoAdjwiPhym4xZwJyMV1P0Lifh2QyHB9MThwTIQrzUQBj6PJf
         J/SuaDXwyg380flSR84s0RactYKWQfvlkz8ayTYEbmp0zpdJCjmbrEwBL6DxHdPJi5S3
         7jK8ansnVVEA0LgTBgXXD2VzxnfqzilibWW+YYdn56fCxc16ptNXrWjl1b913ocnudci
         8AfPj3xMCla1AJlvZMJb2fk7SqGRYqhpnCPwpzlb6C6pFsUZkUfTU776JuCMPaTY2vhS
         5fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790744312; x=1791349112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wb+aoLgtZDdjk4LEKDzfD9vu8cYmjgubpEwv6XHPhUA=;
        b=CSBSEworztS1Bt5cOpAuUNFbjoU8MTR57Z7pGDeEoB1d8UhHt92+4J1lNH9qfYTiie
         7ka4ioKrHFTVK1pnul/ij8CssUSwVL0xOKulYPj5jQ5lRpba2K4HwCZFZKbeChN9i5+7
         BebnvtAN0yjrFCC8gbQkHNnJA5PW7Pf0FfoQ1AmJKYJi/1qeKNJlfy5uK7VGW4uOOvkV
         WfcBaFsWCGrYtBZRd4FeqHRcpTV25KbdGTZwYpn4IzS/6hESf9dd2tao+HcTeAsj//2o
         G6nrxmeA5rfaz2KhxZiBPJDg3+j/s1g68qCv2AOUlAEYgHodT4QsNOlwKrNcEBykK8sB
         kM6w==
X-Forwarded-Encrypted: i=1; AKwUvBxFTW/QWLUrRkh20zWRAS1tyomjm5QTIZnSJQPFuMhRoRiQghCzjEDLPsa4HIivVFODE2e2Z9S8/g==@vger.kernel.org
X-Gm-Message-State: AFq9FYIJnsRiDpSNBpu2SZOZGojTTzRE3zPqEB3XSPRg5lN5qhba+s/9
	sEos3s8r0uim1g532Ofy/rmSQj/hvBpNzURixHjT0caRzmKMKK69lPCt
X-Gm-Gg: AYBFou0SUxr8GT4229lr9GPfFQ1sCPWu0t/9ZqBZ5WxYMiwIbiREeWyoPaF/UmBuToA
	3JYrjvu+VuyrgQ5WIdqz1WQT+A1stscF7SKYNuRaOJRn8DPVXqQKWgg2RQhrYSVaxz+6MuDThGl
	5WuzcxOP/+7sYdjtHo5pyS19pAhuTAYQp6ueeUyUTFS/HcxaC1SjrcD2xpdaRkGaxWaEDWUow//
	4Lw6X8XvnjPcBCZcTlyp/kmBY09f/VuCgLCgVZMirx0XHTQIMKsJ4j1yDIeGQUjcSoyQtnJUvTk
	S1JS3cc9FhvQ28WqbEPt+otAEmGQg0RNcfwcE+mK4aGeEpZ3ODSn4CI3XkQpra/IU6Rl6//T2hS
	QUEDNWwjZ03MDEetZJQClRMFrRzJmnL88K/0Gou9GanJGN9q1mHFDczasxSUsUEaXd65+JgQs6W
	i9JnA8Gs0ZdBtjz8aY8e/8Hj6vllWvCowdOe2VWKMvRNX3lNJ/b+MFSVo+sUXtYT+6/cmDMghb3
	8iXeWSgXdBbG7oMvtC4wq8uH0NF8K3Rx+DtPzQN+fkFJnWQZQJWnYZWkXk82CI=
X-Received: by 2002:a05:693c:83d9:10b0:33e:518c:6837 with SMTP id 5a478bee46e88-34cdc4cf951mr526549eec.24.1790744311778;
        Tue, 29 Sep 2026 21:58:31 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:101a:5ce6:a15e:d8ca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf514b783sm571056eec.13.2026.09.29.21.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 21:58:31 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 29 Sep 2026 21:58:03 -0700
Subject: [PATCH v3 4/5] pinctrl: renesas: gpio: support software nodes for
 function GPIOs
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-rsk7203-properties-v3-4-02f84aeb8e47@gmail.com>
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

This patch extends the sh-pfc GPIO driver to support software-node-based
configuration for the secondary 'function' GPIO chip.

While the primary GPIO chip typically uses the firmware node attached to
the parent platform device, the secondary chip should target a specific
child node to avoid ambiguity when defining GPIO hogs or properties.

Update gpio_function_setup() to look for a child node named 'functions',
but only when the parent is a software node. This ensures the behavior
is restricted to legacy platforms being migrated to software nodes.

Assisted-by: LLM
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
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
2.56.0.rc1.315.gc6ed9934b7-goog

