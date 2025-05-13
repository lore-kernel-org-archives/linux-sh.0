Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE10216386
	for <linux-sh@vger.kernel.org>; Tue, 13 May 2025 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747127904; cv=none; b=CRcdNb2bDObmKTwDcF1Feqk7SFcSIb7AOMs/yRUyDlKpIjxEwrxyr93R35DqiP13HCsk7uZlm0iWAm0fAIdLbTZZVdYp8niOHLLPmVMty60YU0PLxxaLpWqDtdwZHsbBJkPtzRIJpw5ZT9i5xS4j129zrfr3a0vN3uv+zXfrrh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747127904; c=relaxed/simple;
	bh=YQGIdXvgchaWb1V6UiKUwEOK/o3C4y9T6tou+r20L0U=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=OhVnVUB0ap0ooIaXYSb4/jej9ebIDDeiuCYTR7ZUPTvSyFlk1pdHYc1slKfqsmjWKV0+tCrMGwScwe2U7OXCahubEt1Iet3PqwyPpEgkcSxjdvPWfQtOYaj+boaTfvTMmfmFUWhk1R73LvJZLJYfQlsYqs1WaoSVzsM5FF0Zv68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hll8SPtX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hll8SPtX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747127900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQLwPqXkUI6z4QQX8G7LIPfd+304h8Dijb2vEngn3fA=;
	b=Hll8SPtXtIHdpB1Y1o37ZPtIPg/s7zUPaUloeoGohwoNCNX88ZzsZinpZ3CZWxxb1al+07
	f1wl3j5y4trT7mOjGnUqwG6CWcMXRdR/UgN2MYzLQ9fwR/czbVRUSrTD2KMvFQPCoobJlo
	DzE6k9MbAzJTL8AIS8R9a79SCeVWWAY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-uonBjF0APGaMLS_uyMVaZg-1; Tue, 13 May 2025 05:18:17 -0400
X-MC-Unique: uonBjF0APGaMLS_uyMVaZg-1
X-Mimecast-MFC-AGG-ID: uonBjF0APGaMLS_uyMVaZg_1747127896
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so30559745e9.1
        for <linux-sh@vger.kernel.org>; Tue, 13 May 2025 02:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747127896; x=1747732696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQLwPqXkUI6z4QQX8G7LIPfd+304h8Dijb2vEngn3fA=;
        b=BZ712ttnXq/oFCljLu/dhKjNi5ExySSBt3AoHZ6viJMmR75Vx9RqUA4nfb6U9oB/UA
         o11djli2yKh39OcuYyY2eTsUDz9wRPiSnuVbWNa1vKk/IHM9Cm0/AyI0/vH24fk7DvzQ
         DoH7GnojEkpjpZmIHXqUlLl10tk6MVFzZspjJRZH4eUE7DBIjPbQaic6XhTStx+T+ZjA
         v0SkcmNRtdT+K8Jdx/XdMLMn+oMmff6WgDQFTb6c1LH6r+Wq3R4qKvzR6fVsAc9XUAkM
         ekx2FPro2pohEXT2d01Pr19asTRjFaAB+4YbGVlAi+l3MJz11+AE7jv1mXi/wm2hAqZ5
         00qg==
X-Forwarded-Encrypted: i=1; AJvYcCUeJXVxo3WK5qfLt7pO8D31TIAgxLbebuLjdl2Sl8FMQxQ0AU8H4uCG5j9bH9tMdynffw3EegymBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLQ25zmXvNKvIcP6yhORouJeMPzrllCKMEaBNbh4wWMbbA3DcW
	nFODzzEdb3DHXAq+KohB1aglWQ55WTXYgxVLGukKVC7pcj3oKvia4Az80gkBNbIcGmElZjFwH+f
	UsHtY4N6mJHUZSw3cVfW0khocfHbMncWdEQRybYVP065JXwdhhCbc0KA=
X-Gm-Gg: ASbGnct3ly2f4cAXGIfKjs/PRZRF4Q4qPhmRTARU3N5TEm4PhCwQk35LP/cd+sJuc3P
	br+ly3XRnuanl4nPD95rvKhQp8yk4DCtWz/AO8bQHYIVGK4fhle7XJWPqoyFXJVvIJXmJQpXBxS
	hhzxmkJ0NTAZ7Xl0iochOJHTQYZHycxRRo/I1jR0/fAAlCMArrfM7Bcrjju1CwjCb4mYPoCMFhE
	VEFyP19vjCKEOkflVCGfG/1K8pHtXnBvhYK2dIHBzT3Pd3ZP6mlEjXy0AAjTfy8fkLLidJ/lTBe
	4tMp5Dts/IFg0apLUC1Bf5qSocUR3Eau/96lJg5KEERI8MI=
X-Received: by 2002:a05:600c:3c8c:b0:43d:224:86b5 with SMTP id 5b1f17b1804b1-442d89ca4f8mr121131825e9.4.1747127896024;
        Tue, 13 May 2025 02:18:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgkQ6lr6jSThr2Cb3q6ZMQrTYHBuqnvQFthxFwxp9l7aEmx3rs55WDKKU2lMzSuNkJYBOxWQ==
X-Received: by 2002:a05:600c:3c8c:b0:43d:224:86b5 with SMTP id 5b1f17b1804b1-442d89ca4f8mr121130905e9.4.1747127895389;
        Tue, 13 May 2025 02:18:15 -0700 (PDT)
