Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=89.238.66.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480863;
	b=xa9dvXcw7dYS2OiaYAgfX8xZrIJ7hYkpY+nVma//3Vk2HEF8axiRVRW4pKQtrQbTUg6W
	 sJYakzUbvDAQ1FM1ho8SRNc3lkBRQrokhaj11ONl7jijSzjRbtMMZE+thMNfBZ7HsUxJ7
	 VHWXqACc1Nz+VnOhbunoPFQfLqgouK1EI6SHPmJLTflITHMQ+No+8oI7U4w7dP1bH3LBo
	 2UrtR8XBjxMD+BDXG12jXlFeFmjkCcEQETn6NY5RyUZj9AL/Grp1Q68kXNI78vFZX0yuM
	 ReT36+hhebchWChAeHMYtzfG2Npei+cQlB2Jr82heUWEEgD1KMz6uh3JNr4EyEAjh1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480863;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Operating-System;
	bh=WjHy5vNfMz+e8EDQ0BYcoKWbkVxUkzvypi9PgF5UXg4=;
	b=WPpdkYBsIEzK7P+MUBbhx8cYXpvYXDJTMyfSLO7fhlxh9Eei6XV8kv36FG2R64tSC3FO
	 PtHcHgDwGR7kmbS50v75GGt8SLLhkmIirDQDsg8VPgks5Je8fvHZnUPMhbBz151nhVQUS
	 e9WytT5su4fYlNWV6XZ19+TdHmdHjR0KN0/X3b417WKrSAFZ1dY7CDEw9V6yYkJqCXfSa
	 Ocf5AV1q2LFu7TZHna4THTCx+IYy1xaeZluFsdSqWvlPcD15yBi8fggFWceeJozeeL/7s
	 QFDTbGl8NjmFvL8wAbogodVLMv5puiqrjuhG1QRZouELt3o0a7+gvnQLvgvWTKmxLaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=openadk.org;
	spf=pass smtp.mailfrom=openadk.org;
	arc=none smtp.remote-ip=89.238.66.15
Received: from helium.openadk.org (helium.openadk.org [89.238.66.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A5D606A319
	for <linux-sh@vger.kernel.org>; Tue, 20 Oct 2026 07:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7A5D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openadk.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openadk.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=openadk.org; s=2022;
	t=1792480860; bh=Q3gJOuURNSJhbxakHcq6LSGUy6534bE1zqOEftCutXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EXIi7vqq31n6pq+6Tnh77atH/Q+K7INcv6JFYPl/djeINwf4aEg+2wAGULSH/rRI9
	 T0nDMIDK7+oQh6fgF5t/fA3j9cAeD/7ooFhuWuAVItb7fochlp2np63eF+07nEfxKI
	 GjZ3freOH6S6WOvYA1OhM6CxinG0SkniHkxRf0Ia8Jk0D7/d4z8oRzISTfr9ag8oSi
	 iXL+/UAGsvWjiNZqsCiwzUodF2u8wfpYH5yIwASJ0V0HsIHf04z5zK3CbcAJ88He2t
	 mfJcRXlicyFNUzpBE7Hyy2PjrcuqGnfAl+342BEDLYtDv3FqJOBPAZs50u44yZVlKV
	 sXanWTfwdBwCA==
Received: by helium.openadk.org (Postfix, from userid 1000)
	id 2924731E0B69; Tue, 20 Oct 2026 09:21:00 +0200 (CEST)
Date: Tue, 20 Oct 2026 09:21:00 +0200
From: Waldemar Brodkorb <wbx@openadk.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Waldemar Brodkorb <wbx@openadk.org>, linux-sh@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH] sh: select BINFMT_FLAT_NO_DATA_START_OFFSET for noMMU
Message-ID: <atcWXCw-LNI1D-Ew@waldemar-brodkorb.de>
References: <atbnbO68dvPSW5bI@waldemar-brodkorb.de>
 <CAMuHMdUCTOxqwHnh0nnQOntSLq+WEXdZ0KubV89sfz33wufgbg@mail.gmail.com>
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
In-Reply-To: <CAMuHMdUCTOxqwHnh0nnQOntSLq+WEXdZ0KubV89sfz33wufgbg@mail.gmail.com>
X-Operating-System: Linux 6.12.107+deb13-amd64 x86_64

Hi Geert,
Geert Uytterhoeven wrote,

> Hi Waldemar,
> 
> On Tue, 20 Oct 2026 at 06:00, Waldemar Brodkorb <wbx@openadk.org> wrote:
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
> 
> Thanks for your patch!
> 
> > Tested on a J2 board (Numato Mimas V2, sh2eb, noMMU) with Linux 6.18 and
> > FLAT binaries built with elf2flt: with this change the data segment starts
> > exactly at the end of text and init runs.
> 
> V6.18 is getting a bit old. Can you please verify on v7.3?

The problem with Linus 7.3 tree is, that Florian's patch which fixes the
compile error with nstree.c is not in. Or do you mean linux-sh tree
for-next branch with Florian's commit eb549e808390eeecf07618b8c3a82a6f2a887e70?
 
best regards
 Waldemar
