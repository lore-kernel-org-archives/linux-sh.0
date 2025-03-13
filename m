Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8035726B095
	for <linux-sh@vger.kernel.org>; Thu, 13 Mar 2025 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866306; cv=none; b=VBaAuDaS7U2x9Ep7ynTtutdyTXTI2rmaywvIgwtydxzeIW4sDtpHQE9ogvM1eSeL35ik9jLdIh3YMn4XoCQknrkTYVRrlBkue1JOzEl16wfBsYarDYuidf6jAj/n+UYHIKiW7sc++U4NYlRFpNVgIs7jbYhbTrxpavz3A+dMe/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866306; c=relaxed/simple;
	bh=xetTM7NbHTpP54GNd2evXkwpRCX6m2HaBd9Qo2PRDeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=LE4kLH8tkMLDgBjlW/4tLSk4rX6LXVXl6Mu4yZbAukQVcTRn4vrstzM3Fhm/PuvkoDPi3zO6XiLzAZfffsiK1tq6VtrTEaHsF0B1sU2ZUH62N5a5cRs46R1Ydn8s+NFbe7nLJNScvCanpeNDUJoMOWnWtokHyYkRx3soacILst8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/2V9pXa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/2V9pXa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741866302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BMlGspdrpbJ31u0fCjYvjyAZlqg7W4BaKawB7P7nRsE=;
	b=F/2V9pXaQDMq8XkKa7HMN1xwIDZSBBumicXTmNitD+MuqjrqPmOGEsfndB1NcwMcWfD4Oo
	eJZpkQTMJeA31r+5fXX+P4MGvg28VDi3Sxedmr0JB1PeT/jtj1O633oTOsgt5oVZA8GdL/
	CZxfUGSXRH9c4ZsssSdNu+pzI+lhLXY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-HUsHm6HeOFSQKqM__qr2kQ-1; Thu, 13 Mar 2025 07:45:01 -0400
X-MC-Unique: HUsHm6HeOFSQKqM__qr2kQ-1
X-Mimecast-MFC-AGG-ID: HUsHm6HeOFSQKqM__qr2kQ_1741866301
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43935e09897so6483685e9.1
        for <linux-sh@vger.kernel.org>; Thu, 13 Mar 2025 04:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866300; x=1742471100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMlGspdrpbJ31u0fCjYvjyAZlqg7W4BaKawB7P7nRsE=;
        b=p/q/XMwzyP0uj3eoYXsg5W1TBFbG+NnRiQpjfTedrPv61a0bo+BkhljdZdjb3UILBm
         mIO/md8LoLfzf2H2XSF5RXsfBcT57LJJatiVTdpoLhhS0odG3zM2LVSbQODiGBGek8Wc
         eQPs9uNDpOSFjlmkl2XLPa2Y5StJ2CFY5AjWR1OqAgoh0DYPg0/p+5tcoqtuumL4hA/Q
         oMF41JL/Odzld5VLY8eBTnjaJ7uOZQVdA5TR5YAH4nkr7vtJuTL0zZ6zefx9gFCfGFr/
         YnSaqxESg/aSPU2LNMTuoZ7N3m//yRL2Hzegv011in2yRe2M74Xk3VXsIkrIKKlABbOC
         EObg==
X-Forwarded-Encrypted: i=1; AJvYcCU2DFN+/AT8g9Dan4BablzwiicJBuv3W/JX/W8/grzKWgXPTI2tgD3bLfz4+K+OflvD+zcOkOn49Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx95qjAohb5BVjOnvoLs3gNSxInz5tmfLKuUGl88oi8VW6fXOOk
	ZzrR1hrT5kBJw1gCi9WGW0vkXQGCNKszETVoRHaxd375LbnUYvrK5OnLLNNdtQMC5Oxehw0+rlK
	STDVSOGYFExX15/raWvp+PXjHwcParuuj+a+0dq1fpYHlQ/OCfNjUymCR
X-Gm-Gg: ASbGncuIa9nQUhDp1p4fLL8c363Uyk9LU3TVNpmSdDBXPc22lDlBrMFciAwRB3OdSY5
	uTiT62myGUTIlTF6J6M8afPBGLx3XeXTiTw/93t4os6f6YlTVZgwYGDlWY1NwzrjHlBx5o+vmUQ
	XeHG81oX7+Ck9arbwkvlwJLtgkCSOK8Vzg3kD1XNKpZvppaRKlzi1bwO3OFrpo/15xsk/N8OzP3
	HKUo48Oyfu97kb2c4ndZWltCkeUaqMBkIVxiHYVUTYn9b2XhnYaRsDe33QOk6OIDiRj/NR8Lfld
	T+5i5smRsyuYtdUl8Fjp
