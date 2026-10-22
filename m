Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651155;
	b=Exi2rtWssyEuWYR9/z46RjEPvRAHsSadToA10FXTfRF6tDVRg0rGdE1G8pXUEhDTxW9e
	 6/N76HOo9n9UVGWnFHyZ4qC/X+MqrYRBZfmm9o6+cBVKpQ69bhCcYqJht8SvOT4AZs1mN
	 vNnBYOGC+AJuzNktEoNon1ebJ0EYGUNVUdfJ0kuyQSEAUCr9RJZPE3yB8cuYXXo9tDwkc
	 swXhQaRmNB/W1vVIdBwI4ax1hB3+lKiqlHEgFmMraNsod6M+gTMiKkjX2HDRL75wS3wA0
	 9YvnHERsK3YwVDMYlVU7REtUpBv2j/H5BIf9ASGpwKYNq4+xBbAI+eV77pPH08XAjxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3+lR8K5BNHxu5NP+v0e972pWYSboQ57GUDtZq5df2PA=;
	b=wuVgvx2UO9MwnTVdwN/XHUmgQrcmKQkCee6tvEXIU8JqJu5f13DoKHIygq0514QZD4AN
	 FCDv3FuMdZ1BGr5VsARGsY6eZ5tEhWDyJGWfn9FTdJDQ0mtZTqfI2xOg/MNr4c9GQ+FMd
	 5WmBDXEE+GZaCeSn0b8ntxkA5eLn5McBHHKmonRoAETkNL862KaoGJ4iF4e+bUuCBqcjA
	 OdVXfKPjLHW/AoSN61e16ancDWOWuOUqvTUjZH0dbAKXQAMO9ccYUmOi1Z3so3KaYkjod
	 xtWACBj2aumQk9EOLQLIdH1kZBFXKOtfIycwo4d8n73JOegeRSy30+i8J266HTx2HYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Lhn1fkbs;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DB9606A31A
	for <linux-sh@vger.kernel.org>; Thu, 22 Oct 2026 06:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01DB9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Lhn1fkbs
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e987a2ba0cso11779765ad.3
        for <linux-sh@vger.kernel.org>; Wed, 21 Oct 2026 23:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792651154; x=1793255954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3+lR8K5BNHxu5NP+v0e972pWYSboQ57GUDtZq5df2PA=;
        b=Lhn1fkbs+sQBMP7mnjKv5ZuB9n6zoQ72cinSgQnjkMpF+5wPP+lzv9866yFyUm4oju
         Ip22FGzJ6C1ChXAKP2KeTvyXkUuCZTfbxTTgs2vyRmD6xNctWFYIKdrffPfMqfL2u8yN
         u2ckjis9olpbLwxkLmslhZn2+SIzSHFB8it1gaNHMLINQndRBuUMqaMaXZxAwRBZVbiQ
         henrDjUyvyl4dbKkg63vQHVp9PkqH64m16eI3Bu21BatisgfPvDkECYgLSVUi1Dy8db5
         dVn7OC56bJQ6wcCRyhclowhvmLN5NjlM3AtwIROf1cmfNfo9nggtRXOCmb515YmzzK/t
         3EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792651154; x=1793255954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3+lR8K5BNHxu5NP+v0e972pWYSboQ57GUDtZq5df2PA=;
        b=ISXQp3TwV9DbF6jdoWVnoCDj2YPAt8Y3qBcr+IfcNXriS/fm37O5m9RcCbNlfeGb9t
         O7pz/Ygti/h8EB5/cXWFDns+CT/DmMaFd1iaw9fR26U++79tTvBhygvmYvvZjYwDoziL
         zZ4kn6GS+lUl4ttm8C0OZWy6ChvbOwHsKRMDZ1lcsgl/6xK4D+I3LCLi/YwzEYtJrhkx
         BhzC7Xj7JO1AFKa7YAFEVobLjdMWZgVF/nRb3iC8HXMFpwQUDiz+WSneSY9/7KXEzpyc
         LPZyf/H3KG6Gwpyo5tUlbku/Xv5gqM3I6t6ghVvX20cSvp7Qht/E5HiNYF5Nb07J8z8o
         LWOQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0+Pebpw9XXWEMnWDGlLwvIlWOWBri9EL1d731504kxXeI90nKwKGfGGIEUGwolnrolih4OZoXAA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIXczzmXnDJy1FNj9gyugD6T3I6zCz5qxDpVyfEh8thdP8a1fV5
	U2oCOF7FeZ4hHsMxUtu8O8mNNHorAN2+6pRyOKcSU3DmgyGmNvbH48dn
