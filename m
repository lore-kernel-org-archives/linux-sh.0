Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=89.238.66.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792574753;
	b=fSNj48WX6yKsxCgxJa+z5+h0zYN5IO6FmX8mmF196ZsRaZygOh4SoTe4HMTBzs9jvKTO
	 sJp8k8/+V5Vm4CosS49tXeWVj4VGCrb18YRRPxIgfchqhW1Q01ytC7eM8TvaMBNaY4f91
	 5xba51MYpapxDpat7Vs0DVr4CeDvTLsXiSJNc0imt50tbTtCp4Ta+Pp0aSPtShkXQ/Krg
	 2QYSBpKRLr36v5yKYwvPL3uyj17LIOmACuyoXsaGDrxloWKATDeBna2pp6NJ4j93LFOxC
	 FV1OgZHqNv9sFgC68KATnz709RW5GQZs9LulNlgfbHz0883IMVmLaZVT3+HvVjn1/rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574753;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Operating-System;
	bh=+rep9d66C/mGsEatTJCEJwuYm6zzw0jQ+ipRBaQL3Og=;
	b=keS4j2A5JXVIr8akrCEoJrWkn9WzKLQJqxs2s4XnScw9hZlHmegHGUekV0u9omqnrpHM
	 bY4nd6g2JbsFrgcAVaCXkQL6r2QUTp8S+7Z/puUBmXQZA38Z3LsC80L+DpgOv1R77xb3A
	 HkpO649up52LbJqfDNEgw+nXJKLI7Xgc062y+Fp1cOsVBLFBJLQfb/enF4P9kmBxD/F7B
	 NGnarU+NUSMvlGSMB37kFOWo+4DDKdyECxbKrubCGUdel3CNCe60im540WV6untRHz+Gd
	 ZIWjJW6VFAQPUt6eCQB4fiInyx5Rhr1e3lP6oGmhw68xC37NzRBiVMeozUO03p4d7+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=openadk.org;
	spf=pass smtp.mailfrom=openadk.org;
	arc=none smtp.remote-ip=89.238.66.15
Received: from helium.openadk.org (helium.openadk.org [89.238.66.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61BB606A319
	for <linux-sh@vger.kernel.org>; Wed, 21 Oct 2026 09:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C61BB606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openadk.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openadk.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=openadk.org; s=2022;
	t=1792574739; bh=0puvwPqd4VzhvOiIvuseyY7F1SoiBbx800htMa9Um+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a7z7kwgzW/bLcFwJ40l+/MPmgOGyzzSO86O6eURuZaPX9TcIVHs29SgxLY94aOUEa
	 OU4reADjmE1c03HCx6bdJjPp6AJmdzcAfjV+1O4pBxYLfR7TEqor9tSsFzYEx9LtvT
	 JtZFC2wdrOEDDhPsJaLebYRvJy+JMGIqbPq6/lXLLjplbnIZQOQfD2bdsDsqQyoP4Q
	 78Lh8LRybPmkuUDm7GQGZaXxJhxXQgrTDhsAQ0TZrQkyWfsktyKk1eoD3n7p5NfJmD
	 YjRKcaBmJxmBTh7T0serzNo30nwLSL0IU0GZJ/yLG1bAlP4Y4jL92Y4fYemWtFz+bi
	 S3xXGupghviyQ==
Received: by helium.openadk.org (Postfix, from userid 1000)
	id E99FA31E0AF3; Wed, 21 Oct 2026 11:25:39 +0200 (CEST)
Date: Wed, 21 Oct 2026 11:25:39 +0200
From: Waldemar Brodkorb <wbx@openadk.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Waldemar Brodkorb <wbx@openadk.org>, linux-sh@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v2] sh: select BINFMT_FLAT_NO_DATA_START_OFFSET for noMMU
Message-ID: <atiFE4oreXlgTzQz@waldemar-brodkorb.de>
References: <atgBKmRydeRteQ0T@waldemar-brodkorb.de>
 <843827c5eb85807d4f55a0d8a4cd572811ee3644.camel@physik.fu-berlin.de>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <843827c5eb85807d4f55a0d8a4cd572811ee3644.camel@physik.fu-berlin.de>
X-Operating-System: Linux 6.12.107+deb13-amd64 x86_64

Hi Adrian,
John Paul Adrian Glaubitz wrote,

> Hi Waldemar,
> 
> On Wed, 2026-10-21 at 02:02 +0200, Waldemar Brodkorb wrote:
> > binfmt_flat offsets the in-memory start of the data segment by
> > MAX_SHARED_LIBS words and then aligns it to FLAT_DATA_ALIGN, so FLAT_FLAG_RAM
> > binaries end up with a gap between text and data (commit 2217b9826246
> > ("binfmt_flat: revert "binfmt_flat: don't offset the data start"")).
> > 
> > SH position-independent code finds the GOT with a PC-relative mova of
> > _GLOBAL_OFFSET_TABLE_, which assumes data follows text directly, as elf2flt
> > lays out the image. With the gap, the GOT register points below the real GOT,
> > so every GOT load reads the neighbouring slot and gets a wrong pointer. On a
> > J2 (sh2eb, noMMU) this made userland crash or hang right after start-up.
> > In my case the data was moved up by 0x20 bytes.
> > 
> > Commit 04d82a6d0881 ("binfmt_flat: allow not offsetting data start") added
> > CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET for architectures that cannot
> > tolerate such a gap; currently only riscv noMMU selects it. Select it on SH
> > as well when building without an MMU.
> > 
> > Tested on a J2 board (Numato Mimas V2, sh2eb, noMMU) with Linux 7.3 and
> > FLAT binaries built with elf2flt: with this change the data segment starts
> > exactly at the end of text and init runs.
> > 
> > Without the patch bootup fails with:
> > [   12.080472] Fixing up unaligned userspace access in "init" pid=1 pc=0x(ptrval) ins=0x6583
> > [   12.123609] Fixing up unaligned userspace access in "init" pid=1 pc=0x(ptrval) ins=0x6583
> > [   12.175153] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
> > 
> > Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
> > Assisted-by: LLM
> > Fixes: 2217b9826246 ("binfmt_flat: revert "binfmt_flat: don't offset the data start"")
> > 
> > ---
> > v1->v2:
> >   - add fixes tag (Geert)
> >   - tested with 7.3 + Florian's uaccess patch (Geert)
> >   - added failing bootup messages to commit message
> > ---
> >  arch/sh/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> > index d60f1d5a94c0..b501153551c0 100644
> > --- a/arch/sh/Kconfig
> > +++ b/arch/sh/Kconfig
> > @@ -15,6 +15,7 @@ config SUPERH
> >  	select ARCH_MIGHT_HAVE_PC_PARPORT
> >  	select ARCH_WANT_IPC_PARSE_VERSION
> >  	select ARCH_NEED_CMPXCHG_1_EMU
> > +	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
> >  	select CPU_NO_EFFICIENT_FFS
> >  	select DMA_DECLARE_COHERENT
> >  	select GENERIC_ATOMIC64
> 
> I have not tested this yet but I will do so later this week. Personally, I
> test my kernel images on J2 with ToyBox which builds a minimal rootfs with
> busybox.
> 
> I am not sure if the binaries are flat binaries in this case, do you know?

They are not. Toybox uses musl C library, which is FDPIC.
I use OpenADK (https://openadk.org) to build a J2 image with
uClibc-ng and FLAT binaries. You could either try OpenADK or just
believe me :).
For OpenADK you need to choose experimental support and uClibc-ng
git version, as there was another bug in uClibc-ng to let it work.

best regards
 Waldemar
