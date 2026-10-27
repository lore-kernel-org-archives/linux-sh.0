Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140760;
	b=OTFzIYWU6denYGhWf0NWRZEGLH+LbIyndG29TA6Uef8KEAVINg4uP6jHu9NUeHqRRPoB
	 XYN+cSb7sDQHERmykDWd6w4toyHsN8QyXJCO1+NmDbZC5R/0RQtQLbGEHlyn/CEv9sxj6
	 V9Hhiw/eX6c3HXkMRJR3yBqIjppwcxdOZXu2mMqC/+1E3ianU4olF4Yv6hR//ZNUy/kgE
	 slsM+kzklha5I9Pvpw4k6Lvv48tYR/MHIWrEy4exGK1G7Fb4uFm68xCkDmzRHL3Pyv/xI
	 QL8SG3Nk2Clgpi7KTOBnZRAqnCMFkHioeHVrJpYw7j91wgFaxIrQN61nTFYJALcYZMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=beIsynJTUoVVYUibNrHvS9xq2J3rMWzpCblr3XGPomY=;
	b=o29dKoa82U6zXXXilYNTMu7hmTKJbEsgrh7jX2i8/pgDEh+b3S7jpX5crtIpZ9qKD4/J
	 0HcDiZ2/cNuaQ6n2Ajqh7Ur1Zl/L3vLTnLrCw3VgaXDHEcL31xt2WjmOQtnFL6vex8CTx
	 W+bnMlVlqF2J5WXdY8CkehEzeTB7cH2SLHRIOB5MhNYhakIyEOJHJfxv0GwcH1hb63sdw
	 scP60dh9Ns3UTIUfhJhsevrh8rGByruRJnK1DH0C9HGmlnxbQvfM1oSfnhtCy0NEbm6xs
	 j2wm2R8pomCti9SvEyOXaiiGRKfwYuo06OKKe+w8AWuj7MH1Z+i2X75wpo6YMlgsHsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kIMyUKFu;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A8B60A2607
	for <linux-sh@vger.kernel.org>; Tue, 27 Oct 2026 22:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45A8B60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kIMyUKFu
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a0592d4539so466538b3a.3
        for <linux-sh@vger.kernel.org>; Tue, 27 Oct 2026 15:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140759; x=1793745559; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=beIsynJTUoVVYUibNrHvS9xq2J3rMWzpCblr3XGPomY=;
        b=kIMyUKFukUJtjlCB+ZE2zh2lwo3GQV3z3dUYxV09PKjXw0ZjE2jeWA5BuL5r+QkTsS
         5ZzU/9piUKJLhgATzOW69XBDirJSfUNdjU8bimvi6t/U9+77eeZV3sUpzjATUlpkTsmz
         gq3vyWIGNK0zFjlANK5GQZMvv0vsQLSwO9CijSJxrX9Vh1ynVxUpyQR+qXuUOzTQNEd2
         vqFNVi+/m+qyeN1OsBM/7m5G51CLC9ESLC5hoKgrvebdkKnbj7QYKY4thO4WPGJ0SxlV
         i2/3GcwAryD5MX3hH5HdRpHDIt1i8yx0VLeoNGibsE95Q6GYl69dtaAIBjedJgq+ugfg
         pXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140759; x=1793745559;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=beIsynJTUoVVYUibNrHvS9xq2J3rMWzpCblr3XGPomY=;
        b=y56Ro7OQ3BQDNR9Y/E/Jt6NItYOfAGe4lAhtRAOqVswggcKNLGQl5UvvmJdg1V1eQC
         2spLZ4KYuRm7STyCX8SVQ4eXTtrkvMOF+ybQqbBleD8P/yvSfprzaxJ8MSFRxXmKwiWK
         DnxgL1tx4w6630fRMKRHaINlCQCDD/sphKyPub9xR48dfBkdQTnmTymSfSykvxRI0g5t
         TbQiQ3UnwcwV5UAiUAbdLTJXViEMOR8S1VxsnMk8lqqzBeOrSZ+S9KEfycuBdCsiV31h
         gh/fYDANeypIRtY+u0sUj8fJdEVwotjHRth06XrO+/gLrRe7U/eyhKOF86fEYg5HlkdZ
         ITHA==
X-Forwarded-Encrypted: i=1; AKwUvBycWJwxP0c3sE/u0l1rynrgjtDmIWwceFf37dTbW+mfyRUlek+6AT7ntG/dU/ZQ9laKMlYth7ZouQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIkULGtmNtxk52De+J0K1Umd2RHWyF0IaUzgldMaCb/Iwdlh1FN
	N1vf2MQJhTYsvYjQOmcE6BxI63TqDhqPFTvmsLlfl565Wp9W9wWp8vRa3q3gQYlkXVOQMr1UXHk
	y9MVTi0NBWw==
X-Received: from pfbdw21.prod.google.com ([2002:a05:6a00:3695:b0:89f:827e:eb47])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4293:b0:876:194e:b8fe
 with SMTP id d2e1a72fcca58-8a6e70e832amr492696b3a.26.1793140758450; Tue, 27
 Oct 2026 15:39:18 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:38 -0700
In-Reply-To: <20261027223847.652884-1-irogers@google.com>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027223847.652884-4-irogers@google.com>
Subject: [PATCH v2 3/9] sh: sq: Add missing kobject release callback to ktype_percpu_entry
From: Ian Rogers <irogers@google.com>
To: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Paul Mundt <lethal@linux-sh.org>
Content-Type: text/plain; charset="UTF-8"

In sq_dev_add(), sq_kobject[cpu] is dynamically allocated with
kzalloc_obj() and initialized with ktype_percpu_entry. When
sq_dev_remove() calls kobject_put(kobj), the kobject is never freed
because ktype_percpu_entry lacks a .release callback.

Provide a sq_kobj_release() callback that calls kfree(kobj).

Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/sh/kernel/cpu/sh4/sq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index 908a8e09113b..f33864958487 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -331,7 +331,13 @@ static const struct sysfs_ops sq_sysfs_ops = {
 	.store	= sq_sysfs_store,
 };
 
+static void sq_kobj_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static struct kobj_type ktype_percpu_entry = {
+	.release	= sq_kobj_release,
 	.sysfs_ops	= &sq_sysfs_ops,
 	.default_groups	= sq_sysfs_groups,
 };
-- 
2.56.0.313.g2479322e68-goog

