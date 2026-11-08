Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177594;
	b=Sv/ddUzNocfgRCaVhkQGW5o3JhtpynrGjyzY0gzNdiw44u11DsF0f/duuxrDkej5sxlI
	 R+f5hcio4+2jjST88uNp1YNo0sqxPrcpRrPCFNFnZZlv9hLtTmuARzEz348bFEqKT3p1C
	 AN+hVjpdcdwGJ4qVho7RV/L6W0QANqJevANI0v06dHg8S9noUglbOaYkVPDS/50f8DwkA
	 m/vK/Hjp08dUDbwEIguYdUXNc2K7rJcI8xkU1h9qgrIqjZFlhZrU1Ygeu8IASMniJzjEE
	 P/+YJgfY8RzAKFRuslLMuw3spWEmAMmzPyWUKRfOeGbTCgspZfSnBewVgeklmHadpDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=noN8ey05POi7MkRY5IldCk9pju5ZMENfN/kneqqJ3/c=;
	b=1l6rtMvJhYrsh56v0TabmNGFvBJwf/rhWZ8t9lcuVM7+81ZpWoKci0/W28J/4K2JBhQS
	 98YTh7ZudFLS/+h4t2VMv2oWDpzwICfO7Z0+l4KcIrlNvLYAZRPqQsX1FxQPBN7bq/E3R
	 ccq/pgfuG1PalwpteX3loj6RWLI7v0t5pjHytsJGDd9mZ2+L/lu6F5APslXLCqkE28r1c
	 oii40Bj/kqGMV7D22ubEn9cFSmY0gIu8cmTrMz40GjqBHWO6e9BOMMTITC7P/uZAfBsZF
	 cgm93UdfoDTOLgPa6UyUzDGLlNMBfAYcELKAUqcDtp4eZ9AMTQR4haKbZslSPgk20GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=llvOaPqi;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9040B6082BCF
	for <linux-sh@vger.kernel.org>; Sun,  8 Nov 2026 22:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9040B6082BCF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=llvOaPqi
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1ac19c6bc71so293003c88.0
        for <linux-sh@vger.kernel.org>; Sun, 08 Nov 2026 14:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177593; x=1794782393; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=noN8ey05POi7MkRY5IldCk9pju5ZMENfN/kneqqJ3/c=;
        b=llvOaPqin1/SJfB6ZgFMe2gZlVxb/SBs/EaTs1fBKHfuzR50CINutw+BhBVS4Yoq7W
         5CXnEaThdYdL5TvoWqX15XutB2hMeCk29e4XomOv785G6Jh+suNlIc/tIlBx15llRc2I
         7uRNwYJ/0N90oxF98NQiqNkC20zP5itEJJ4BwqXqG0e7b1e+l7tNHYfNbR8/BduTBQD5
         oLq+xpYDpQZXCZHJEuqL2pIcKw2++sMVfz4Vbcj5u6SlAk5GbzYVqVLZdDpxzAfriS7J
         4N8BhX3YQQWKNEv0Sqfj1nOKVxXqDF+/c8+GbvUOaS7b6Hf0u31Y/8hBrb5MMmG+oRGo
         r7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177593; x=1794782393;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=noN8ey05POi7MkRY5IldCk9pju5ZMENfN/kneqqJ3/c=;
        b=jyyB7ISPtxWL+dXTiHcMs2YbfUL9vcBXGjFwJXYRjIVCikCJaIW2QmHwGLO5PDfxOp
         73O4/f0+meSVAD5dTVyjWYVshb9L1DZX1QnHKTT0F4sW4IYGN5Ekiim6iqydhksHtXzC
         9eJNEZLZ4o37q1RMwKrGgQKJWrI1bvh94mbXDV9UOme0LsJ6ary6/r7bu4p/VNzJ+0KR
         htM0sZOaOP476g+fgweTNGxTuCSYkYvPfKf2om1UUbd/YGK1aToeWxFqsnfoUr76yd1K
         eUOYN5OGvvHBVDEH7op4fNUho2Qb6PahQRtrLXw6qLp0a9P6xmUU8DXajOOsHKlqL9DY
         FrnQ==
X-Forwarded-Encrypted: i=1; AL+hErHVOFifUyUqRxknn26vkJsBo5CbCUO15quxDXuhKzJg+yHS3ZFWDEXdDlcYY+U+wCLL0XTTkHrzhg==@vger.kernel.org
X-Gm-Message-State: APuU4Z99po6EItmQ0MiScHGOojO77Cm+7b940IXFWnpYphEsX9PH3fxy
	opByyRNU93zMvjo2oPW+6upc/2pdOgnQCZVengVX1KCoxWhWPkXBFd/rwEugOqa3pCyHi2a/yxm
	ldPCaoYVEvw==
X-Received: from dlam9-n1.prod.google.com ([2002:a05:701b:2089:10b0:195:beb6:14cc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:28b:10b0:1b0:430d:d81c
 with SMTP id a92af1059eb24-1b39feab6a4mr3897188c88.25.1794177592505; Sun, 08
 Nov 2026 14:39:52 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:10 -0800
In-Reply-To: <20261108223913.3624571-1-irogers@google.com>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108223913.3624571-7-irogers@google.com>
Subject: [PATCH v3 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
with kobject_create_and_add() (which allocates a dynamic kobject using
dynamic_kobj_ktype), and hypervisor_subsys_init() in
drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype with
&hyp_sysfs_kobj_type, which had no .release callback.

Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
kobject release behavior.

Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/xen/sys-hypervisor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index 91923242a5ae..0e8a2cd69fd6 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops = {
 	.store = hyp_sysfs_store,
 };
 
+static void hyp_sysfs_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type hyp_sysfs_kobj_type = {
+	.release = hyp_sysfs_release,
 	.sysfs_ops = &hyp_sysfs_ops,
 };
 
-- 
2.56.0.455.g6c5a503b38-goog

