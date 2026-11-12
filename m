Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466248;
	b=lk/TxkQg6KgN2I+qq1Y3kSmUMVYmla0pkBenEXbK8udS/qimBAnVOvbBexzeKW91ib/+
	 sUBS5Wlnq6ea35vTMIeBQT8FVkCCslpWciMepY+fS6iEM1m9TruNtueB5G5Sr1pN8DcSt
	 FlorjHm5WlW3we632W1S3mM5Scd1eViByZJZoWS3NHZvqZI0Sjjl6AjWYyJ2BKLov2B/A
	 jTu/PbShKacIp3QqCdSGA6+4cBjfERPyPqvzqSi3IBH+/wVksLS5S7E3zZsiu942yixHV
	 jjRSUN69CWQLcZ1nEevyb53893QSfvSjE8dXzBz4kkfvtLJrkQ5/1miGxqeCFyMR5nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ty84CESWvo8NjcPtLcsMtVcww4VhobkmDUR8vEESdIc=;
	b=0tct9F90S6YFSvPVUvOTajibLCrDEEfAHUAkqJp45p0BnpBkaZ8d07yVyrOHl7xOe8Tj
	 JNpvXhRCf3wn4PqJxUhxw2+TR2FxUiXXrFZEvwefWSME+kdBwFBm5gtock8Rs/e2++tvR
	 a+hpfSp6CIWj8EOOXZ4CdrDc6HZP6ZmUqANuLyFDW9SxPz3lHIACPT68zwemLNfT1E6d8
	 itwDGWqwGJb2MdzV4o8NpeltYifikCBwpR/q+6uTsD3PIMmsBH6a0FyP57oFv6hMX/B4B
	 4IEz4xI4HUjJmXMcwKxtrGhiC+KnYTNXZV9zttJw1FPa6ooNcI9GVEpoCJnc0OyLvaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wSQr6r+v;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C68606DCB2
	for <linux-sh@vger.kernel.org>; Thu, 12 Nov 2026 06:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3C68606DCB2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wSQr6r+v
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b197cd42b0so453214a91.2
        for <linux-sh@vger.kernel.org>; Wed, 11 Nov 2026 22:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466247; x=1795071047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ty84CESWvo8NjcPtLcsMtVcww4VhobkmDUR8vEESdIc=;
        b=wSQr6r+v80aDfugLlpy4UkDjWccjOHGrIYSk7Otjw2ySKu0BmjJNEE6CbpAjFYldax
         gXOgfiOvTOkPo9X2b7yjneClaVhWMrad5bJ/6gNuCCpJWK7DfKnvmobQXtD0xiJ0QBdj
         oNZahOWLcIInkjIn1RALHs8jfW+jDBgUjIXExwP2zLYF6vhoulzl75ZLUk5sf2SCloEp
         emZNB/sH9MZFRtVXFnkeHw+PAm+zSuEHKEDcqhoj1bRIe8Fs62nx48fVTJGm/vgqfz2G
         mJ0sp34xaO56xngcv6HJROEl4EuxxZ+ViTQlTHrmSpbWs4pZKYzu9b0lR7EKoRd2AU+j
         BnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466247; x=1795071047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ty84CESWvo8NjcPtLcsMtVcww4VhobkmDUR8vEESdIc=;
        b=arrlu6dH95EVTAY73jX3AI2g8XIRoOpvDudhx7maJ8o1W4ppZiNYlIbOvffeVjsH+o
         zpkIGgHqBQTNY0TNUEFhC2oP4djBnYC1vLBnIioOOR856KK9qMkf/wjkXE+4pKaegYlv
         kLY3yKV/WQuOiyExadQvagqhu/MDFXEG4O4q1AmadbedX2DBw+/C2v85QnJocYEcfx17
         oB4jRI/YABmhbO2gLKM6udcUj81Ae2KhxbVrC3Vj1u9VFC6g9Nq1eECNC8IgqcbnSHPj
         NaayM1jBJblHU+uQttxwXyHZQXPLveA/hu6oLSO/avgbqqVhE5IWRWz/jWjdRNNTeWWd
         sOug==
