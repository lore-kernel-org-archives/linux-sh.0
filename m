Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61C81BD9C1
	for <linux-sh@vger.kernel.org>; Tue,  8 Apr 2025 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744119418; cv=fail; b=HMipBr1vfXrfsj5fwzSwwtCCGDBTSzX/uCGE2yXix11J1UXu9RH/siN7IK99sgmFzjZyEMeSTiDC6+PppyMey6hruRHj3Ygorux02rXQmtsoxD4/xOfFB3qUWxlHO1HAsFz/BWhf9p/nl5Of98H5/WYY9rB2voYe/E/+ErniQwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744119418; c=relaxed/simple;
	bh=Pd2p2s3KZsXPHZrC5HksxhyHnlqTc3DuWhINh9xPYOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGiswUq6r1/WirXzviBJPTgtO4MouvCW7o75Qpm7kn8Lc0CW2GZOgETabjBRM+HB1DVyMOWId9uboFZVZpzdP8byfIX2vUA9I1O6K3T4ainhXKh7ngwXxDML+pBcSU4PCHM9EMOjeLHdAJG9h6sTyhJNT/YM7sVXr4C2T4J04Rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=XnKg8iel; arc=fail smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="XnKg8iel"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2182F7833CE;
	Tue,  8 Apr 2025 12:59:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (100-99-49-173.trex-nlb.outbound.svc.cluster.local [100.99.49.173])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8E2017826D5;
	Tue,  8 Apr 2025 12:59:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744117171; a=rsa-sha256;
	cv=none;
	b=u/nQM8dnr/uI4vMaSDMFDypOjlBS+JoCn8zoEAl5aYCVOuwYwpsqqNPOxDpD3LEmm+/DYP
	LBM8pXXlEbt4e9K15lI59A70Y5yi2MN/dO6yTNR0aOIEbrhk/sI0V61/tV1HKeqcX0bdRy
	j1xkisr3hwhzoPPAFwz7NedMAfNlXOyEMklEilE4sZNbkJk0yVC9lgm0fV02RLT6mxUMV/
	3yGpaDGB9wvDvZ9MkjDoWAnyROg+iBtsm3aWY5BPNHtGsZoGczyQRp8Y56+wt2m7k5djst
	ASg+1fl7VJiKDEQdlNKTfVsDEhuON9qEWkMmsXbDyjmjFC+SGefdiPC/mvAbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744117171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RgMHLT5iaFY5Y5YpP6usWzNKmRfR2dPLLli4hBf6MKI=;
	b=GF5dHC9TOLefn/8aDp9ZPjgJ7I/yMlaKWYLbSNBWW7YZj/NV7mPP93lZ1KEw45/0wLymF2
	c9DVEkKvOnhyNFXEqaGTh3/Cftiqvg8BzxOOgk4ZwMyOlHZ1YZ5ObYGEZVP/SHHgWxPsKz
	dCIDxE/ACRHWImpHwZEI/KOxIk4AdTFIb/O/Huc+5bKu3FLqkoG3ZrCydFj1cSEnvuv6Bi
	HVfBO05RaDSYfUFmOxsjjc6GDQmKw6ZyWOrSZazPUxy8ON5qkECFcBuL9Qrngic/wXuiF+
	dmq5gwMbnCZ7MUZzmWk8i2VKEgHzxRqbxEwFCCOBcq4uuQNvuihJ5V4cO4IyPw==
ARC-Authentication-Results: i=1;
	rspamd-6c88b8f79f-pfxks;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Chemical-Wide-Eyed: 0aa28b4e5ae35a31_1744117171813_2162674698
X-MC-Loop-Signature: 1744117171813:618128258
X-MC-Ingress-Time: 1744117171812
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.49.173 (trex/7.0.3);
	Tue, 08 Apr 2025 12:59:31 +0000