X-Received: by 2002:a05:600c:470a:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-43cf44c76ccmr144327105e9.2.1741866300525;
        Thu, 13 Mar 2025 04:45:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERxTxm4YW1Ezaow82Z48NXt1aSx6Vv01Gh0iy7KljuVnLSLjwCs9KSAjTKcqnBX6jh4hKEWQ==
X-Received: by 2002:a05:600c:470a:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-43cf44c76ccmr144326735e9.2.1741866300120;
        Thu, 13 Mar 2025 04:45:00 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d188b754asm17844115e9.14.2025.03.13.04.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:44:59 -0700 (PDT)
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
	Michael Ellerman <mpe@ellerman.id.au>,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v4 14/14] powerpc: Add support for suppressing warning backtraces
Date: Thu, 13 Mar 2025 11:43:29 +0000
Message-Id: <20250313114329.284104-15-acarmina@redhat.com>
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
X-Mimecast-MFC-PROC-ID: XeUjstFKeMFNa31DcR6lkb-2mrVJ4ERXaFEAPeRgz2o_1741866301
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

Add name of functions triggering warning backtraces to the __bug_table
object section to enable support for suppressing WARNING backtraces.

To limit image size impact, the pointer to the function name is only added
to the __bug_table section if both CONFIG_KUNIT_SUPPRESS_BACKTRACE and
CONFIG_DEBUG_BUGVERBOSE are enabled. Otherwise, the __func__ assembly
parameter is replaced with a (dummy) NULL parameter to avoid an image size
increase due to unused __func__ entries (this is necessary because __func__
is not a define but a virtual variable).

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 arch/powerpc/include/asm/bug.h | 37 +++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 1db485aacbd9..5b06745d20aa 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -14,6 +14,9 @@
 	 .section __bug_table,"aw"
 5001:	 .4byte \addr - .
 	 .4byte 5002f - .
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+	 .4byte 0
+#endif
 	 .short \line, \flags
 	 .org 5001b+BUG_ENTRY_SIZE
 	 .previous
@@ -32,30 +35,46 @@
 #endif /* verbose */
 
 #else /* !__ASSEMBLY__ */
-/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3 to be FILE, LINE, flags and
-   sizeof(struct bug_entry), respectively */
+/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3,%4 to be FILE, __func__, LINE, flags
+   and sizeof(struct bug_entry), respectively */
 #ifdef CONFIG_DEBUG_BUGVERBOSE
+
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	"	.4byte %1 - .\n"
+#else
+# define __BUG_FUNC_PTR
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+
 #define _EMIT_BUG_ENTRY				\
 	".section __bug_table,\"aw\"\n"		\
 	"2:	.4byte 1b - .\n"		\
 	"	.4byte %0 - .\n"		\
-	"	.short %1, %2\n"		\
-	".org 2b+%3\n"				\
+	__BUG_FUNC_PTR				\
+	"	.short %2, %3\n"		\
+	".org 2b+%4\n"				\
 	".previous\n"
 #else
 #define _EMIT_BUG_ENTRY				\
 	".section __bug_table,\"aw\"\n"		\
 	"2:	.4byte 1b - .\n"		\
-	"	.short %2\n"			\
-	".org 2b+%3\n"				\
+	"	.short %3\n"			\
+	".org 2b+%4\n"				\
 	".previous\n"
 #endif
 
+#ifdef HAVE_BUG_FUNCTION
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC	NULL
+#endif
+
 #define BUG_ENTRY(insn, flags, ...)			\
 	__asm__ __volatile__(				\
 		"1:	" insn "\n"			\
 		_EMIT_BUG_ENTRY				\
-		: : "i" (__FILE__), "i" (__LINE__),	\
+		: : "i" (__FILE__), "i" (__BUG_FUNC),	\
+		  "i" (__LINE__),			\
 		  "i" (flags),				\
 		  "i" (sizeof(struct bug_entry)),	\
 		  ##__VA_ARGS__)
@@ -80,7 +99,7 @@
 		if (x)						\
 			BUG();					\
 	} else {						\
-		BUG_ENTRY(PPC_TLNEI " %4, 0", 0, "r" ((__force long)(x)));	\
+		BUG_ENTRY(PPC_TLNEI " %5, 0", 0, "r" ((__force long)(x)));	\
 	}							\
 } while (0)
 
@@ -90,7 +109,7 @@
 		if (__ret_warn_on)				\
 			__WARN();				\
 	} else {						\
-		BUG_ENTRY(PPC_TLNEI " %4, 0",			\
+		BUG_ENTRY(PPC_TLNEI " %5, 0",			\
 			  BUGFLAG_WARNING | BUGFLAG_TAINT(TAINT_WARN),	\
 			  "r" (__ret_warn_on));	\
 	}							\
-- 
2.34.1

