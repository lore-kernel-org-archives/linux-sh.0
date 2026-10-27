Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140765;
	b=ee9e9thYWo9URnuJ2iz/02kDZlKYflrs2YyB2oBd3JuykE7FvM7RN7NW6d6g4GMwse0u
	 yBV3Oq5OlF5eKvGKlzf8uKcJOLRRTX55vaEvK4bR/V14Yh7txbDDlJJZHq0zaepLHDE7+
	 qXn0XmFr/cKg4ZuBFWuBOV2pYGVqNVTcMYvjf9awVSsGI8lb+Y3r2j/NA/zTRpKFA/AAQ
	 rS5oKh6Yn1heg2EkfNtKVdL/zekmg3+4KESgz21x9Ab4jA37E+J5CU2gEmV1N5WwQ2e5w
	 I/WSkzKAKHhtdh0T8lpXdHzLXjDZaVOfp+YH8b2ZwutaAZZLIMzCj7v+ZcuqJZmQLpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=2p5eYZPmxsY9xh985bGLWJJ6j3FfFGXO/U6MsVvS8Z8=;
	b=xxTbbowtbBnB3iAi+7JBskJdAQsuViP4QIbku2HFRDCVlqxUXmFiHTC8ngc8XLMVHTMk
	 9p0GyTll+J3oRmgMj2O2OfJpeIR8EsCE6TEm3bHD/Qp/T0GKkI+5YVSrmTC0Uy77uhvYa
	 ztl3WMZ8bqkTRyI7N0tRqCfKOQFhdVhJv2BIGgcNxAdVPwJJNM+VnZfkd+iIPV5NT4zU8
	 O48QyzUnHdI0wKRm/UlYlUCCQA44AgBYO/iah0Vpa3U8hezmuCg22IWaUUJsH034S79Bf
	 xAUa8WLCNOEBjzMtTV4oafXc5y1c9sStIcRfQsFWwk41ewupHbEfLj5Yf6hHBKKsTPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jcs6nxhJ;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAC860A380C
	for <linux-sh@vger.kernel.org>; Tue, 27 Oct 2026 22:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AAC860A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jcs6nxhJ
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36a223755e4so379184eec.0
        for <linux-sh@vger.kernel.org>; Tue, 27 Oct 2026 15:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140764; x=1793745564; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2p5eYZPmxsY9xh985bGLWJJ6j3FfFGXO/U6MsVvS8Z8=;
        b=Jcs6nxhJpf5GT54urOO6gpd9OqbuJ2p/UilLydmtjg7AMz6yqH9E3DujDYPhZ0SzZN
         /D4cYLHESKHlom7AZ+K1Cj/MDA5ovzRIuYT3tdsybd0V1vQkBAgbhfkdptpH7L4By/1J
         w7M4UIAMqw+ACSZHn17czaCcP2lnur8+rJTSf+dQmNoPAcc5jn4Nam5fRkf7ccexHBIt
         FjGUrAjHNIz4FKMAK86Zw0TDQrC9yeswGzdR+66NQXLiaUdX2jeouRXIpEBu6iQ3vzOi
         gmftouyYHuvXQFSwGAGNlPOtXhePcI5IFfzIErtkdYqGZWdhPzH5aLZYIyuog3ZHaPo7
         DSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140764; x=1793745564;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2p5eYZPmxsY9xh985bGLWJJ6j3FfFGXO/U6MsVvS8Z8=;
        b=Tn3QFd4eNq6NcFAuUOiwS9gDitm0RYzGLu8fYi8yCdFKllPezQIzr5/RVPSIZXjuDl
         q4V65fSTZzik+qr0go1ctDt7BJs5fQ3zFz2eq3oFHhV9S/MiwD1S8WuDRJsdreNaJaYo
         cqFP19NdgVwlxdQ9AaB7q8jhO261rs+/TniPCyxyVzqm7wmf7JhUM5BYkQvo7zbCMb63
         +BVHTLI2BYrcPSydkPQjVHFHuKRfyyJ9Qn8+vRTVBC8jZapnz58VE0bLXNhAeLQKINOX
         UUPtQ1123AIz5NKklJdEdmhABS6n+3ElA0rOeMqlV45DQr/6SFTp3ZujoPv0tD0fAqw/
         lqNA==
X-Forwarded-Encrypted: i=1; AKwUvBx5AaP2ANGTVrwnkIxqZu4Vj8/PWqiEMvs4T093OQTUaWSB4XBbaBAMlqGjc8l1LfoGOGlPSohr3Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYKnmIvSWHtkaW4CM1xx/GxBo74/I0CxXrWtsp6MxH6Lj87qaNgy
	r8GH+LrTaUbD3hv9hVBf/7z90jgqaeW3oosobjUxCjR2CdjR625Wq71cGfxv6iq0JwOTxXJA9jM
	zE0h8Ysz67g==