Received: from [172.16.32.88] (unknown [198.232.126.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4ZX5kq13Cgz64;
	Tue,  8 Apr 2025 05:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1744117171;
	bh=zphxswrsItVhTF+1yhd204dpl4oL62e9HEnVc6q01dg=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=XnKg8ielMPIVpH/RI7hUa2WLaXDpTE03BuesEEzpBlY1MfFM4DuyXW9+mmlAgY0xU
	 E/cA8F9rzaAmt/6PKgqgBYX5OSoLj0kg30L/UjAaFMDc08RGuoasrO0IXfl9b9sAaW
	 Q1jAmTEMXNV1Ckzy6kqZ8ih7Cga6cltdvPvovTCknCZmHxLEE3aqEgwgZYOzbNS22r
	 WmbTbooXUDUEzZEkBSlVE6eTwCqkoklfA0od2DKAKWiu86P5TSal82vORHyFqBF8Xc
	 P5vQDW9pvnp7Lkx7AoF4x19gXRtMpbTEy2sWjoSJ+C3aQO10yFuDgid5SUdI1Kqcjz
	 oStY8F0lQvOwg==
Message-ID: <3699fd5c-a856-4f9f-a4c6-edc9f76e6cf8@landley.net>
Date: Tue, 8 Apr 2025 07:59:30 -0500
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Did I ever post my sh fdpic-on-mmu patch here?
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
References: <11c0bf9e-0918-4739-8245-41a8bfa2bf1a@landley.net>
 <034795475781c8ccd10b553ebe8517eaf1f01bbc.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <034795475781c8ccd10b553ebe8517eaf1f01bbc.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/25 15:22, John Paul Adrian Glaubitz wrote:
> Hi Rob,
> 
> On Tue, 2025-04-01 at 11:21 -0500, Rob Landley wrote:
>> I've been using
>> https://landley.net/bin/mkroot/0.8.11/linux-patches/0002-sh4-fdpic.patch
>> to test my sh2eb fdpic nommu userspace under vanilla qemu-system-sh4eb
>> with an sh4eb mmu kernel for a year now (since
>> https://landley.net/notes-2024.html#28-03-2024) but don't remember if I
>> ever sent it here?
...
> Could you post the patch with git-send-email so that it's inline and can be
> reviewed on the list?

Dreamhost's outgoing smtp server requires ssl and a login, so probably 
not easily? But let's see...

$ man git-send-email
No manual entry for git-send-email
$ git help send-email
No manual entry for gitsend-email
$ git send-email
git: 'send-email' is not a git command. See 'git --help'.
$ git-send-email
bash: git-send-email: command not found

Oh good grief, here:

From: Rob Landley <rob@landley.net>

Allow CONFIG_BINFMT_ELF_FDPIC loader to build on sh4 with mmu, same as arm.

--

  arch/sh/kernel/setup.c |   25 +++++++++++++++++++++++++
  fs/Kconfig.binfmt      |    2 +-
  2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index d3175f09b3aa..effda8b21370 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -404,3 +404,28 @@ void __init arch_cpu_finalize_init(void)
  #endif
  	*p = '\0';
  }
+
+#if defined(CONFIG_MMU) && defined(CONFIG_BINFMT_ELF_FDPIC)
+
+#include <linux/personality.h>
+#include <linux/elf-fdpic.h>
+
+void elf_fdpic_arch_lay_out_mm(struct elf_fdpic_params *exec_params,
+                               struct elf_fdpic_params *interp_params,
+                               unsigned long *start_stack,
+                               unsigned long *start_brk)
+{
+	set_personality((current->personality & ~PER_MASK) | PER_LINUX);
+
+        exec_params->load_addr = 0x8000;
+        interp_params->load_addr = ELF_ET_DYN_BASE;
+        *start_stack = TASK_SIZE - SZ_16M;
+
+        if ((exec_params->flags & ELF_FDPIC_FLAG_ARRANGEMENT) == 
ELF_FDPIC_FLAG_INDEPENDENT) {
+                exec_params->flags &= ~ELF_FDPIC_FLAG_ARRANGEMENT;
+                exec_params->flags |= ELF_FDPIC_FLAG_CONSTDISP;
+        }
+}
+
+#endif
+
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index f5693164ca9a..ba8c5fc81da4 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
  config BINFMT_ELF_FDPIC
  	bool "Kernel support for FDPIC ELF binaries"
  	default y if !BINFMT_ELF
-	depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
+	depends on ARM || SUPERH || ((M68K || RISCV || XTENSA) && !MMU)
  	select ELFCORE
  	help
  	  ELF FDPIC binaries are based on ELF, but allow the individual load

> This makes it easier for review and pick up with the
> b4 utility

https://landley.net/notes-2024.html#09-04-2024

> and it's easily accessible though patchwork.

The above is "xclip -sel c < file.patch" which I then pasted "as 
quotation" into thunderbird and hit delete twice at the start of each 
line to take the "> " off but it's still in the magic "blue text because 
quotation" state that _should_ prevent line wrapping? (It does for the 
UI, I _think_ that carries through to sending? No of course disabling 
HTML email doesn't stop the compose window from maintaining unwanted 
markup...)

If that doesn't work, I have to track down a version of the no-wordwrap 
plugin that works with current thunderbird. (The one I was using went 
away in plugin api version skew du jour during the distro upgrade that 
might let me back onto the python version treadmill b4 enforces.)

> Thanks,
> Adrian

Rob