X-Gm-Gg: AYBFou2WVIoQRn9mYgBjhwUce8NoxNypzU48aNhwHjM4ucs0yZ8bY4c8OkDHK1Q2IyP
	AbiTzLzi2bTyag1AQzvhf2IP42z+/jnGA2BDs5TOcjSp8R9th6/77SSJT/msTLT4OFnZHp+E6s4
	XNN/RXkTRvyTgv+KDQhCIxYtXmYq7+PWUzCj4mDDMg9dHls2gdgirBpfUVh75XAi2ZPiBiR6HDc
	K/Y2uxCS7r+eSxl1DEC+mVQIVdXwp1AXK+niBWCOUbpgITcE+5tHTDhXhPrc0H/PE5K0HPn2Nrh
	yMGLZzCV5P1TjwatIn0bYvMOx1cJLE68tHAkKNY8vZleQRjANo4OlFtS0MJ6oLgN4FYnpXCAV2v
	xEyZkM/IX22R0NFrYMWcGV2eRMsQmCF4ko0PrfWFo/FcvGYkUTc3A1X+0qSRHq8uB+OikZF8nc4
	29oRGRLvUcWVCC4wj8ffbYKFq8rrhJ0bBq4EHWdsLjhnxEAnlHxUg1xmUb/zOjFFgMr+Hh1UmpN
	jHxKXeDW6ErRoj9W1Z+K9MymYDvhilT+NzfKECLZWJbTrYsMdCCZQ2++1ZD5smGKj/X4Lbz5hu8
	TKxSyz9PRnG28Do=
X-Received: by 2002:a17:902:ecd2:b0:2e9:5ed2:c3a3 with SMTP id d9443c01a7336-2ea439da835mr37180195ad.37.1792651154247;
        Wed, 21 Oct 2026 23:39:14 -0700 (PDT)
Received: from archlinux (d173-183-236-7.abhsia.telus.net. [173.183.236.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4113b6sm18844305ad.19.2026.10.21.23.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 23:39:13 -0700 (PDT)
From: Artem Novak <artem122novak@gmail.com>
To: robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-sh@vger.kernel.org,
	glaubitz@physik.fu-berlin.de,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH] dt-bindings: soc: document Casio fx-9750GIII
Date: Thu, 22 Oct 2026 00:39:02 -0600
Message-ID: <20261022063902.471383-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Document for the Casio fx-9750GIII graphing calculator,
which is based on the Renesas SH7305 (SH4A) processor.

Add the Casio vendor prefix and the board compatible
binding.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 .../soc/renesas/casio,fx-9750giii.yaml        | 33 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/casio,fx-9750giii.yaml

diff --git a/Documentation/devicetree/bindings/soc/renesas/casio,fx-9750giii.yaml b/Documentation/devicetree/bindings/soc/renesas/casio,fx-9750giii.yaml
new file mode 100644
index 000000000000..f3c1c02f1bd5
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/renesas/casio,fx-9750giii.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/renesas/casio,fx-9750giii.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Casio fx-9750GIII Graphing Calculator
+
+maintainers:
+  - Artem Novak <artem122novak@gmail.com>
+
+description:
+  The Casio fx-9750GIII graphing calculator is based on
+  the Renesas SH7305 processor.
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: casio,fx-9750giii
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: casio,fx-9750giii
+      - const: renesas,sh7305
+
+required:
+  - compatible
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ba2002969373..78ba9c29cb56 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -301,6 +301,8 @@ patternProperties:
     description: Capella Microsystems, Inc
   "^cascoda,.*":
     description: Cascoda, Ltd.
+  "^casio,.*":
+    description: Casio Computer Co., Ltd.
   "^catalyst,.*":
     description: Catalyst Semiconductor, Inc.
   "^cavium,.*":
-- 
2.56.0

