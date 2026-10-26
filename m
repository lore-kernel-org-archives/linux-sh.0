Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017963;
	b=pll4xeFuJ1CA++gYQ3CpnuMKUrGyDq0kN6c/SVR12iFrrSAui1bSiZIlqbUjgFkYX0s+
	 PIZqJ+fv/jpBKjzVZafR8qgAmRek1Xl8vJiCTXUpTGF5zfIesEcRouZ9jTeZx+oX+5fEr
	 6wQuP9fbP5y8jBizpgWf1RsPLXBLN+aRO7XjkUy0hfx8psoKUwRnrLyD6uuk/EmnutMOX
	 Hx0720thM9y4LWQuR+1T2w2b5i8Q4RnMWUByea4DAMoY0EX8gCiMkYgjb+TvM6uVIMEhK
	 BEtbfdplqiZyufqS7Q6KxJ7B3vryPKn2RYZkEJrhSFrwBsp034n9j2qJm0vM7HV4//w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017963;
	h=Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6wcu0gTZ6kvwKbMOCUrr3DfyjZWgbhGE2d7Y7IRiyP0=;
	b=JfLW6LSH693F/T9uMQTZwwxjwS+gg9u6+m1cXDLN/eLq2g4kBLm1FtRP5urY0NxfH0Sl
	 ZcqV32jJChl79gMemyVqZONKtRTn04FGIK4ekN2dbpajO216nj56v6piJO80QXgrvbwSn
	 dMzBcbhoAgo+Y01UQSdpXsY804b2TbdP82378K1TvcQ/pklAxwirm4u3JEmvupOxkPHST
	 /yViL/XFk03E8y+87PEkkEm3zd+GS8Xei1iWP7yb/5XVi90M5iznMlHVikq3orQ/XTU6L
	 M0ExeEwTIZKj5IrVywKazXurdy+sW58SYFKSJem4RlUdmttEC+5VJbut2TpPXZT12yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AA6606A325
	for <linux-sh@vger.kernel.org>; Mon, 26 Oct 2026 12:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5D41F01825;
	Mon, 26 Oct 2026 12:32:41 +0000 (UTC)
Message-ID: <1ead42f9-470d-4a04-846b-62d1b5ef3963@linux-m68k.org>
Date: Mon, 26 Oct 2026 22:32:39 +1000
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sh: select BINFMT_FLAT_NO_DATA_START_OFFSET for noMMU
To: Waldemar Brodkorb <wbx@openadk.org>, linux-sh@vger.kernel.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Damien Le Moal <damien.lemoal@wdc.com>
References: <atgBKmRydeRteQ0T@waldemar-brodkorb.de>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <atgBKmRydeRteQ0T@waldemar-brodkorb.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Waldemar,

On 21/10/26 10:02, Waldemar Brodkorb wrote:
> binfmt_flat offsets the in-memory start of the data segment by
> MAX_SHARED_LIBS words and then aligns it to FLAT_DATA_ALIGN, so FLAT_FLAG_RAM
> binaries end up with a gap between text and data (commit 2217b9826246
> ("binfmt_flat: revert "binfmt_flat: don't offset the data start"")).
> 
> SH position-independent code finds the GOT with a PC-relative mova of
> _GLOBAL_OFFSET_TABLE_, which assumes data follows text directly, as elf2flt
> lays out the image. With the gap, the GOT register points below the real GOT,
> so every GOT load reads the neighbouring slot and gets a wrong pointer. On a
> J2 (sh2eb, noMMU) this made userland crash or hang right after start-up.
> In my case the data was moved up by 0x20 bytes.
> 
> Commit 04d82a6d0881 ("binfmt_flat: allow not offsetting data start") added
> CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET for architectures that cannot
> tolerate such a gap; currently only riscv noMMU selects it. Select it on SH
> as well when building without an MMU.
> 
> Tested on a J2 board (Numato Mimas V2, sh2eb, noMMU) with Linux 7.3 and
> FLAT binaries built with elf2flt: with this change the data segment starts
> exactly at the end of text and init runs.
> 
> Without the patch bootup fails with:
> [   12.080472] Fixing up unaligned userspace access in "init" pid=1 pc=0x(ptrval) ins=0x6583
> [   12.123609] Fixing up unaligned userspace access in "init" pid=1 pc=0x(ptrval) ins=0x6583
> [   12.175153] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
> 
> Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
> Assisted-by: LLM
> Fixes: 2217b9826246 ("binfmt_flat: revert "binfmt_flat: don't offset the data start"")

That looks like the right fix for SH.

Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg



> ---
> v1->v2:
>   - add fixes tag (Geert)
>   - tested with 7.3 + Florian's uaccess patch (Geert)
>   - added failing bootup messages to commit message
> ---
>  arch/sh/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index d60f1d5a94c0..b501153551c0 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -15,6 +15,7 @@ config SUPERH
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
>  	select ARCH_WANT_IPC_PARSE_VERSION
>  	select ARCH_NEED_CMPXCHG_1_EMU
> +	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>  	select CPU_NO_EFFICIENT_FFS
>  	select DMA_DECLARE_COHERENT
>  	select GENERIC_ATOMIC64

