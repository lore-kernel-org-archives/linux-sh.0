Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795316692;
	b=Qu6Qx4NquF1HLJGjLDso+mJTRH3qbflJaxuS2vhaw+9zclM0C3YPEPryQzJBNU7ifu3Y
	 Ob7D45vH9dDwC09UKrSnBzNUs56jL8QXTpZXzANFHW4nlUMzeOKU4t4iaiAV2alMfR6EU
	 MZRlcucjNoNz8czb7XOFpS8zrdCghusjcMjaE2Sq6GQ+aFW8n+ElkE0kqNvH4RJzGIz5o
	 qQTAjFUnIB0WxiuvDKQeS8TYpLsNw3VDmQKwj5Ru1giw7Ao2MA+HQvwPX7OfYIZu+3lh4
	 tWlbtHHNlvz8SdQEwwZwEp/sHLI2W+0MUlv1+IyU0RWutTvngYSBA/ki/0qzVtaLBlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795316692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type;
	bh=NieCLCvG+gDw8VjVQsEmj+Xb3Nuvde1xSdj6TYYBmIA=;
	b=BUG3f5j+SLbLIkVQGZoiLzi0RXHXEHKk5ZPcUih4oWY4TBztxndK+6Z/3EbWK6wIsqVT
	 JGVkdH5GjIPuxaeI5I+UUneQoRNrcwyQPLKfSHTwh7HKAy0vbQ3cbykkexqdxMdqSGHa5
	 wyYK6YkRmM/b/W2Tnp/WJrKiaSTiPTclKd79A18OQm0ibD2h/VZGxibJuU5pYnOy+sxU8
	 zdo0nX1QjXan29aUXjhInVuqcB58PK5RMCuo7MeHbHva7vs4qjaXiIGWj9tLFH4FBe/+t
	 27xc/j7dWg3idIZQPZsbf/S+P/BP5ojCa4O5PGm8tGdAVD9NoGLsHwr0XLNHIqRvxVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lQMapLMR;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BB9606A332
	for <linux-sh@vger.kernel.org>; Sun, 22 Nov 2026 03:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94BB9606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lQMapLMR
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a315ed211so2712829eec.0
        for <linux-sh@vger.kernel.org>; Sat, 21 Nov 2026 19:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795316691; x=1795921491; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NieCLCvG+gDw8VjVQsEmj+Xb3Nuvde1xSdj6TYYBmIA=;
        b=lQMapLMRecxhRuMkTSymbForunIxX0OPXsGQ1CXe025r/577yULQNYi3TNrBG53/Qv
         zYU80ixAjK16x1kduXUqa1QZW9W/3ti9d/2xwfANhvwcppx94XY1wfu52uKp1wNIi+xo
         0BbROgPXyu0B62JpFc4+zEJIoiLBcGXeP+W6/munvXDcClY8J5U7eqCSCyRjBp3WeH4+
         q1p1SE27fCRmjWxB4WY3p9l7b9yn5x1FejoLmUjB8Y+BhmVh9oZGKVtoBu6VvuhXecB+
         kqHQVq97TpxJ2ylXI5iv8vW2n/kYW3PMkK+9IBmWOkrDx9AQECQxv8quTTJlItW+6/Cb
         tThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795316691; x=1795921491;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NieCLCvG+gDw8VjVQsEmj+Xb3Nuvde1xSdj6TYYBmIA=;
        b=BC2COtP1ztosBEa6OjDBoEFV2C9a2UrDpWrxVCQdCtWy+bFdHD0LVK4pbQ2Tcan1Rm
         rupvomEWTYIGefWfz6M9vNujxLEnxRLav2VMgZqvxeHZJvEBtIfdK6PVVzfIVmo7fvig
         8VMNUxJAzV2OYqifYCJMvbvwOo9BIY4pJlLsUNb2Pu76s6z0LXJNvWuHZ0OY+P/DqVUK
         sUXg2mi+Xh0axHGeexpe0y4oUvla5U5eupCAeq7IaG+2N4WNhMVqj51ihRZFowHYAltB
         X2V1oyA3L//P9rj20JfcbRmlRUIMcIph1ka/8+lsKeRvU3KVoMdB4P6HPWWUijgyp92U
         ksUA==
