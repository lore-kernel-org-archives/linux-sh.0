Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116339;
	b=G4WSumJ0PminwfVhQvOMNe9/IIZjWzXTHOc1CfCiYxT3BxqQcxE7MPNaaAqZ6hS7PCza
	 50YdzmPQyShQwlbTyi7Ebt3JBjIgZMTti8OjvgDpc7N2uU/IMfceuh1QuSuz5xMnzDELA
	 tpEOynDNSQ1a0MZE1wEpFfHpmL6ux220aQO4A6erma5fBxSPDlg77J1g8WgFMcNIkmBXN
	 XVP4a60k8XIX7Bg77kdXEEQwwQC1OsQuFzN9cYj1o1rXGpOGJhxU2h7EjyBwohyDXSeA3
	 02h4BOE3rjQpy0FSOLU9BiECOK+ScW7kncUIet+lB3S59kx/5yyg+QL0dc2ya9F6jlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=rEPVdW1UHjKh7bwOu3YUjmxSg8vF1ESXVYVOzAB45kQ=;
	b=Fa91oT/G12SFpKDAglaMs/ENobKOyY+KRwwF3KiTP3SCSh5rRghE/5NuJ5FZsxVEhYqi
	 mSopHo+vCEIaaPNT9X6ylOHF4MvX1bcPaF5Z7P/1yT6dObwLT57j/fqQbQylRdQ5xWTsK
	 S+IdQ8dvHBzFnZL5GoJcBVUIpMkoOzvDxaaHAsdpv0N7G2c/z72qy6/QjYz7fZYCsHDuh
	 4CazTCANdUHGppYHVLMUEDVeAaIobBY9VRPVctoIpU174Mn68nlxNr44UjYGOxsl6z7gL
	 wfP+ezr82KFvVxiHhid8jOWbNjdZZ0Oj+3ZeCVL2uX7gSuAohGjvUvsk7gC4OVnsb1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="nkk/aHO+";
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C424E60A260B
	for <linux-sh@vger.kernel.org>; Thu, 19 Nov 2026 19:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C424E60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nkk/aHO+
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-547ae874949so264540b6e.2
        for <linux-sh@vger.kernel.org>; Thu, 19 Nov 2026 11:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116338; x=1795721138; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rEPVdW1UHjKh7bwOu3YUjmxSg8vF1ESXVYVOzAB45kQ=;
        b=nkk/aHO+iL/QVslKweTpGRJyta8pMKUanDqzsOYLUoHxYvHbcPk0K1oPjzbmUIgX5C
         a4ksEvuUXVb4knCRuLE/pngJN0Fu2U7Ksnr/txK6kZlULF0dMIonkXOHbeOOy6kXkLF0
         hVfNMJ3zBFp3whK2WapWwlMlx+6npAGmfKXoz3p7CihvOHcneCzBcGa76xjoOS4s2x8p
         V7MoBox3I5jV2aUG934ychxiasYie3HbUjHiyYnzAIkJmMHZ2tir8L0UT57NTHVWaibf
         +6uN66iZBFfXTXXFMLCcqQ9E/Qx4vuSInlbSJ/WlGdcn6yjZQcoU5sQtMa7Oi6dIP0VC
         1Ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116338; x=1795721138;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rEPVdW1UHjKh7bwOu3YUjmxSg8vF1ESXVYVOzAB45kQ=;
        b=U7xK54qoKnUaUThinMJpr44O/EBDmi5HdOuhQtb7lh+jsZ2qP9Fa4LmomHY3b9jz7O
         zPwqcpDuFc+q3AeaUOicqPN1hNVfdrk48eeATrTE12yS9nMLAF4ewBnNeGvxzjWvjz+k
         K1xaKG6lzIkbv29k/ndThK4v60+JRCge7t+/rh/JLJu8neQI3cpxzuS2qYWIP8ak25Ne
         jBMoue+xBmU3/c0tWWRopVG/XcKtgwZOOGRrH4EwPNC/P6KO7hOXVwqpye1zQFnj/TCu
         XqqKdwjfsmAYmd+Dw71nNfeLOa4g2P40s87ZdcdffzbWlyFqSbB2Cw1buhkHHakM/P8L
         Lw2w==
X-Forwarded-Encrypted: i=1; AL+hErEadNDriuPesQ4eYJV7shw4a6P09/RKHwVF4TKS0HY4CrTeLoJ1lJZ/gxYh7+3GupYGS2tacWOp+w==@vger.kernel.org
X-Gm-Message-State: APuU4Z+9JaB5Zc0qK2iDBSCW8iSmNzW3XOp2ZarnD26UxX6BaAQLuX8k
	keqjpNl5cH0e/BTQZIgHw9ZDI2qzh0YF8RCav1PJRbkoLMfngOYMQ+oRt1QZXUa4TpEtZEz1uYC
	IzaUI8nKbnQ==
X-Received: from ilmp8.prod.google.com ([2002:a92:c608:0:b0:51e:1b8:eceb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:c110:b0:576:4595:9836
 with SMTP id 5614622812f47-57a0ba52419mr994155b6e.40.1795116337420; Thu, 19
 Nov 2026 11:25:37 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:13 -0800
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
Message-ID: <20261119192520.1983406-3-irogers@google.com>
Subject: [PATCH v4 2/9] powerpc/secvar: Add missing kobject release callback
 to secvar_ktype
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

In add_var(), a struct kobject is dynamically allocated with
kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
However, secvar_ktype does not define a .release callback, which results
in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).

Provide a secvar_release() callback that calls kfree(kobj).

Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via sysfs")
Reviewed-by: Srish Srinivasan <ssrish@linux.ibm.com>
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>
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
2.56.1.708.g77570a6a1d-goog

