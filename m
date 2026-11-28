Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795843536;
	b=SLsGmyqShwH5q3OIQVoocpsX3uCih7KmRiv9pfPBd7zWVeHXJuUU+Npv8JrPkV5ZvCv7
	 FDDvMENpSJa8G6GroAWS2cCc/BwBFmFesQPQ0Ss9ZsIL4xQoTczBSautSzrniqppemQas
	 sc6SU1uU//d1ftPUMOfO10SenyOfHSF0OM769ISFeIxULfPRQqdmd5nbgR7XQuobM9HsS
	 gKjpz7uGwu8dSEtU9f5zjbnktFoiQxPyqCXMn09ULoPd5LVSORSTAaMx+uTla9qTQjwWQ
	 2Pl/WUbbbPTesBtF7ISwcEHJ2pg2rr43VDS4MlGp5l0U9RFOfHifHwAyRQLSqB5WH9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795843536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LTT+F+8eGiTtnoaAOJgxFuyeZr+Zc/qtavdsCFWjKow=;
	b=seWARl8DlUfOE2EBGgPO8tQNrPPQ67TKYFS9hYUYrNDsEFOVwc2ub9o4lcf2ODpgXY6N
	 sWo74rRHBoEJTBmqWFYi3qMjJo1e/uyTgSTwfDr2IQX3cUsl3otqP4N+IB32auqSwLan+
	 +rpInkkvmnhd+YqwtH2Zz5GBfi9/wKvi4/+rm7jFD5sU2Y6Fa7qd2mRwlubjKcxWXTCfd
	 6wpJw8EpglCWejCfCRCHgUXhVf0TCKLguvmCG0WlB2IBA0Kss8g2bcKHRacOD20alNaJI
	 Rrg/nfIjunRYmz+MtLHCUZUPYBGst/vn2OHCHknUauDOEy2WCu7dH3yqhMpljTSpJJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Csn9C31G;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ECA606A31E
	for <linux-sh@vger.kernel.org>; Sat, 28 Nov 2026 05:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4ECA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Csn9C31G
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2f04f61282dso40177385ad.1
        for <linux-sh@vger.kernel.org>; Fri, 27 Nov 2026 21:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795843535; x=1796448335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LTT+F+8eGiTtnoaAOJgxFuyeZr+Zc/qtavdsCFWjKow=;
        b=Csn9C31GyefqXel/Pu5z7paIM0NjtCsN7IkQsZaara9c3GJxBkOjTTE6NohGcPrLF4
         aEb2Bv/K2Yjcq8hsbs8asvyDOMpw502zL6Wsxz/fJG75C7Ee9DZltsEjH8UFirlqj3MD
         qjuAUvi+0461Bj5SJ83MJgYW26ekT4bH0r1aHxpdEXhRGqMrd2EMDsM4l/aENi/PbYgJ
         0RJbYZqkC/3tFkVgkl915v5lHQ2Cf9Zgfzwt/AF/xk30122foTBa/ACtRpEyGGjkUoFf
         +Zy5Ksjeu/0QdnLyhlj3Rk73Tg+FbrB7XNO5L7OvqbNfjPOvQ6MC9w0OZdyXCxryUABF
         0Mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795843535; x=1796448335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LTT+F+8eGiTtnoaAOJgxFuyeZr+Zc/qtavdsCFWjKow=;
        b=bSE8skYN07yvX2PyStjz7jkaTypKkpH1hirLXy6qVvkC5kaiIyaCpoNu203YCsxNIE
         JKPOj6JPvKQWPSD4FfRAtGXqnExkqer5QeOL4aJWCHv3zGXYfvet7/Ohb/vxXJxAwx2h
         dJmtNTR1C+hQy9bnZoO3GOBnMkSaJ+96ndiK/0BM8p95NX9X/kthwQNuz41K/jweKqFz
         HL+kBcIiBicCWEa8nDGNDureDHTtPrVLdrN3OFp9pT9JyenNeD4AaUgG2s2m17u4q/3a
         f+GQ76Q+fwjCNMrbbTFm3oGmTF1NY//XyBxcA0/PtdiIxndFd+uWbMEKKLNXLp6MZAiZ
         bJYg==
X-Forwarded-Encrypted: i=1; AL+hErHs9ythZwtoT82JQ9L+b9NC8FYpJThTNhEb30A7BmVm/75TYHRxuKu+FSFvIXVeVtsIXhVs/sB7mQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+uv9CWsNpZqMTbpnXRPROiRwgRBrSiOHtvPW6u9I/4Fk8Dwm1P
	lzbFEIn2BNL3cGl4FKCnnYtOwp2eBqnKfEf55YjXeFpdlDktVtAHFt32
