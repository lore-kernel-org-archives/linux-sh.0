Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140771;
	b=DIJa9QeTfEeUbI2FRC62B2WKlA+DbAWB2vDyt6yQlFci9+uyEfrNd/0g/muR6hbVk67Z
	 pKHP5CVojhl13cYJUEs76OlwbRlMQTdtDKQO7VhzqtiSVISjOvx2HvAX+qPQ+Ux+ADKf5
	 oJAXVDikPUPMmjloM2ED1XyIdXOVUKvmnFDnhIJ67KfEtkKFuduCdySEAps9+9nIqzEN0
	 j+osHQjIjlDaQDbAmsbLZZFYgZuz9krU9hm5nJVuQqvKw3PK3h+ysYO7K8ABq0ySy92ob
	 PWY/wYrVh7Z1nFlIwlt/bEwgfrCkjyoQGb+mceFqoE0OSuktBquTWV0d7i91g8hHVhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=aItLXVgOXAbsJZn2OZIWl+3TQwb1N1Woum6UsPYCRPI=;
	b=pIDFbDDNaIyWp2DPCdnCaZ9wMB3Gy+HFbMDo2ID51hMb4hlUhlFwWh1xQwmPVQtcVwJE
	 GSRc0Kqd5ssSiU10bV25I4vhISY5hyNn6LHUnCzI7BYNbpkTXaIM+Z+UqVJBJgTAiezw4
	 kKKk7EKAOLZEPks+fyyWk/A3aYL7u/BoEkN75jZvPZE7cQ5E6qx/SidTKu2hsG5PPttMh
	 tOMdt2VZTDkgpV33o9aNMVwZr/eadZFggjjbRLeG8uhdZE/k2sCqLSDshAKvNNPP7Khwt
	 10OklusgpEDryDtIws/kNOJg/EZBJtQCtuM4gl0EW0ROOltiGmYqPjbqLCd7mvctdjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cqwNTjHA;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA8A60A5BC7
	for <linux-sh@vger.kernel.org>; Tue, 27 Oct 2026 22:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DA8A60A5BC7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cqwNTjHA
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1a5005fd0f8so277490c88.0
        for <linux-sh@vger.kernel.org>; Tue, 27 Oct 2026 15:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140770; x=1793745570; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aItLXVgOXAbsJZn2OZIWl+3TQwb1N1Woum6UsPYCRPI=;
        b=cqwNTjHAYXOy8Mi0KDVWON2iofqVJPaU9RstSleLyvA0ZnHHca9sgwMffgWuSP96Vq
         Kpgku/LZAhDRayOYk8QgB1Cz1AwlyVsDfvTjhOxiQE6MZPH70GmVtxnVpgC0CLWmUxK9
         IxTAqbdqAGbhhlKKZua67l8+9/SRZpDmPOIu25o5ZfY4arDHKBM3F+ILVqikbjfrGpZm
         5TcNRqJAXT0C8XFBzOxtasn4OfHvhdu19U4W5KHMuHF1ZKBxJJPSpLvE2u+ciYeZvDCh
         oo6FbSB5vK82QmvlGaMLVdVgDui47ubesXtV2QdmfdzgUkdxRwV6GI4rakX9wYnSs1Mf
         1abQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140770; x=1793745570;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aItLXVgOXAbsJZn2OZIWl+3TQwb1N1Woum6UsPYCRPI=;
        b=aFZ9Auuulyh2fd6uzSSmtYpFofKFgPi6dV92f+NVHiQRYdWy1viodTW3qDUyH5w+WK
         cqMgs4J9sr96tIRIzmI+bCvhOBQfWzPXpUwAWiB2z2MQgEvO5Ok8zDtob7d08SyGj+Fz
         pwu7LtEddHPtLpsvvlQ1frOtbZ6BloC6PNce5YPSvbSU4YCO+0bzr4rI+EcRCL1btEzk
         3bf5zgaxL5Jx7yq5+3Ww/H0NeK93pVXGgeznLeOmUO85aYHnV4uS6VhZZ43jvkr2vd9Y
         qh4GAZLI+I1giTB0iYoeTsf0rvvDd4fc27e21SAI4AdZiym+FdCzCUAsKQVzU6aE5bt/
         a9tg==
