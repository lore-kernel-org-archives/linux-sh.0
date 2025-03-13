Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78DB267F48
	for <linux-sh@vger.kernel.org>; Thu, 13 Mar 2025 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866282; cv=none; b=MC0ehvHJFa7Nuk1b5eIO5TnF3RGnB6AJd/9X1awbUVyaAr7Sob8F8HolRoBIP0r7WR+r5j8/dvikpRGuevVQW9LmYIDXDibN9ZA1Y+m7pzsE8iW3gkex/i15xCGIiBvAHUjxZeNdDRDsRufZzIppPgpLetUQqP9adlPQIYo4YRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866282; c=relaxed/simple;
	bh=k/QW8yyThWQYD06PZzn8avBbFa43Ro0Rb4YCVVYWNuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=Ull1b4HPzKDchWV3XFfccpe1UP9RgGdPNdRHPQac9RoX1fXdEDmQLN41iVQMO2YoUhAmOu6eip0B/4728lTiQ3wzOY/+JZuKTXiXETLoeWo3F0vFvjvNvd6Y6BHpZ+JZbPqgpXHMXaCZExlLLCeZsRetnds16WA0fCHMgxGgooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dv708IQd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dv708IQd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741866279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=piebsVU5QZFL/FeYXj8vMs1AI4HP2ZYK+Wi3o0pUrOA=;
	b=dv708IQd0G/aGysxpJF9KB4v8FVv/60nVjnyAFUJ98l1HTD5pzA704DcKtGoxIUNZazMlw
	9EMxkYKhCkg6ZemXc4HY8UhXzwAojIRysRcR3O+g6vR2MTcw+XOUkVCtJkc+S5vNySHJgJ
	YJt/8eX+JJQAFt08tWsuW0zu+R2ut7Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-Ufli57jrNpSwdP6J6R1eWQ-1; Thu, 13 Mar 2025 07:44:39 -0400
X-MC-Unique: Ufli57jrNpSwdP6J6R1eWQ-1
X-Mimecast-MFC-AGG-ID: Ufli57jrNpSwdP6J6R1eWQ_1741866278
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cfd9b833bso8852815e9.1
        for <linux-sh@vger.kernel.org>; Thu, 13 Mar 2025 04:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866278; x=1742471078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piebsVU5QZFL/FeYXj8vMs1AI4HP2ZYK+Wi3o0pUrOA=;
        b=RIutf/yRttdN6r4Z9mASkBv8t/hTX0esC3iBrkguICTENpmb1i4otdgMEMSqZ4JAHl
         aZDyOxWe9azgk2fiQl/PFB3/MNcHtJTuogkCV8RZKp1daO3/W4D6In6egLuDGooaVKIv
         WWL5B+liNzTW9o+pbPtDNJfzuGRpi8oi03DBH8FY08Ynwk34G2jleoei0YM8KRKbZ/2o
         fgcsL7xzUblBkVqtf8V8yb5O9QIniQ7jIBQW6Copq538f9l1+Uzv70hag8YtP0coYdba
         JVGVPJkXUWkMEcMteumiHxvnb9r7RkR6bjedLW1gpCnAMZcT5aAGFIa1LDTPaoQ7uicq
         bDcw==
X-Forwarded-Encrypted: i=1; AJvYcCWwFp2jNM4oZWo/CJQ9cZolrXC2Z/0EWqwDXJ13sJptVdEWKmaYoAW51atsS5o9yPrqBffi3mKkYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEaAD/w3H0zOPUTzjPZ8AUPieV+klv9iZaGX/PsO9zCAz+SZn4
	YgEP9VEkC5s2sZU7DyfONq/pCqR37hlsCLWZJ4sqvIsymIZYxyj/bHALXZIRmid4Ygscu8NqTwM
	My63NI5gifRsl6UMcxWTWIq0ZT8TwiSv5RVjArs42qae2Hp4Y8MgRwg2R
X-Gm-Gg: ASbGnctTUWuK1Krd1JzMQz9vwDS2+bkNLZm94Doo46YwegtmLe4u8IDo2LRrsMIAzgL
	oO1E3rlSzWu7QIRVdot3ciNorZyiIw+qhZ7J7LHD4FKebswmWdEYGCESdPowSkxDUht/Lxe3EQf
	P2PONlvPDQP3ntsE8BJtXI7EKtaK7yI68evZptUa+tBGrz1I8gRJNj5IkzPNZg+CEjnQMMTHbdK
	q9ZziZQCFMRPuzk8HvJqy1lTdWLQVUE20LEM+P+Zv+hwldmDVaxfISBBLjkISXIKaa1K79nTH3d
	4abWUQ/Sr+y1DBE2ja4S
X-Received: by 2002:a05:6000:1fa9:b0:390:f025:9e85 with SMTP id ffacd0b85a97d-395b954eeeamr1447641f8f.21.1741866277760;
        Thu, 13 Mar 2025 04:44:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPsIsJrLJpu/wcDWacnMw+4SNJEtb8GetI5Mzi5kv4VuMQGkXurfVfuA8bqNlB7JY189Yj3A==
X-Received: by 2002:a05:6000:1fa9:b0:390:f025:9e85 with SMTP id ffacd0b85a97d-395b954eeeamr1447604f8f.21.1741866277398;
        Thu, 13 Mar 2025 04:44:37 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d188b754asm17844115e9.14.2025.03.13.04.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:44:36 -0700 (PDT)
From: Alessandro Carminati <acarmina@redhat.com>
To: linux-kselftest@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	loongarch@lists.linux.dev,
	x86@kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v4 04/14] kunit: Add documentation for warning backtrace suppression API
Date: Thu, 13 Mar 2025 11:43:19 +0000
Message-Id: <20250313114329.284104-5-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313114329.284104-1-acarmina@redhat.com>
References: <20250313114329.284104-1-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _MTnGlIztBF_UAWuGSXejYVJVFq2Pk39eK4xRLJnhpo_1741866278
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

Document API functions for suppressing warning backtraces.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 Documentation/dev-tools/kunit/usage.rst | 30 ++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 22955d56b379..b2f1e56d53b4 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -157,6 +157,34 @@ Alternatively, one can take full control over the error message by using
 	if (some_setup_function())
 		KUNIT_FAIL(test, "Failed to setup thing for testing");
 
+Suppressing warning backtraces
+------------------------------
+
+Some unit tests trigger warning backtraces either intentionally or as side
+effect. Such backtraces are normally undesirable since they distract from
+the actual test and may result in the impression that there is a problem.
+
+Such backtraces can be suppressed. To suppress a backtrace in some_function(),
+use the following code.
+
+.. code-block:: c
+
+	static void some_test(struct kunit *test)
+	{
+		DEFINE_SUPPRESSED_WARNING(some_function);
+
+		KUNIT_START_SUPPRESSED_WARNING(some_function);
+		trigger_backtrace();
+		KUNIT_END_SUPPRESSED_WARNING(some_function);
+	}
+
+SUPPRESSED_WARNING_COUNT() returns the number of suppressed backtraces. If the
+suppressed backtrace was triggered on purpose, this can be used to check if
+the backtrace was actually triggered.
+
+.. code-block:: c
+
+	KUNIT_EXPECT_EQ(test, SUPPRESSED_WARNING_COUNT(some_function), 1);
 
 Test Suites
 ~~~~~~~~~~~
@@ -857,4 +885,4 @@ For example:
 		dev_managed_string = devm_kstrdup(fake_device, "Hello, World!");
 
 		// Everything is cleaned up automatically when the test ends.
-	}
\ No newline at end of file
+	}
-- 
2.34.1