X-Gm-Gg: AZFdTZd+7ZEwf7R36hvBH8I4Tv8lDSZkYTJQHokf7P52lwM20n1MYq45+dN3SF/CruQ
	pN53BuvBV5V0MC/t5X0bSKcj5htNfeYe9I4gBkbCSOIWN0DKY0wJRywvie62H48ik7ZwQc9fYBH
	mV8B6f4/1umcF1g52EghzMzEvP+1qtxFHfLF3xHGaeienvnSuGMSsowACQejPAhlIZSJ7QUG2/a
	9G6+7XvQCib4n6nVu4Y/Y6AjJxZMgtjtR+Vy+BnCAHgEqm6nUGzqGqjOq5tBAlvvEC9dxbFQ3Ju
	tJnVFxbz1+OeYxqvp1tAYAX6wlF73MGPaRptJvfVATqO3RL1KZE//KhFd4oPw22eUrZTfXp7tK3
	Tl8ZD1DIcXqXPmSvTlXlfYCBz7egrSUT7fMAEI//JmWaIGNgILXRG6hcxHTm/kYbI2Wbl5JdyPC
	p8v2FC9ao0KYz5Jb+HRd3/TpswOnxsCwS0bEukZu1YJR6c0y/PYiX5+TqnNDRox34NTSKXB+gh9
	4yArRKxJ6jHYniNwEq6F9NjklYwXlP5fhgQcBkzNacl3k6AoywHsJVNLfr1/kBci2OuX9jmIE/v
	nouz9SzvEiC4PelRZwsxgo30+H/4bcB3RZVJEkyqmCGv/nzYgg==
X-Received: by 2002:a17:90b:1802:b0:3b0:9f53:e8a8 with SMTP id 98e67ed59e1d1-3b41c959dfbmr26204669a91.52.1795843534930;
        Fri, 27 Nov 2026 21:25:34 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b5210be133sm9958967a91.11.2026.11.27.21.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 21:25:34 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	terrelln@fb.com,
	dsterba@suse.com
Cc: geert+renesas@glider.be,
	ljs@kernel.org,
	n.schier@fritz.com,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [RFC PATCH] sh: boot: add Zstandard compressed kernel support
Date: Fri, 27 Nov 2026 23:25:30 -0600
Message-ID: <20261128052530.456111-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for booting Zstandard compressed kernels on SuperH.

Select HAVE_KERNEL_ZSTD and add the required image generation rules
for Zstandard compressed kernel images.

Include the Zstandard decompressor in the compressed kernel and
provide the architecture helper routines required by it,
including the SH implementations of the division, memory movement,
and leading/trailing zero count helpers.

Tested on:

- SH4 R2D: successful Zstandard kernel boot under QEMU.

- SH4: successful builds with and without
  CONFIG_CC_OPTIMIZE_FOR_SIZE.

- SH3 EDOSK7705: successful Zstandard kernel build.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 arch/sh/Kconfig                   |  1 +
 arch/sh/boot/Makefile             | 12 ++++++++++--
 arch/sh/boot/compressed/Makefile  | 26 +++++++++++++++++++++++++-
 arch/sh/boot/compressed/clz_ctz.c |  3 +++
 arch/sh/boot/compressed/misc.c    |  3 +++
 5 files changed, 42 insertions(+), 3 deletions(-)
 create mode 100644 arch/sh/boot/compressed/clz_ctz.c

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index aa579aa041b5..d3919834a6dd 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -49,6 +49,7 @@ config SUPERH
 	select HAVE_KERNEL_LZMA
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
+	select HAVE_KERNEL_ZSTD
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_MIXED_BREAKPOINTS_REGS
diff --git a/arch/sh/boot/Makefile b/arch/sh/boot/Makefile
index cf63e319b786..49f32431a7e3 100644
--- a/arch/sh/boot/Makefile
+++ b/arch/sh/boot/Makefile
@@ -25,11 +25,13 @@ suffix_$(CONFIG_KERNEL_BZIP2)	:= bz2
 suffix_$(CONFIG_KERNEL_LZMA)	:= lzma
 suffix_$(CONFIG_KERNEL_XZ)	:= xz
 suffix_$(CONFIG_KERNEL_LZO)	:= lzo
+suffix_$(CONFIG_KERNEL_ZSTD)	:= zst
 
 targets := zImage vmlinux.srec romImage uImage uImage.srec uImage.gz \
-	   uImage.bz2 uImage.lzma uImage.xz uImage.lzo uImage.bin \
+	   uImage.bz2 uImage.lzma uImage.xz uImage.lzo uImage.zst \
+	   uImage.bin \
 	   vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
