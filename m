Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116342;
	b=v9O3r2eUc7JJCcu9UeippKmFVLfzPjyZt+wClaoBE+UftR4xZKDIuG7fYRUBZXRichds
	 HX/lLU0T7te34FyCj4/CJ1F8+JmHbpJyhXV7Qrx7R2iy34p3kCm4DRPG6KExQlEFWsmuD
	 ew1+KkdeklOfmW8GZ7UrsigEdz1vkkfUp2Uk7ZOAE8e1oGVdpOyUKpyTIz9v4iZ/M+fkR
	 HqQO0hvB3oQmkVZWyupeLgxCk5N1iPpXbcdQLYe2Hui54DmciiMHLgpdkQlzLlCPiLAo9
	 IUCTAD2O3vWMPSWhn1/tCQvpBYpFxv/V7Suj9Z8kF9zrrfaDboyOjek+2sLC3l8w4IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ALLBk8MdTkFwcPZqYQO+ZVSicu8jJEanZFGqZFoBPVY=;
	b=3G5OTs81Nw16Sx2r8LEOE/M05JntDzCgqIN3VyU5NBaD3gpXnLznnEpRr6rVlNfbgueu
	 5szlon1c8LnyCwEuE9vt0NA8l4AaFbzGBB1Hn43AmeegaelM3ImnWpL8J14/GmyKbf5bQ
	 WbrnpNstmn/D4QwsNb84qFXmB4L3G20FvURH5TDFLTqCOhRPF4p32qZYqy8bz2c4MAY3G
	 hQiqPERiIoDDdjRl9hGVwVKm4HV3YC1ACtngnh9S6In84224WouCDi01mylv9pvoNnkLa
	 UIEkB0teAzMRSlSS7jB+kcmjXzCsAMYSeaupFKQZ24275MUv+u2x0BqnOFqvdXsPI2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BYv7OsYs;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334360A2631
	for <linux-sh@vger.kernel.org>; Thu, 19 Nov 2026 19:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F334360A2631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BYv7OsYs
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2f0381f07a0so434555ad.1
        for <linux-sh@vger.kernel.org>; Thu, 19 Nov 2026 11:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116341; x=1795721141; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ALLBk8MdTkFwcPZqYQO+ZVSicu8jJEanZFGqZFoBPVY=;
        b=BYv7OsYsxwh5t8p7/0Bp+Ty/T8NLWmSWYXIktaSg0QLh2dtAIFb3imVoee12XgHoWK
         mUIbJT1XkyoNa7tb+YibdljLhg8xyJpSz4cIDdCeOF27j0B545vrSXDsPWORMWkYK8lL
         2ud8bRh2hgMvWXbTuM+9Kmcc7s/hrRwyihUtOpStDYOfj2AtLGFx1Bu0icOsfO63qsRy
         ZGhxrkwNxvyV95wcfNMtY+9w7/r9tW4iBrIDYIwhqf5FSLswSImMzmz/v7CszkjOwRfu
         ayIbn7J6MZ6LABK9vpuCF081H5sl/Q8ZbGtbOEXMdSp6PCg6We/dTvPKV0t+kKCqx32J
         bOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116341; x=1795721141;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ALLBk8MdTkFwcPZqYQO+ZVSicu8jJEanZFGqZFoBPVY=;
        b=ixsPWMSxUMji+ikEU/gH1z0oW2v11pmIoRYcC65r2NLTZu9QzyowT74XFK4cEtNd0Y
         xgPncfie0kOP2op+WqPgf+X+T9BYDVlM2QYfO4XV8SpOy8yFNNcHIlWMcMVuB9a+qlSW
         /gFEBgBMtOOMTn6Ls7p7ZR+IGtwLuxTgymsbWUwhbfxiUbU732Y4KslACGu7qNARlsSr
         NiFuPb16TPjW/wu2A+o1ue4lbLD+eOA4SV89zg1DdfZrag93hTeLr5Ryo2uU2G7kha7A
         qEqQHJxSlCFIr+hGGdTzbhzyltIXt1Kc2BQvGlF2NTJUP2vzTHrnL33RW6Gv7HKFcYax
         4uig==
X-Forwarded-Encrypted: i=1; AL+hErFaFE61LGT+7BZqD33slN48WLL8e0vX+ndxOuh6mhhG9S2EhRc7Hy0gtsleFfOc66KzhR/H+CYekw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+BaFqsEvel5TJzDsU8frztDAf2XeCgzf1kTYcNIiE0fOM9fSPR
	3DStc3pfaplUFK+2r/T/aoKG0mZDh5KgEb7/U/xaelsYkDZ/I3Bpp3H5g/FeupKiEoPedUdCwh4
	EtCmD74DLqg==
X-Received: from pleu15.prod.google.com ([2002:a17:903:41cf:b0:2ef:d860:1c85])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fda5:b0:2ed:fb0:bfd6
 with SMTP id d9443c01a7336-2f031e08699mr15736045ad.11.1795116341051; Thu, 19
 Nov 2026 11:25:41 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:14 -0800
In-Reply-To: <20261119192520.1983406-1-irogers@google.com>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119192520.1983406-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261119192520.1983406-4-irogers@google.com>
Subject: [PATCH v4 3/9] sh: sq: Add missing kobject release callback to ktype_percpu_entry
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Srish Srinivasan <ssrish@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
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

In sq_dev_add(), sq_kobject[cpu] is dynamically allocated with
kzalloc_obj() and initialized with ktype_percpu_entry. When
sq_dev_remove() calls kobject_put(kobj), the kobject is never freed
because ktype_percpu_entry lacks a .release callback.

Provide a sq_kobj_release() callback that calls kfree(kobj).

Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
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
2.56.1.708.g77570a6a1d-goog