X-Forwarded-Encrypted: i=1; AL+hErE0L1ctNK+8r4lER22FevLbAQPNgrW9OTYxT4zapHSubLpqCF5D2F80MFgZ2EsFXnI3VOl4Jc6VQA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8lBNevTb7RWNHUxusXZ9oT772iOhiDIUZGorWenPAUT4o6HsmQ
	O6YeKTJvFj1w+HylI2vE5u7YJwdGwCDbQ7Z69lteS5jX/ejV9cFfJ/en
X-Gm-Gg: AYBFou0SzVIxn9rsDsuko88VGbe/4jnuueZuAlmXud3dBlkMD2bNSpmhwx8eTCy9qkZ
	7qitC0gmTlr4u+/TGvk6xujrfWPELWvDzZBZobSMOcw304iPtFOsruG98UPc7BCFgGPjUxTEBb9
	MqHqCbpknwbWRSZQ1tO759ap9MlvQx0l2+CKlSvP4YNIOMkAIcgZXQ23N71QghLwAr0OVuDlCOf
	Gfo7om7V0XIQ/wbeCbL+eE+ZHVptR3svPTY9UXBLneY4WIYr7cJofMYLmcZodcFbciyHZc8Xq1T
	jWUyDC0atLy4nd07kLukUZEfWxgqFJtGPxMXvAmxvCJ51PVPne5TcAl9LmUdC88W5gRcKHZP0MC
	SI+LJUsmxtGHEe+f0YqQzbY5gq46H6p1raaBX5kKvcNJGmtCTSGx20JM2AXSQYYJCra9KV3YZv9
	+Rq4Ink08+F9uMQr7ejajBxxwhMZOwm9ngEHh/ZHs9cY4wcsGXnflOi92m1bnQCCKg6PgZFMFTM
	KQ/fTDOcSfPPy/9rtJQC2Hz/2Or9ay0V8zn8oOI2HeSdVUj5G0pkERE92yPAvccRrHsI0PlFwci
	E/1lXOHfuwR9o1US3P/CpIx75GQ4gbkKMTT63jsLLlG1ugg0OYzNiG08ljOh9i8KuaTPtVq7sgP
	3Q3xGOCM0bzfoFJLp
X-Received: by 2002:a17:90b:4a04:b0:3aa:6b5d:9fe4 with SMTP id 98e67ed59e1d1-3b182e6a137mr4118772a91.12.1794466247134;
        Wed, 11 Nov 2026 22:50:47 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8aae8sm3073297a91.14.2026.11.11.22.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:50:46 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Johannes Kirchmair <johannes.kirchmair@skidata.com>,
	Yuki Horii <yuuki198708@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-input@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] Input: tsc2007 - do not register input device without IRQ
Date: Wed, 11 Nov 2026 22:50:36 -0800
Message-ID: <20261112065037.1800467-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
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

The driver has no polled input mode and only reports touchscreen input
events from its threaded interrupt handler. When no interrupt is wired,
the device is used solely as an IIO ADC, so registering an input device
serves no purpose and creates a non-functional input node.

Only allocate, configure, and register the input device when an
interrupt is present. This also allows removing the unnecessary
ts->irq checks in the open and stop callbacks.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/tsc2007_core.c | 95 +++++++++++++-----------
 1 file changed, 51 insertions(+), 44 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index 8197ad91ed8b..1fb2c26189ba 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -172,8 +172,7 @@ static void tsc2007_stop(struct tsc2007 *ts)
 	ts->stopped = true;
 	wake_up(&ts->wait);
 
-	if (ts->irq)
-		disable_irq(ts->irq);
+	disable_irq(ts->irq);
 }
 
 static int tsc2007_open(struct input_dev *input_dev)
@@ -182,9 +181,7 @@ static int tsc2007_open(struct input_dev *input_dev)
 	int err;
 
 	ts->stopped = false;
-
-	if (ts->irq)
-		enable_irq(ts->irq);
+	enable_irq(ts->irq);
 
 	/* Prepare for touch readings - power down ADC and enable PENIRQ */
 	err = tsc2007_xfer(ts, PWRDOWN);