-	   vmlinux.bin.xz vmlinux.bin.lzo
+	   vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.zst
 subdir- := compressed romimage
 
 $(obj)/zImage: $(obj)/compressed/vmlinux FORCE
@@ -80,6 +82,9 @@ $(obj)/vmlinux.bin.xz: $(obj)/vmlinux.bin FORCE
 $(obj)/vmlinux.bin.lzo: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,lzo)
 
+$(obj)/vmlinux.bin.zst: $(obj)/vmlinux.bin FORCE
+	$(call if_changed,zstd22)
+
 $(obj)/uImage.bz2: $(obj)/vmlinux.bin.bz2 FORCE
 	$(call if_changed,uimage,bzip2)
 
@@ -95,6 +100,9 @@ $(obj)/uImage.xz: $(obj)/vmlinux.bin.xz FORCE
 $(obj)/uImage.lzo: $(obj)/vmlinux.bin.lzo FORCE
 	$(call if_changed,uimage,lzo)
 
+$(obj)/uImage.zst: $(obj)/vmlinux.bin.zst FORCE
+	$(call if_changed,uimage,zstd)
+
 $(obj)/uImage.bin: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,uimage,none)
 
diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index b85aa5f0d616..f06c0293c3ee 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -8,8 +8,18 @@
 OBJECTS := head_32.o misc.o piggy.o \
            ashiftrt.o ashldi3.o ashrsi3.o ashlsi3.o lshrsi3.o
 
+zstd-udivsi3-y := udivsi3_i4i-Os.o
+ifneq ($(CONFIG_CC_OPTIMIZE_FOR_SIZE),y)
+zstd-udivsi3-$(CONFIG_CPU_SH3) := udivsi3_i4i.o
+zstd-udivsi3-$(CONFIG_CPU_SH4) := udivsi3_i4i.o
+endif
+
+OBJECTS-$(CONFIG_KERNEL_ZSTD) += clz_ctz.o memmove.o movmem.o $(zstd-udivsi3-y)
+OBJECTS += $(OBJECTS-y)
+
 targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 \
-           vmlinux.bin.lzma vmlinux.bin.xz vmlinux.bin.lzo $(OBJECTS)
+           vmlinux.bin.lzma vmlinux.bin.xz vmlinux.bin.lzo \
+           vmlinux.bin.zst $(OBJECTS)
 
 #
 # IMAGE_OFFSET is the load offset of the compression loader
@@ -32,6 +42,18 @@ LDFLAGS_vmlinux := --oformat $(ld_bfd) -Ttext $(IMAGE_OFFSET) -e startup \
 
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 
+$(obj)/memmove.o: $(srctree)/arch/sh/lib/memmove.S FORCE
+	$(call if_changed_dep,as_o_S)
+
+$(obj)/movmem.o: $(srctree)/arch/sh/lib/movmem.S FORCE
+	$(call if_changed_dep,as_o_S)
+
+$(obj)/udivsi3_i4i.o: $(srctree)/arch/sh/lib/udivsi3_i4i.S FORCE
+	$(call if_changed_dep,as_o_S)
+
+$(obj)/udivsi3_i4i-Os.o: $(srctree)/arch/sh/lib/udivsi3_i4i-Os.S FORCE
+	$(call if_changed_dep,as_o_S)
+
 $(obj)/vmlinux: $(addprefix $(obj)/, $(OBJECTS)) FORCE
 	$(call if_changed,ld)
 
@@ -48,6 +70,8 @@ $(obj)/vmlinux.bin.xz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,xzkern_with_size)
 $(obj)/vmlinux.bin.lzo: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,lzo_with_size)
+$(obj)/vmlinux.bin.zst: $(obj)/vmlinux.bin FORCE
+	$(call if_changed,zstd22_with_size)
 
 OBJCOPYFLAGS += -R .empty_zero_page
 
diff --git a/arch/sh/boot/compressed/clz_ctz.c b/arch/sh/boot/compressed/clz_ctz.c
new file mode 100644
index 000000000000..81a708c6808b
--- /dev/null
+++ b/arch/sh/boot/compressed/clz_ctz.c
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "../../../../lib/clz_ctz.c"
diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/misc.c
index 3690379cc86b..3739e5dd6250 100644
--- a/arch/sh/boot/compressed/misc.c
+++ b/arch/sh/boot/compressed/misc.c
@@ -66,6 +66,9 @@ static unsigned long free_mem_end_ptr;
 #ifdef CONFIG_KERNEL_LZO
 #include "../../../../lib/decompress_unlzo.c"
 #endif
+#ifdef CONFIG_KERNEL_ZSTD
+#include "../../../../lib/decompress_unzstd.c"
+#endif
 
 int puts(const char *s)
 {
-- 
2.56.1