Received: from [127.0.0.2] (109-92-26-237.static.isp.telekom.rs. [109.92.26.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ed666dc7sm12345655e9.18.2025.05.13.02.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 02:18:14 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Tue, 13 May 2025 11:17:55 +0200
Subject: [PATCH v5 2/7] lsm: introduce new hooks for setting/getting inode
 fsxattr
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20250513-xattrat-syscall-v5-2-22bb9c6c767f@kernel.org>
References: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
In-Reply-To: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
 selinux@vger.kernel.org, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5418; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=YQGIdXvgchaWb1V6UiKUwEOK/o3C4y9T6tou+r20L0U=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMpT5vF3LC9luzDZOZnCaUM3c/WPNxAMdNf8KZT2O5
 y9vqDzGfKGjlIVBjItBVkyRZZ201tSkIqn8IwY18jBzWJlAhjBwcQrARMKmM/zhqWy5qqrd8PO1
 /vv/OiXxZr/F9nBPzWTMWJI18d+cxMJ8RoZXGf8r1h+awrr7cHvWqX9t5UWFz++c4rvw7aXBssS
 IVQJsAGi4SHY=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JjRMcPk1VVhhYwLvkRxMH2FceFTOeYeWkdFG9vGJTlw_1747127896
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Introduce new hooks for setting and getting filesystem extended
attributes on inode (FS_IOC_FSGETXATTR).

Cc: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/file_attr.c                | 19 ++++++++++++++++---
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      | 16 ++++++++++++++++
 security/security.c           | 30 ++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 2910b7047721df893540ff8a7c992558390eaa3a..be62d97cc444a445deac1c8ac8331f4a3766126a 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -76,10 +76,15 @@ EXPORT_SYMBOL(fileattr_fill_flags);
 int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
+	int error;
 
 	if (!inode->i_op->fileattr_get)
 		return -ENOIOCTLCMD;
 
+	error = security_inode_file_getattr(dentry, fa);
+	if (error)
+		return error;
+
 	return inode->i_op->fileattr_get(dentry, fa);
 }
 EXPORT_SYMBOL(vfs_fileattr_get);
@@ -242,12 +247,20 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 		} else {
 			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
 		}
+
 		err = fileattr_set_prepare(inode, &old_ma, fa);
-		if (!err)
-			err = inode->i_op->fileattr_set(idmap, dentry, fa);
+		if (err)
+			goto out;
+		err = security_inode_file_setattr(dentry, fa);
+		if (err)
+			goto out;
+		err = inode->i_op->fileattr_set(idmap, dentry, fa);
+		if (err)
+			goto out;
 	}
+
+out:
 	inode_unlock(inode);
-
 	return err;
 }
 EXPORT_SYMBOL(vfs_fileattr_set);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index bf3bbac4e02a59a67de4ace85b93b1a878131f60..9600a4350e791f47006720765c199e35d3abafd4 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -157,6 +157,8 @@ LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
 	 const char *name)
+LSM_HOOK(int, 0, inode_file_setattr, struct dentry *dentry, struct fileattr *fa)
+LSM_HOOK(int, 0, inode_file_getattr, struct dentry *dentry, struct fileattr *fa)
 LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_set_acl, struct dentry *dentry,
diff --git a/include/linux/security.h b/include/linux/security.h
index cc9b54d95d22cd11480c38148005ed778b7af1bd..d2da2f654345b36b20fbe68ce11468ca4a55d8b3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -451,6 +451,10 @@ int security_inode_listxattr(struct dentry *dentry);
 int security_inode_removexattr(struct mnt_idmap *idmap,
 			       struct dentry *dentry, const char *name);
 void security_inode_post_removexattr(struct dentry *dentry, const char *name);
+int security_inode_file_setattr(struct dentry *dentry,
+			      struct fileattr *fa);
+int security_inode_file_getattr(struct dentry *dentry,
+			      struct fileattr *fa);
 int security_inode_need_killpriv(struct dentry *dentry);
 int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
 int security_inode_getsecurity(struct mnt_idmap *idmap,
@@ -1053,6 +1057,18 @@ static inline void security_inode_post_removexattr(struct dentry *dentry,
 						   const char *name)
 { }
 
+static inline int security_inode_file_setattr(struct dentry *dentry,
+					      struct fileattr *fa)
+{
+	return 0;
+}
+
+static inline int security_inode_file_getattr(struct dentry *dentry,
+					      struct fileattr *fa)
+{
+	return 0;
+}
+
 static inline int security_inode_need_killpriv(struct dentry *dentry)
 {
 	return cap_inode_need_killpriv(dentry);
diff --git a/security/security.c b/security/security.c
index fb57e8fddd911bbb417ed2e7db443979bf611f43..09c891e6027dc1803a3af024b2f676e263da8aec 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2622,6 +2622,36 @@ void security_inode_post_removexattr(struct dentry *dentry, const char *name)
 	call_void_hook(inode_post_removexattr, dentry, name);
 }
 
+/**
+ * security_inode_file_setattr() - check if setting fsxattr is allowed
+ * @dentry: file to set filesystem extended attributes on
+ * @fa: extended attributes to set on the inode
+ *
+ * Called when file_setattr() syscall or FS_IOC_FSSETXATTR ioctl() is called on
+ * inode
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_inode_file_setattr(struct dentry *dentry, struct fileattr *fa)
+{
+	return call_int_hook(inode_file_setattr, dentry, fa);
+}
+
+/**
+ * security_inode_file_getattr() - check if retrieving fsxattr is allowed
+ * @dentry: file to retrieve filesystem extended attributes from
+ * @fa: extended attributes to get
+ *
+ * Called when file_getattr() syscall or FS_IOC_FSGETXATTR ioctl() is called on
+ * inode
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_inode_file_getattr(struct dentry *dentry, struct fileattr *fa)
+{
+	return call_int_hook(inode_file_getattr, dentry, fa);
+}
+
 /**
  * security_inode_need_killpriv() - Check if security_inode_killpriv() required
  * @dentry: associated dentry

-- 
2.47.2

