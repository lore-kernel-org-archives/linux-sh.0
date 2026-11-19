Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074100;
	b=zg0d/nfLkHf0pN2Gs2H6NjHXwEgFAG33594vuCXz0zvXRDIi1WVBl7IJsIr+F8Rg2Ydq
	 HLZWy0RMBPTa9Zp/V6dmPzyrDTP6veyBxjA1F+ejoXa7hfPbMvN1fWBcTX3LtEZaZtgGd
	 PgfYAlr4zWMazsl1Y77rRi/yIzmUD0eJj6ZD2ryAygz4vTbF/9hQwGHiYnrrGwDGe84Vd
	 CIH559jo3kglrcNvQH4mIt4srEV0Itlezhap82VPCBlumxzmSa8XGTM8MUTIIV1VyRp95
	 PVWeuNy/1n/CYsyjXeEPe9MC4cHrNK/woMIlRnsWhlXrmH7GGg9qDz3DmijRjTjvkWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074100;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hNd5MCBb+RwQDRLrwFjdA5miwBKz7JlHYmdVmb0QLqo=;
	b=hS5Mxrvn2SazNvI4C+Kf4UpuUMHEwIo86BVgCoAuhy9ke3FcGvAUNPsmRFM6PW7gqmZp
	 tjeel6y4cBPJ2TBWJCm/BmFXEzz/L9QD4jiTuCNkW264GXafPKJgu6LU2LrH3Kc5OLTf8
	 VRGY7S0Z4B7sYs+oVf47p4R7Bk5cQLVW8QZmCTdH8S0BxN3rzGn2UK0/d91+o3jrjaohs
	 4hpvqMqUyrTlIgQZbJo17MKY6eIFEc0iqyfCY7DO7z+phrwGCjU+flc1vIJ9lh9A3XFkJ
	 QKwD7iyEd7PkWip9IXJKqmy19EyMQb63yLGaGmj1fo7rro41oFKULDrGbQQsIbnihGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.108
Received: from mta1.migadu.com (out-108.mta1.migadu.com [95.215.58.108])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97BC606A32A
	for <linux-sh@vger.kernel.org>; Thu, 19 Nov 2026 07:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B97BC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-sh@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6tO+X4PnRnD+Jk0uYi9e+cJ5+jxuZiQPrphEOsBPyUs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795074090; v=1; x=1795678890;
 b=jRpAWJeDfhzRjp0tMgYsPxG27OVP/tOWcJ/LQhjQ73YyguUVzBJIk9e6igo5ThSrN/dX9FMW
 bZra7IUn8I/rAqXJ0NlITYqlsau1cJMj9jUX1QQPXNjf97NVYMKnp1K1+v+f+gbq9xnGbaFV9/k
 QXdNQC1HwUPojy675ONU9hn0=
X-Envelope-To: linux-sh@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id f0d3d04c8dc3375f;
	Thu, 19 Nov 2026 07:41:30 +0000
X-Mizu-Trace-ID: f0d3d04c8dc3375f
X-Migadu-Flow: FLOW_OUT
Date: Thu, 19 Nov 2026 15:41:24 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Paul Walmsley <pjw@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, Rich Felker <dalias@libc.org>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Cong Wang <cwang@multikernel.io>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	WANG Xuerui <kernel@xen0n.name>, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev
Subject: Re: [PATCH 1/2] MAINTAINERS: add kernel/Kconfig.kexec to KEXEC
Message-ID: <av6oJBDv2fAaWSog@fedora>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
 <20261119-arch-kconfig-v1-1-37c276fe4d26@kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-arch-kconfig-v1-1-37c276fe4d26@kernel.org>

On 11/19/26 at 08:16am, Mike Rapoport (Microsoft) wrote:
> kernel/Kconfig.kexec is not matched by the KEXEC entry, so
> get_maintainer.pl does not report kexec maintainers for changes in that
> file.
> 
> Add it to the KEXEC entry.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Baoquan He <baoquan.he@linux.dev>

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d738990161bd0..c61a1f0ad330e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14782,6 +14782,7 @@ W:	http://kernel.org/pub/linux/utils/kernel/kexec/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
>  F:	include/linux/kexec.h
>  F:	include/uapi/linux/kexec.h
> +F:	kernel/Kconfig.kexec
>  F:	kernel/kexec*
>  
>  KEXEC HANDOVER (KHO)
> 
> -- 
> 2.53.0
> 
