Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC14356A20
	for <linux-sh@vger.kernel.org>; Wed, 11 Feb 2026 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770840874; cv=pass; b=T2OstEuzar8sCJiZU6IjKMdlqyNiX4nnHwQ+8oA30mmnjCfwADAGYM3VJKdrYn/vMpnuptpWHLDU4ZnInFdatbv9LZCI+AysGgS24HOxdtslXFGrlinp4euB2pM60Bz6m1Pk0Q5wAO4GzaD+VyT3dWrytmkhTPGmXeHb7QrdGKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770840874; c=relaxed/simple;
	bh=XTU0SZsxOmJ3FoM/DLxyJrm+s5UGvDwm08Uhn3BjVVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJzoftSCTuqK4OcmIZC4C9JYELXlr9nWh9t/Zvb+2eorOK4mCZHdoWWm+I9iy8B1dtBGDRv9HeFN1//9JI+FzLG5NFp2RkKxsX9tvp8CPji2sNqxk+4yS4c7ohoGVrn60IbgBkZjx0fc8bMcHfdNjQgQl9HOTT7M1tI2QwIiK18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APb4+MbR; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APb4+MbR"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8871718b00so909108666b.3
        for <linux-sh@vger.kernel.org>; Wed, 11 Feb 2026 12:14:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770840871; cv=none;
        d=google.com; s=arc-20240605;
        b=eACkNPH6r/DYl+mzz3u38tAaE5xgY5GwHGZ6nhodxsMWScyo/kVn5nncn46GnFy9uH
         NFSUndsyW9TPs+f13ld936wblClGiZbUS3QJbba9JcjxUxjJ5RXcp/vVWqLwjbd2T4wv
         AzJAeijLCGnjIQUWBP/1sxiNjQeHGdZ2t2dcYOtsvQGN9NBDxCniDtlnxXpiw+aPreTS
         v6UY6mbxoXnOzwDLFvA8cdU6cMlZiWqrCWHUqmiGL4Ov0WbQYZCkj5cwsrzysMxPvf1y
         cQIsXKCTtevp27tx/LWO7gLhq2KBvwYuZ1iudHCBibXUH0o2n9OZKL8jM+hwRIfdUkCB
         IQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=28hr9LjidhOb4+7vDtUZiT7dYr2nuAMqMlceW5mXuOg=;
        fh=q0cbz9/+vrgST2OWWYf1xeBoarhMCtnWRdw2p2O1dMA=;
        b=S4dYseg018k87d5VUvcgPBhOjjzYGoTemmawAKEstbuGRJaDUCtE6F65dsxoYSkgys
         TNJdnhFxjfbsGHcow7oec8ORq2Mw4GqbshawO/0NY6LkyWSFI1z3UR/EPhPQTRxSrbqU
         2HIEwwYWdi83elMpp14y5vbkSO6mhxIa2WinryZvc5Iets306Y/RSV1BHZaYKrUyOe1E
         EH2TSgO1TnrbTtDHGhwArReeg1lMEyXXGJT0NvZsD1BEXTcIX/ihs4qLJ37GXyaO2o7q
         R31UikLPguGMw3WDELnaA5NVDmyM5KrHMyFwCNMuZ5Kx0PxOx6jzo34PptDpWO91+ZQg
         PVjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770840871; x=1771445671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28hr9LjidhOb4+7vDtUZiT7dYr2nuAMqMlceW5mXuOg=;
        b=APb4+MbRhaKWB087tAeEmwP4Lu08rdhv4sI3dkqV/YTBKS/mgYlB4ErJ/k5iCsIhES
         Dyw4yDNNlDLkNRi9ufKgKfoCSPhw1aSEB0/poC9PbO0t1/cNXY8FT9FWmqb2ZydsqZgd
         53dDCxe/YzpA/t0cV+IuTD4fKyw73qjg5LCeIynNVe7Hi2tyRKsLAamW+zTJIDsSswnY
         IGlos9hWFaX4FF+o122mFll2sqWsBCEXNdPmDDBvTHhOzo5VINHjmH16G9wTMe2fYvsc
         df42ezDoaRiLAol2+Y0BhdzgWhRvx874hQwyXFwYh7WvP1MprulEETQ0RPLz4DYSv9nK
         9W+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770840871; x=1771445671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=28hr9LjidhOb4+7vDtUZiT7dYr2nuAMqMlceW5mXuOg=;
        b=mCwIrhXxcuScculc+wc9ywoErM7fZYfcgrk5+Ql2SFxsoW8eaJ5YLqweOOZnrGRo/o
         sjaWSII0dBnEIjR2tSiWi4DwE2/8MyBytkiXjQMdwj/RmG858IHJshV5JDgJJGOH39KP
         BBKohJPneSLe9IujlY3OHAAcASzTBCx53x3xtwci24Ww1erez8/BC1YUZRn+kSXsG6kb
         rZ3yoRxiNFKWBepjYhs2Wdwg4T/m2usteF2INz4AKHK/rwy+cbMXSgfccUR29b2Hvcnz
         ri8LD7O1haDNh3U1pbkWdiOnY7umR4+0sBgg1m3hNRWv4UdRzNe0Oc19leZB54tAb4Yu
         j8TQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9BPzbGInmv4cSG6kY3kxsgtbVMWXaHioeFc9SGpwOxInU0ypGjvs+6hKCucSb2yboUaZRuI1ApA==@vger.kernel.org
