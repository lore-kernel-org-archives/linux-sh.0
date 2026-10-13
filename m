Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA424568FAD
	for <linux-sh@vger.kernel.org>; Tue, 13 Oct 2026 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931245; cv=none; b=JODQ+fxmADv6YFOjlV6sl1x4L2K4mat7v9fH1DFaKWORz2PB7gI7Ju8m1a/Cl7Wv3L0oGrb/T8O8l4s4MwqfU59+clRKPrvcvDJUP4EiQogHXhUSinVK+FgIDw2p29pHFJ+kREUl4+x04Zcf85623b3OzgXnJxhMd3EeBdjhKds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931245; c=relaxed/simple;
	bh=tPRKbYfVHQfak8O9UULn1z1wTu0bqCitWqFM3f53KeA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ohZDRay/JPZi8XuFnq9fMCCxS3ZZLJLthKblKGrPDvykD0mAjB6YtuQ0vWN0l6eSVuKmEsKSSJdgLeEUbOxlAluEUgPQ6kx7NH6u1YS4iT9kHJTtHhopBEmZA4hrxAW/h32K/H7NfzDtmk4me3fpWRzIC61V69gJI1GZexiLl+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zoe65Zyi; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zoe65Zyi"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3548cdfd2fbso5530211eec.1
        for <linux-sh@vger.kernel.org>; Tue, 13 Oct 2026 15:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931236; x=1792536036; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5eLIAAx2L+9DvCRKYW0jDBbtdiyv3jUNIhafttj/B0g=;
        b=Zoe65ZyiGdxsjl3hWc0yoCpyOBzWezy5F9wDqmgtx4L67w2KhG9hNha1UwQuQsv0qQ
         m6QdJ/pBLnXPApsn5OAOMozTz3Cb5WMGx/jt0VD5ZMaKwEBkgK9fxqpFJG4voLty2wbx
         qf1K2civQ4fQLcT/X5qP+jqTPFZEauxjbzpBSIyzn4XJtji5Y39dJObjBJitTvIbO/Dn
         75S9UBdrMkpvtP/B1jZLqNNkYrI4OZRtU4HCsUKNW1Mx6DK99EVfpvOD9v7KRjWzdI6N
         75ReC/20iNlLQQaqr4+TdllF01e+nBy5nR9OteikeNJCIjWoUDOttjSi6yKXfCR7Yjz8
         ItmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931236; x=1792536036;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5eLIAAx2L+9DvCRKYW0jDBbtdiyv3jUNIhafttj/B0g=;
        b=KHHBKkpx8IIZqiGwypSzIZ5KTt/ktUZlihZ2a7egXSM04r/kk/MWr1FNuyehp/5taM
         wrHqe6s/aAj8p+pvedFAzkBnb9SDqGCANkDtgHwHP/LmYJtXdFayWwuT9fxbrSnsF8gS
         9y9C1/vwmqvMVHMlvoQVaEaxBLQzVsJx0F6zm3Ws7VpKFVPgw7qehd7EA9ZkLcPHhpVw
         g6hWlsjjQOMooxJw+r3MIoxwIgiRSQpjE6G4vP4Yf5vzPyerPZQ2pwY8Dlg2trLDsIGo
         r4GNjuZ+BV5STmhSdFrcP466LOJ8YQ2w0F6kv+vpO4gYUoACEzKI4NLefS7ZIeNm6AOK
         GqxA==
X-Forwarded-Encrypted: i=1; AKwUvBzDh9J2mFSORpNb8bjED38dYhGq6emnI/NPNQi9ssMaihHK6eobfqqqMvmd7hX1mviO/1gk1c80kg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIiZEGa5yGKny+1DayBGn7tVLMYaZUtQeViAZvugbPNleGMqHTf
	ELkMp1hJFgqO8wWXKVj38D6vy2NYYRMohtE+yduIIR7fii2iJUaEngXf/GHU662Yy1lAR3O3kxs
	0HI1PWPHqVw==
X-Received: from dlbuu9.prod.google.com ([2002:a05:7022:7e89:b0:16c:bd18:1ee2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:231b:b0:165:55e2:2d69
 with SMTP id a92af1059eb24-16a640fcc35mr21018967c88.46.1791931235508; Tue, 13
 Oct 2026 15:40:35 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:45 -0700
In-Reply-To: <20261013223946.1836757-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013223946.1836757-11-irogers@google.com>
Subject: [PATCH 10/11] drm/amdkfd: Free queue in procfs_queue_type kobject
 release callback
From: Ian Rogers <irogers@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

struct queue embeds a struct kobject (q->kobj) for procfs entries, but
procfs_queue_type had no .release callback and uninit_queue() freed q
immediately after kfd_procfs_del_queue() called kobject_put(&q->kobj).
With CONFIG_DEBUG_KOBJECT_RELEASE=y, this causes a use-after-free.

Add kfd_procfs_queue_release() to free struct queue from the kobject
release callback, change kfd_procfs_del_queue() to only remove the
kobject from sysfs via kobject_del(), and drop the final reference in
uninit_queue() via kobject_put().

Fixes: 6d220a7e7971 ("drm/amdkfd: Add queue information to sysfs")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 10 ++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c   |  5 ++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0a7c1900da95..6099cb893573 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -510,7 +510,15 @@ static const struct sysfs_ops procfs_queue_ops = {
 	.show = kfd_procfs_queue_show,
 };
 
+static void kfd_procfs_queue_release(struct kobject *kobj)
+{
+	struct queue *q = container_of(kobj, struct queue, kobj);
+
+	kfree(q);
+}
+
 static const struct kobj_type procfs_queue_type = {
+	.release = kfd_procfs_queue_release,
 	.sysfs_ops = &procfs_queue_ops,
 	.default_groups = procfs_queue_groups,
 };
@@ -550,7 +558,6 @@ int kfd_procfs_add_queue(struct queue *q)
 	if (ret < 0) {
 		pr_warn("Creating proc/<pid>/queues/%u failed",
 			q->properties.queue_id);
-		kobject_put(&q->kobj);
 		return ret;
 	}
 
@@ -699,7 +706,6 @@ void kfd_procfs_del_queue(struct queue *q)
 		return;
 
 	kobject_del(&q->kobj);
-	kobject_put(&q->kobj);
 }
 
 int kfd_process_create_wq(void)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 15eeaaebbbcd..8d1afc5b47e2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -83,7 +83,10 @@ int init_queue(struct queue **q, const struct queue_properties *properties)
 
 void uninit_queue(struct queue *q)
 {
-	kfree(q);
+	if (q && q->kobj.state_initialized)
+		kobject_put(&q->kobj);
+	else
+		kfree(q);
 }
 
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
-- 
2.56.0.385.gd3acb90ef8-goog

