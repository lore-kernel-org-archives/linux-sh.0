Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69495BA34
	for <linux-sh@vger.kernel.org>; Sat, 13 Sep 2025 00:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724791; cv=none; b=SgnMzdmO1arbXeBR9/oQRxIZeArvHNeLLXuxGLHU9MicCykc/voQzDxQiw9IoL/tCCYJFXWMq7dGiDtVki3QNo667MIgzrqKVwc6pYA+3p5o9ziXPuPS1IGu7bWlHK9mNiVe7n8tgjA3FmQoVnM/P0qAvUSCcMq1UUMAsfZFsGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724791; c=relaxed/simple;
	bh=x5NNVyIF1R5eB/2ANpkfxinDkMZ4lHIXMUphyEE4B54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVRCXqOHpBg+iByV186XsInRkBffnr9F8nygm7G1loS/S58PthphnTwvhZ4MBHpT2sFogfdq8PJDZlhEkNWTToPeKIOoNwDsrXvSvMPQVYPcf+d+qHO/OXJT0WESTZrHnEZH3CsWPcMuZ9XfRg6crbdxrdoL/BaUnpMD2tGJPvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGKxaKJJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGKxaKJJ"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62ee43b5e5bso2137852a12.1
        for <linux-sh@vger.kernel.org>; Fri, 12 Sep 2025 17:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724788; x=1758329588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPSAK5Fj4YQSUyCSJit30V41XYzOMHEP2qtV3SbNp88=;
        b=KGKxaKJJAEmQb6XUp3nRwdDCCxc+u+hiDne6Z/NPf1uixihci6LE3WqQK66IqjXdY4
         Xb/SIK40YfVhek6ziJiApcg4teUqoYD+EUABCY4ZDilpIOpcxVeVt4xnP8Y3hMV830Jd
         BgRCzsXLuAt/64gYNvjWjTt0faQGDNZq5VES2V7LFxosLo+CyBxCqy0cFlgLTUfnd41y
         g5A5xGHGNE2ZrRJQWf4a4OG0sSfOVWqShG7OAgFkdiIQMVcQX7NExVIHdtllyNXyAyPe
         SXalYa6zfu1Jnx/pFPicmNaDPB3e4ynKFhUSu4lO0eWu8UaD73J3NMjlvmNcETXjIJLv
         jaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724788; x=1758329588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPSAK5Fj4YQSUyCSJit30V41XYzOMHEP2qtV3SbNp88=;
        b=Q8n+AqEYiRRrewr8ZIbxVcjybdIyoeHzcUJYkag5uW16LCe5x0pYOWKEDZBmvjJ/wA
         /nbBwjloruKcaHHNj9mknYFR3bIpnxIxmJI9NmxL+E2UJ6HUzZvJMoH0hdo6iamxNcDd
         YpPP7spgPL5xxJj+ot6AHJgTLG0/7kLqZ0Zamhkj476utMFqf7yl9F+jmbIzKcvSvs7z
         boo5yfnkPRRyucRlRqqhrq3TE4c3sQuOu9kboKP0UydmZdI3xq9zCQ7wMPiqlDLRwGrj
         U/ZlIqh4SZH/yKqrGTLlPpUSKnYF9aVbWrldiX26dagN2gk4MrtphaZ0a/2X6mimt4aX
         RLXw==
X-Forwarded-Encrypted: i=1; AJvYcCUyiv0FYyaXzPW0iuhXuH18f2D0B3hO4payhmw3MVc0yJC1ZNIjKKZ9HSJv4GzOR68Pcv37x+o1Vg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yytf8tgOtMaIB0klh+GH61KyNL3faGuPq8Y6HpeafFAjnPS7OJ2
	kyLVFK4PJu+hsS4vR3kFaDdCwKiSMfXfAcnP6Ug7GYT/MGMPwwbJMq5s
X-Gm-Gg: ASbGncuwHZ9VKqgQY15clvLus2AH5TCzGnmZX4nEX2cVFVj4Ejq5RvktAxvdL3BMTZE
	MET4HKPJa7Z6fVJEMwE8S1kuvaI4qDjdaCpqC0YuxlZ3yWHFB3qAIfrZZFPGMzZHOmKa8hU6TD7
	P3jAySAt2h/AMg/GhKrFt2Nnt2BOYzBP0zz/uZ5Qqwcj1TQmHGtGbNN8N2CJbb8Yo99H7e/eump
	UHUDKyK9K5bW9d1jcIbSh9p/z+rHSs/UMZeE5K93OpQJptWbwDXjEeshZ/39HrEzRQlzd4Tz5lv
	IEPhUamgoMAvhrBlrBAzEKUauO+uA3gUdDhKNOsvUQHtc2xCv0mtHBigYgiqu92XLVeul+S2aGm
	afInKAV76rnsIW0awexzPIXfZii6SHQ==
X-Google-Smtp-Source: AGHT+IFLH7pCvIgBYHEI5BCYMw7iR++gatKVbesXKTxSAgJfhChwCe/V59YIUp3mRnJ55soXUGFMnw==
X-Received: by 2002:a17:907:da4:b0:b04:2cc2:e49c with SMTP id a640c23a62f3a-b07c35bbcbbmr535243766b.19.1757724787764;
        Fri, 12 Sep 2025 17:53:07 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32f22e8sm477916866b.87.2025.09.12.17.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:53:07 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 12/62] init: remove /proc/sys/kernel/real-root-dev
Date: Sat, 13 Sep 2025 00:37:51 +0000
Message-ID: <20250913003842.41944-13-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was used for initrd support, which was removed in previous
commits

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |  6 ------
 include/uapi/linux/sysctl.h                 |  1 -
 init/do_mounts_initrd.c                     | 20 --------------------
 3 files changed, 27 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 8b49eab937d0..cc958c228bc2 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1215,12 +1215,6 @@ that support this feature.
 ==  ===========================================================================
 
 
-real-root-dev
-=============
-
-See Documentation/admin-guide/initrd.rst.
-
-
 reboot-cmd (SPARC only)
 =======================
 
diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index 63d1464cb71c..1c7fe0f4dca4 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -92,7 +92,6 @@ enum
 	KERN_DOMAINNAME=8,	/* string: domainname */
 
 	KERN_PANIC=15,		/* int: panic timeout */
-	KERN_REALROOTDEV=16,	/* real root device to mount after initrd */
 
 	KERN_SPARC_REBOOT=21,	/* reboot command on Sparc */
 	KERN_CTLALTDEL=22,	/* int: allow ctl-alt-del to reboot */
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index bec1c5d684a3..d5264e9a52e0 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -14,30 +14,10 @@
 
 unsigned long initrd_start, initrd_end;
 int initrd_below_start_ok;
-static unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
 
 phys_addr_t phys_initrd_start __initdata;
 unsigned long phys_initrd_size __initdata;
 
-#ifdef CONFIG_SYSCTL
-static const struct ctl_table kern_do_mounts_initrd_table[] = {
-	{
-		.procname       = "real-root-dev",
-		.data           = &real_root_dev,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
-	},
-};
-
-static __init int kernel_do_mounts_initrd_sysctls_init(void)
-{
-	register_sysctl_init("kernel", kern_do_mounts_initrd_table);
-	return 0;
-}
-late_initcall(kernel_do_mounts_initrd_sysctls_init);
-#endif /* CONFIG_SYSCTL */
-
 static int __init early_initrdmem(char *p)
 {
 	phys_addr_t start;
-- 
2.47.2