X-Forwarded-Encrypted: i=1; AKwUvBwAEcTYv/uAX/iUHhXGZPzzmynIOd9C2lknbNarV6UH4TvUM1u8zzIxijdUTsv1QKNIp7/pTXgOSg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIXe5C9GWrRTQVjRTmeCirqqWJfeuKmk/ijf+DeUmP+0TGO9u4+
	bDq5fZnLbLUC+k+XHF2l5DtRfycRDQ7hcQI3mNh3w8b8lJiwM/w1Oahyyj9CGJD8IebwGaIl9rl
	iiq+qG/aFLA==
X-Received: from dld12.prod.google.com ([2002:a05:7022:30c:b0:191:45cb:f8d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:607:b0:166:af48:a2ba
 with SMTP id a92af1059eb24-1a6c2c71125mr1317138c88.0.1793140769446; Tue, 27
 Oct 2026 15:39:29 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:42 -0700
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
Message-ID: <20261027223847.652884-8-irogers@google.com>
Subject: [PATCH v2 7/9] ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
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
	Richard Weinberger <richard@nod.at>, Liu Shixin <liushixin2@huawei.com>
Content-Type: text/plain; charset="UTF-8"

ubifs_kset was a static struct kset using a custom ubifs_ktype that
had no default_groups and no .release callback. With
CONFIG_DEBUG_KOBJECT_RELEASE=y, unloading the ubifs module while delayed
kobject release is pending causes a use-after-free on the static kset.

Replace the static ubifs_kset and empty ubifs_ktype with a dynamically
allocated kset via kset_create_and_add().

Fixes: 203a55f04f66 ("ubifs: Fix memory leak in ubifs_sysfs_init()")
Tested-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 fs/ubifs/sysfs.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
index dbf967dcf26e..e20931e3a62f 100644
--- a/fs/ubifs/sysfs.c
+++ b/fs/ubifs/sysfs.c
@@ -80,13 +80,7 @@ static const struct kobj_type ubifs_sb_ktype = {
 	.release	= ubifs_sb_release,
 };
 
-static const struct kobj_type ubifs_ktype = {
-	.sysfs_ops	= &ubifs_attr_ops,
-};
-
-static struct kset ubifs_kset = {
-	.kobj	= {.ktype = &ubifs_ktype},
-};
+static struct kset *ubifs_kset;
 
 int ubifs_sysfs_register(struct ubifs_info *c)
 {
@@ -107,7 +101,7 @@ int ubifs_sysfs_register(struct ubifs_info *c)
 		goto out_free;
 	}
 
-	c->kobj.kset = &ubifs_kset;
+	c->kobj.kset = ubifs_kset;
 	init_completion(&c->kobj_unregister);
 
 	ret = kobject_init_and_add(&c->kobj, &ubifs_sb_ktype, NULL,
@@ -139,18 +133,14 @@ void ubifs_sysfs_unregister(struct ubifs_info *c)
 
 int __init ubifs_sysfs_init(void)
 {
-	int ret;
+	ubifs_kset = kset_create_and_add("ubifs", NULL, fs_kobj);
+	if (!ubifs_kset)
+		return -ENOMEM;
 
-	kobject_set_name(&ubifs_kset.kobj, "ubifs");
-	ubifs_kset.kobj.parent = fs_kobj;
-	ret = kset_register(&ubifs_kset);
-	if (ret)
-		kset_put(&ubifs_kset);
-
-	return ret;
+	return 0;
 }
 
 void ubifs_sysfs_exit(void)
 {
-	kset_unregister(&ubifs_kset);
+	kset_unregister(ubifs_kset);
 }
-- 
2.56.0.313.g2479322e68-goog

