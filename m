Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140759;
	b=IcvavHkdHMyBdLNnPAQkG1xGQzyFijHHz9vFw5Tq/PbPKaesxDpciN9d+e5RSvquybWP
	 w+m8B/bQbRMKeJ/DQgr/n/zcLWlBnxJk+S9wLvCO3hgQZkYFKIEWJ+4pblo4xLZnvbS9w
	 jliw3UKpxa9jaNjx1+uYvTZYhCiWXRbl4xQ6QU0wQ4zst9s7eNqe/YW9F/HtZ868TojUC
	 LrgStIXUS/XG7RLNSqno5jltwyZ0yiuUsm+T3lZaErHAXYDFpUaTqIbMXRvD9mHRYBsbi
	 JAOMP0PkzV9WhEtSIaoyIUzU7z0yOFqdSqAFnAZpMzHNQe+DwqRMsd1FqtCi3P2Ki3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=kZ/TSWTZAJNbAAfYXfetESQgQ8bp7xksXUAoJHJHiFs=;
	b=aC6ujEl5TwCJ+ws3kUb5lC0ENawKj14IOGke9SPatuJbIsv1vueNZwZG2ghk0Q8cXZZS
	 TS7EGjZ/7r7qkfTfMnzkBFN52/kxBfcMWys0alHTEtHs4MOJ1KGwe8MVTXeYL0GNTzMq2
	 p4Extk2BpjFl+/ndHF7htNDrlueNYeoJPt2p1Pzg73MmUtzDO0/5/DIHsIzXWiE0sYvi0
	 hHYcX+PI5IQSygg68nqZHfDiEJtm2o3rSQQlxV2dQsLt0JtHVUNFCTO6t/VxurSrXm7Lv
	 pVL1SPva74hd5vgj8CuA9PmSyCFbdQgzVBGR1ZVjHYlO4GFWPJShpfKiAHaBdSUj6HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AM0U1bTn;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785AF606A335
	for <linux-sh@vger.kernel.org>; Tue, 27 Oct 2026 22:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 785AF606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AM0U1bTn
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-16bc6f3fdb1so341007c88.0
        for <linux-sh@vger.kernel.org>; Tue, 27 Oct 2026 15:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140756; x=1793745556; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kZ/TSWTZAJNbAAfYXfetESQgQ8bp7xksXUAoJHJHiFs=;
        b=AM0U1bTn+FBfrtRXE0vv0BDIqy142hMoBHOxySxpTba8mZqsCKdiH7AcgMgAyDergD
         /Pm0SA04DcRopZol9tqMR9uqtV7SWWbXLODsXQW5E2Nz87dJUJTEv9MENnB6uZEDCydX
         bzH1uuY83A2Ilur70UWvrINSlPegvzIpxnoUDHLAKQyOSZjyd7ZnaKpnu96OtHfa681+
         yn32BwRvIzkiWcgRF/RQt1W13A77VnuM5E40B2lvNBFScs2cQI7oVMCTZ1fs0nUoOor9
         yK0A2SJcXO2B/nbS31dOcpWY13YkRl2qukDyyZeX28bXtF+bXwoIzHqgunH+hlapdIuA
         bVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140756; x=1793745556;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kZ/TSWTZAJNbAAfYXfetESQgQ8bp7xksXUAoJHJHiFs=;
        b=YnrhFk+QmauiEi7XaXH8kigRhH8pgYK0OSmvmKVzF676tVxoNVhpMs8RCbOynl2Q9i
         nuLpWRtRFITFvShTZKZQP07MbZgKdSUQc74oYwFn/vJMC39ADmlDcJT5RpJEQC6uhB/N
         95LiLjex2O9MiXoHdIDonvIJK1Qx2uhIQzz0+Q4cyiLA/4I8htmhjG6xnZMEAT9uClNe
         UxTU3GRtgo4NrLvpO3lpzdFGj1PF63BWg2MIVsk/ybvqpbHbMtC1/IXpKUEfeg3vxbTH
         NXr06O7XYwJd96p1KGmmgFcqEyQx+eX+QxWWPKB+sogXfB0+HhtyvrgxZDpNm+5cOK4J
         yStw==
X-Forwarded-Encrypted: i=1; AKwUvByk2up9RBymC634aC4vn2O4dXarOTu4juck0QjywaG5+EB+uhILzz6C1A8c7rbBFLvqIND6QQt5/Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYISI6J3vZezLr6llbhyHlUsoOdEtoEszonmtzeTlkk73GUfCcBM
	REiPdQomA4clNi97STn0NtJuIZYMqnqPFyztCR4QLoaNccrNjW8MBhoMhPS+5Ao+Ub/f6qwUDmd
	cWHWACM96yw==
X-Received: from dlbrl28.prod.google.com ([2002:a05:7022:f51c:b0:192:91:5cc4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:618:b0:19f:527d:96da
 with SMTP id a92af1059eb24-1a6cdd3e006mr1194989c88.33.1793140755024; Tue, 27
 Oct 2026 15:39:15 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:37 -0700
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
Message-ID: <20261027223847.652884-3-irogers@google.com>
Subject: [PATCH v2 2/9] powerpc/secvar: Add missing kobject release callback
 to secvar_ktype
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
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Nayna Jain <nayna@linux.ibm.com>, Eric Richter <erichte@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

In add_var(), a struct kobject is dynamically allocated with
kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
However, secvar_ktype does not define a .release callback, which results
in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).

Provide a secvar_release() callback that calls kfree(kobj).

Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via sysfs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/powerpc/kernel/secvar-sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 395399bbab2c..f3f6ac25ea78 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -126,7 +126,13 @@ static const struct attribute_group secvar_attr_group = {
 };
 __ATTRIBUTE_GROUPS(secvar_attr);
 
+static void secvar_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type secvar_ktype = {
+	.release	= secvar_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
 	.default_groups = secvar_attr_groups,
 };
-- 
2.56.0.313.g2479322e68-goog