X-Received: from dlbsv1.prod.google.com ([2002:a05:7022:3a01:b0:1a1:3ce6:560b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fd04:b0:1a3:bfb6:44ad
 with SMTP id a92af1059eb24-1a6ce2ff120mr1130455c88.32.1793140763880; Tue, 27
 Oct 2026 15:39:23 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:40 -0700
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
Message-ID: <20261027223847.652884-6-irogers@google.com>
Subject: [PATCH v2 5/9] dlm: Free dlm_ls in kobject release callback
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
	Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
	Greg Kroah-Hartman <gregkh@suse.de>
Content-Type: text/plain; charset="UTF-8"

struct dlm_ls embeds a struct kobject (ls_kobj), but dlm_ktype lacked a
.release callback and dlm freed the lockspace structure directly via
kfree(ls). With CONFIG_DEBUG_KOBJECT_RELEASE=y, freeing ls before the
delayed kobject release runs causes a use-after-free, and unloading the
module while the delayed release is pending results in an instruction
page fault.

Add a completion ls_kobj_done and dlm_ls_release() to complete it when
the last kobject reference is dropped, waiting for it in free_lockspace()
before kfree(ls) and in the new_lockspace() error path before module_put().
Also delete the kobject via kobject_del() before stopping dlm_recoverd
to close the window where concurrent sysfs writes could wake the stopped
recovery task.

Fixes: 3514faca19a6 ("kobject: remove struct kobj_type from struct kset")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 fs/dlm/dlm_internal.h |  1 +
 fs/dlm/lockspace.c    | 26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 74c2e77d1b55..95b3bff0cb57 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -576,6 +576,7 @@ struct dlm_ls {
 	int			ls_create_count; /* create/release refcount */
 	unsigned long		ls_flags;	/* LSFL_ */
 	struct kobject		ls_kobj;
+	struct completion	ls_kobj_done;
 
 	struct xarray		ls_lkbxa;
 	rwlock_t		ls_lkbxa_lock;
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index a9c98b4f378f..2dccd080a10f 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -179,7 +179,15 @@ static const struct sysfs_ops dlm_attr_ops = {
 	.store = dlm_attr_store,
 };
 
+static void dlm_ls_release(struct kobject *kobj)
+{
+	struct dlm_ls *ls = container_of(kobj, struct dlm_ls, ls_kobj);
+
+	complete(&ls->ls_kobj_done);
+}
+
 static struct kobj_type dlm_ktype = {
+	.release        = dlm_ls_release,
 	.default_groups = dlm_groups,
 	.sysfs_ops     = &dlm_attr_ops,
 };
@@ -355,6 +363,8 @@ static void free_lockspace(struct work_struct *work)
 	 */
 	rhashtable_free_and_destroy(&ls->ls_rsbtbl, rhash_free_rsb, NULL);
 
+	kobject_put(&ls->ls_kobj);
+	wait_for_completion(&ls->ls_kobj_done);
 	kfree(ls);
 }
 
@@ -435,7 +445,10 @@ static int new_lockspace(const char *name, const char *cluster,
 	ls->ls_lvblen = lvblen;
 	atomic_set(&ls->ls_count, 0);
 	init_waitqueue_head(&ls->ls_count_wait);
+	init_completion(&ls->ls_kobj_done);
 	ls->ls_flags = 0;
+	ls->ls_kobj.kset = dlm_kset;
+	kobject_init(&ls->ls_kobj, &dlm_ktype);
 
 	if (ops && dlm_config.ci_recover_callbacks) {
 		ls->ls_ops = ops;
@@ -567,9 +580,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	wait_event(ls->ls_recover_lock_wait,
 		   test_bit(LSFL_RECOVER_LOCK, &ls->ls_flags));
 
-	ls->ls_kobj.kset = dlm_kset;
-	error = kobject_init_and_add(&ls->ls_kobj, &dlm_ktype, NULL,
-				     "%s", ls->ls_name);
+	error = kobject_add(&ls->ls_kobj, NULL, "%s", ls->ls_name);
 	if (error)
 		goto out_recoverd;
 	kobject_uevent(&ls->ls_kobj, KOBJ_ADD);
@@ -582,7 +593,7 @@ static int new_lockspace(const char *name, const char *cluster,
 
 	error = do_uevent(ls, 1, 0);
 	if (error < 0)
-		goto out_recoverd;
+		goto out_kobj;
 
 	/* wait until recovery is successful or failed */
 	wait_for_completion(&ls->ls_recovery_done);
@@ -600,6 +611,8 @@ static int new_lockspace(const char *name, const char *cluster,
 	do_uevent(ls, 0, 0);
 	dlm_clear_members(ls);
 	kfree(ls->ls_node_array);
+ out_kobj:
+	kobject_del(&ls->ls_kobj);
  out_recoverd:
 	dlm_recoverd_stop(ls);
  out_callback:
@@ -615,6 +628,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	rhashtable_destroy(&ls->ls_rsbtbl);
  out_lsfree:
 	kobject_put(&ls->ls_kobj);
+	wait_for_completion(&ls->ls_kobj_done);
 	kfree(ls);
  out:
 	module_put(THIS_MODULE);
@@ -740,6 +754,8 @@ static int release_lockspace(struct dlm_ls *ls, unsigned int release_option)
 	    dlm_user_daemon_available())
 		do_uevent(ls, 0, (release_option == DLM_RELEASE_RECOVER));
 
+	kobject_del(&ls->ls_kobj);
+
 	dlm_recoverd_stop(ls);
 
 	/* clear the LSFL_RUNNING flag to fast up
@@ -759,8 +775,6 @@ static int release_lockspace(struct dlm_ls *ls, unsigned int release_option)
 
 	dlm_delete_debug_file(ls);
 
-	kobject_put(&ls->ls_kobj);
-
 	xa_destroy(&ls->ls_recover_xa);
 	kfree(ls->ls_recover_buf);
 
-- 
2.56.0.313.g2479322e68-goog