X-Forwarded-Encrypted: i=1; AL+hErFyinHf6TmUayoZ6xmHEtYkJVxf+wD0GRZZ2Dc9NPmgSqISWUHG2nSU8vFGoCNZ2UCfrHV1hIpmGA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+9VGG9noeAtOz1fx9h41m3vvCOCWVxY5Uf8uukkUM3dQuIpM4T
	XSRIKv/fAQM5OEGppcZ9P8Mz682FQW6bzVJ6v6P8n+eu3E5m8PzKxNP80BFZzA==
X-Gm-Gg: AZFdTZcdbNTnvILHjGPZiakHJLpyoS9QnFhgVilBeFc6IoK0mfGHpgjlRsD1FGfUcDp
	uikH3mZGBXbufq+ov896MRAvCjggrIeAdrehIq5xlnBUGKtRpy5VJtYbqxMSm+QJTH8alYPvE0Y
	3uSW4Y3cK/W9udQtOLDS1E7AjRwqVZ+vQidZW6uPq/JygHV6O1J200Cka9TXsRCtD5hxXIJUIec
	yepo9Q5kbILO9ZClLWYuEhZW5ptmHOWZddBa+9gGqwvFRuscfTvNJ3kSjVREv/rcl6m6UmBKyws
	YzGgiLbZRkZemPbOs1KYXpSv8YRpEe+7gqT5IPr2nKc7gscTyvncZDo+HZOCwgmSvE3iXpAOlYV
	Z1ww6HoqFmt6Neb8KigFR+yogZPGj/eeb/UVRx7uJfrr1SCf3zcmXBf+zsw15QVzJtnMxWKXmuS
	Rr2jd+5OBnZVazULsA0pbSuBY6JWjrzeIKtrv8VnxwOdjwyw3bnJRN83ZMZaMkG+pko9NgmOTyM
	aEtg91xoNjw84nyRd86EUOHGYABAQ0cAdCd/pI7SrFFYCGdxbtRGL6Rs2DiUGwm3enp9JX4v6Ga
	k22nj+BwPoWnjHyz89OL9y1T9yF/IDQySDKC6cf5aQx7NTjN
X-Received: by 2002:a05:7300:50fa:b0:383:9f52:e54d with SMTP id 5a478bee46e88-3856ff52e83mr8869235eec.8.1795316691531;
        Sat, 21 Nov 2026 19:04:51 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm24302948eec.27.2026.11.21.19.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 19:04:50 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Paul Walmsley <pjw@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Rich Felker <dalias@libc.org>, 
	Russell King <linux@armlinux.org.uk>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org
Cc: Alexandre Ghiti <alex@ghiti.fr>, Christian Borntraeger <borntraeger@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Cong Wang <cwang@multikernel.io>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev
Subject: Re: [PATCH 2/2] arch, kexec: declare kexec and crash capabilities in Kconfig.kexec
In-Reply-To: <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
Date: Sun, 22 Nov 2026 08:33:10 +0530
Message-ID: <wlq5k1ox.ritesh.list@gmail.com>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org> <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Mike Rapoport (Microsoft)" <rppt@kernel.org> writes:

> The options that let an architecture opt in to kexec and crash dump
> features, like ARCH_SUPPORTS_KEXEC or ARCH_SUPPORTS_CRASH_DUMP, are
> defined in each architecture's Kconfig as def_bool, and most of them are
> copied over several architectures.
>
> Declare these options once in kernel/Kconfig.kexec next to the options
> that depend on them, similarly to how mm/Kconfig does it, and make the
> architectures select them instead.
>
> Selection conditions are preserved, so there is no functional change.
>
> Acked-by: Baoquan He <baoquan.he@linux.dev>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

No function change observed in this patch (as described in the commit msg).

LGTM, feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com> #powerpc