@@ -243,37 +240,19 @@ static int tsc2007_probe_properties(struct device *dev, struct tsc2007 *ts)
 	return 0;
 }
 
-static int tsc2007_probe(struct i2c_client *client)
+static int tsc2007_input_configure(struct tsc2007 *ts)
 {
-	struct tsc2007 *ts;
+	struct device *dev = &ts->client->dev;
 	struct input_dev *input_dev;
 	int err;
 
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_READ_WORD_DATA))
-		return -EIO;
-
-	ts = devm_kzalloc_obj(&client->dev, struct tsc2007);
-	if (!ts)
-		return -ENOMEM;
-
-	err = tsc2007_probe_properties(&client->dev, ts);
-	if (err)
-		return err;
-
-	input_dev = devm_input_allocate_device(&client->dev);
+	input_dev = devm_input_allocate_device(dev);
 	if (!input_dev)
 		return -ENOMEM;
 
-	ts->client = client;
-	ts->irq = client->irq;
 	ts->input = input_dev;
 
-	init_waitqueue_head(&ts->wait);
-	mutex_init(&ts->mlock);
-
-	snprintf(ts->phys, sizeof(ts->phys),
-		 "%s/input0", dev_name(&client->dev));
+	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(dev));
 
 	input_dev->name = "TSC2007 Touchscreen";
 	input_dev->phys = ts->phys;
@@ -291,20 +270,49 @@ static int tsc2007_probe(struct i2c_client *client)
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, MAX_12BIT,
 			     ts->fuzzz, 0);
 
-	if (ts->irq) {
-		err = devm_request_threaded_irq(&client->dev, ts->irq,
-						NULL, tsc2007_soft_irq,
-						IRQF_ONESHOT,
-						client->dev.driver->name, ts);
-		if (err) {
-			dev_err(&client->dev, "Failed to request irq %d: %d\n",
-				ts->irq, err);
-			return err;
-		}
+	err = devm_request_threaded_irq(dev, ts->irq,
+					NULL, tsc2007_soft_irq,
+					IRQF_ONESHOT,
+					dev->driver->name, ts);
+	if (err) {
+		dev_err(dev, "Failed to request irq %d: %d\n", ts->irq, err);
+		return err;
+	}
 
-		tsc2007_stop(ts);
+	tsc2007_stop(ts);
+
+	err = input_register_device(input_dev);
+	if (err) {
+		dev_err(dev, "Failed to register input device: %d\n", err);
+		return err;
 	}
 
+	return 0;
+}
+
+static int tsc2007_probe(struct i2c_client *client)
+{
+	struct tsc2007 *ts;
+	int err;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_WORD_DATA))
+		return -EIO;
+
+	ts = devm_kzalloc_obj(&client->dev, struct tsc2007);
+	if (!ts)
+		return -ENOMEM;
+
+	ts->client = client;
+	ts->irq = client->irq;
+
+	init_waitqueue_head(&ts->wait);
+	mutex_init(&ts->mlock);
+
+	err = tsc2007_probe_properties(&client->dev, ts);
+	if (err)
+		return err;
+
 	/* power down the chip (TSC2007_SETUP does not ACK on I2C) */
 	err = tsc2007_xfer(ts, PWRDOWN);
 	if (err < 0) {
@@ -313,14 +321,13 @@ static int tsc2007_probe(struct i2c_client *client)
 		return err;	/* chip does not respond */
 	}
 
-	err = input_register_device(input_dev);
-	if (err) {
-		dev_err(&client->dev,
-			"Failed to register input device: %d\n", err);
-		return err;
+	if (ts->irq) {
+		err = tsc2007_input_configure(ts);
+		if (err)
+			return err;
 	}
 
-	err =  tsc2007_iio_configure(ts);
+	err = tsc2007_iio_configure(ts);
 	if (err) {
 		dev_err(&client->dev,
 			"Failed to register with IIO: %d\n", err);
-- 
2.56.0.567.gdb80ae8cd5-goog

