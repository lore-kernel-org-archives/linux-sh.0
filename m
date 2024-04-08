Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABECC36126
	for <linux-sh@vger.kernel.org>; Mon,  8 Apr 2024 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566449; cv=none; b=K5vjDLsviATqum3mXpnqTxEKTdvr6vj1M238W/E24/cQOBhsShz1KwxK4ir4itcAs/DKqHknl55690BOSq+a4Tr1Zg+CUnme8miOrW02Lq5nM1wn+6ZS98JnyVfWgZVENGn9725LGS3qE4uHAfdz/5BHg/HZMHlMq2bmDq60KYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566449; c=relaxed/simple;
	bh=1nlHXXJ+DEATsx4Zrzm2O80Fmt2rcWvUCv4w88shLpI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iKBLqfm0EPNQ0rJmLkt1MVZfVYGj4kR0CGHpU/aFqkpTERK0IIV0UgmWv8/RkH5JSQoH9vsPoa2eHyOyYf0Rg2NBrdeeQ4XzqJRdxjNH/woU01L4UChvfBkqAvxOrT4yD7h2LBlj7Gt2ClAViV05IvKIP40pHO7hyc93bu9COj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by xavier.telenet-ops.be with bizsmtp
	id 8Yu02C0040SSLxL01Yu0Q7; Mon, 08 Apr 2024 10:54:00 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rtklM-00AMXp-3N;
	Mon, 08 Apr 2024 10:54:00 +0200
Date: Mon, 8 Apr 2024 10:54:00 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: linux-sh@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.9-rc3
In-Reply-To: <20240408075342.2495918-1-geert@linux-m68k.org>
Message-ID: <2d5f2edd-217-d2e-925b-7d9b186072d3@linux-m68k.org>
References: <CAHk-=whDuqyVC6xMkOnNt2EeTd-s4uqa3sYghj5UzkELFW2bpw@mail.gmail.com> <20240408075342.2495918-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 8 Apr 2024, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.9-rc3[1] to v6.9-rc2[3], the summaries are:
>  - build errors: +4/-1

   + /kisskb/src/arch/sh/mm/nommu.c: error: no previous prototype for 'kmap_coherent' [-Werror=missing-prototypes]:  => 80:7
   + /kisskb/src/arch/sh/mm/nommu.c: error: no previous prototype for 'kmap_coherent_init' [-Werror=missing-prototypes]:  => 76:13
   + /kisskb/src/arch/sh/mm/nommu.c: error: no previous prototype for 'kunmap_coherent' [-Werror=missing-prototypes]:  => 86:6
   + {standard input}: Error: invalid operands for opcode: 1099 => 610, 1099

sh4-gcc13/sh-allyesconfig (seen before)

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/fec50db7033ea478773b159e0e2efb135270e3b7/ (all 138 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/39cd87c4eb2b893354f3b850f916353f2658ae6f/ (all 138 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