X-Gm-Message-State: AOJu0YykBfyqjfk5fSOn56S4y0oyF7qqahWPWhwz2M4qVRsUhZ2AljmZ
	SqxVHSwcjIkGa+NBjGBCOONlk+TwATVUW6X0gKopHa1/xA9pitrror+SjDNb0WsM6JaheLGZd3u
	buV4QY570xVB94HYOC+/vAMbHyieVlO0=
X-Gm-Gg: AZuq6aIWD8CG4l/nQ7wGaQUhXk4VNY+bPqp/xnzrBOivYr4BHBnFMx3M6+dbEhIkqUn
	G1PGwSWHQBGnLIgN3S2cwfUX5YeG2GmOBnRkgz/3iVRpLM66U3v9v9lLLJkVu3yNarQoE0GYLX2
	jvZv0AFSI1K/wzZqw4HTwU+mEKUH32l5Uko/qoa/+ONOh20AfjBzUvOOaOf7vuB2KSNAcYknWpS
	aOxF6cEliQ6nTPk6b4eEdAyx73/9oO00rhZAe7zks1WkTBcdFcmf6TyjFs3oMXTmaqFiLTcXyst
	Ogkveyz5Uyd3r1o7CwrZXwn8QDS1H+7PE3kjjOokog==
X-Received: by 2002:a17:907:a08a:b0:b8e:64e:1ed with SMTP id
 a640c23a62f3a-b8f8f72d91emr17643566b.50.1770840871149; Wed, 11 Feb 2026
 12:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211103141.3215197-1-rppt@kernel.org> <20260211103141.3215197-4-rppt@kernel.org>
In-Reply-To: <20260211103141.3215197-4-rppt@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 11 Feb 2026 21:14:19 +0100
X-Gm-Features: AZwV_QgdPAvH3hw0825YIt93LQPupYFvh_AV-2zMkwGhubC87cSa2iVxpdoZwag
Message-ID: <CA+=Fv5T07oBJweU3tURD4Nuh7VRWovsf0zjHtA1nDAVNmO=D2w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] arch, mm: consolidate empty_zero_page
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andreas Larsson <andreas@gaisler.com>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@kernel.org>, 
	Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, Vineet Gupta <vgupta@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 11:32=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Reduce 22 declarations of empty_zero_page to 3 and 23 declarations of
> ZERO_PAGE() to 4.
>
> Every architecture defines empty_zero_page that way or another, but for t=
he
> most of them it is always a page aligned page in BSS and most definitions
> of ZERO_PAGE do virt_to_page(empty_zero_page).
>
> Move Linus vetted x86 definition of empty_zero_page and ZERO_PAGE() to th=
e
> core MM and drop these definitions in architectures that do not implement
> colored zero page (MIPS and s390).
>
> ZERO_PAGE() remains a macro because turning it to a wrapper for a static
> inline causes severe pain in header dependencies.
>
> For the most part the change is mechanical, with these being noteworthy:
>
> * alpha: aliased empty_zero_page with ZERO_PGE that was also used for boo=
t
>   parameters. Switching to a generic empty_zero_page removes the aliasing
>   and keeps ZERO_PGE for boot parameters only
> * arm64: uses __pa_symbol() in ZERO_PAGE() so that definition of
>   ZERO_PAGE() is kept intact.
> * m68k/parisc/um: allocated empty_zero_page from memblock,
>   although they do not support zero page coloring and having it in BSS
>   will work fine.
> * sparc64 can have empty_zero_page in BSS rather allocate it, but it
>   can't use virt_to_page() for BSS. Keep it's definition of ZERO_PAGE()
>   but instead of allocating it, make mem_map_zero point to
>   empty_zero_page.
> * sh: used empty_zero_page for boot parameters at the very early boot.
>   Rename the parameters page to boot_params_page and let sh use the gener=
ic
>   empty_zero_page.
> * hexagon: had an amusing comment about empty_zero_page
>
>         /* A handy thing to have if one has the RAM. Declared in head.S *=
/
>
>   that unfortunately had to go :)
>
> Acked-by: Helge Deller <deller@gmx.de>   # parisc
> Tested-by: Helge Deller <deller@gmx.de>  # parisc
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/alpha/include/asm/pgtable.h          |  6 ------

> diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pg=
table.h
> index 90e7a9539102..12a3c5f8ece8 100644
> --- a/arch/alpha/include/asm/pgtable.h
> +++ b/arch/alpha/include/asm/pgtable.h
> @@ -125,12 +125,6 @@ struct vm_area_struct;
>   */
>  #define pgprot_noncached(prot) (prot)
>
> -/*
> - * ZERO_PAGE is a global shared page that is always zero:  used
> - * for zero-mapped memory areas etc..
> - */
> -#define ZERO_PAGE(vaddr)       (virt_to_page(ZERO_PGE))
> -
>  /*
>   * On certain platforms whose physical address space can overlap KSEG,
>   * namely EV6 and above, we must re-twiddle the physaddr to restore the

This looks good from an Alpha perspective

Acked-by: Magnus Lindholm <linmag7@gmail.com>
