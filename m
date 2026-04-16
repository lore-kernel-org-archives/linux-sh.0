Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395BB18050;
	Thu, 16 Apr 2026 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338422; cv=none; b=ZHCQERJJnb9Z/6OI5v5v3VM01JIIfpXkkIUddL/yN2dahrhZX8muGLVzFYNp2D6+D4jyTU3Hwm6infyVc8KSPmzfPTIEixTYBExnKLYz4P0kLz832oJzijS9pIeMy/+tyGsyC5Lg9/8dVfZKHD7svy/tyhtftQYzFSFrOBMEMBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338422; c=relaxed/simple;
	bh=LekRJmHgUTMeCrrUlJkT3d4Zogzj8MnPvtN9G3GWKdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6PkLwxQHbaPLx7nh2qhUuAjGy5+OJ764onCeyTeZZaP56H+e5F7NcsE+DpzfMvIpOc/L79LkJf3oWnIhVhfq/qBmi7qGJuxGrDmLzJXrtfEx6sG2f8ENZL1hxJv1XrA7FEwLMnC3ckLew+n+/vEPYNiCxu7/PmO0QUqT1SfiuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G3lhoHOX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+rrM0Y92; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G3lhoHOX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+rrM0Y92"
Date: Thu, 16 Apr 2026 13:20:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776338419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LExLVuqyhTOkOVamJWb5O1XClOyZrMPwBLip8u5VI/0=;
	b=G3lhoHOXFvu2XsLZqqBxwQ2aeouAExJvErpcyfstcq93MsKzpwePMU43HG/7Smdqh2eVLN
	S9N0K2FkueMkGcd2PERsiyQKO973JEAOFgg0oAlBvsDzprr7kLa5a9NM+XMCfcTefBennr
	qmIiOoQP7NijCTGdGX1eEkTKFFS605R06xRjKM4Ou+SBXlgyIDE2W6F2moUTXWs0IrLDEw
	3V8kbH62mWMw2sY2Bd1pCZeayUAgH9h2gSPC6EyZ1hZqZPiKgYlv5atGvLdCBOhKtkLxiR
	DQfbyjqaHZWOXZ3Vj3+tmppceARSYceRRMmN5egMKyq15GfPaaOgHJlfSCndJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776338419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LExLVuqyhTOkOVamJWb5O1XClOyZrMPwBLip8u5VI/0=;
	b=+rrM0Y92oFfTPzNxgkddAmr7KUd99MKZNko+I6bymlTxZFuEns7sCvL5+MrFsVvu0tp1pB
	Pc2kkXE0TvQ5xTAQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Mike Rapoport <rppt@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v3 3/4] arch, mm: consolidate empty_zero_page
Message-ID: <20260416131914-f20c3a56-bddb-4488-b4bd-560e52ab9416@linutronix.de>
References: <20260211103141.3215197-1-rppt@kernel.org>
 <20260211103141.3215197-4-rppt@kernel.org>
 <20260416100221-57063053-1c9e-4450-8b0c-d9783657fa47@linutronix.de>
 <aeDBw4O655-pXiHy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeDBw4O655-pXiHy@kernel.org>

On Thu, Apr 16, 2026 at 02:02:27PM +0300, Mike Rapoport wrote:
> On Thu, Apr 16, 2026 at 10:10:06AM +0200, Thomas Weiﬂschuh wrote:
> > On Wed, Feb 11, 2026 at 12:31:40PM +0200, Mike Rapoport wrote:
> > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > > 
> > > Reduce 22 declarations of empty_zero_page to 3 and 23 declarations of
> > > ZERO_PAGE() to 4.
> > > 
> > > Every architecture defines empty_zero_page that way or another, but for the
> > > most of them it is always a page aligned page in BSS and most definitions
> > > of ZERO_PAGE do virt_to_page(empty_zero_page).
> > > 
> > > Move Linus vetted x86 definition of empty_zero_page and ZERO_PAGE() to the
> > > core MM and drop these definitions in architectures that do not implement
> > > colored zero page (MIPS and s390).
> > > 
> > > ZERO_PAGE() remains a macro because turning it to a wrapper for a static
> > > inline causes severe pain in header dependencies.
> > > 
> > > For the most part the change is mechanical, with these being noteworthy:
> > > 
> > > * alpha: aliased empty_zero_page with ZERO_PGE that was also used for boot
> > >   parameters. Switching to a generic empty_zero_page removes the aliasing
> > >   and keeps ZERO_PGE for boot parameters only
> > > * arm64: uses __pa_symbol() in ZERO_PAGE() so that definition of
> > >   ZERO_PAGE() is kept intact.
> > > * m68k/parisc/um: allocated empty_zero_page from memblock,
> > >   although they do not support zero page coloring and having it in BSS
> > >   will work fine.
> > > * sparc64 can have empty_zero_page in BSS rather allocate it, but it
> > >   can't use virt_to_page() for BSS. Keep it's definition of ZERO_PAGE()
> > >   but instead of allocating it, make mem_map_zero point to
> > >   empty_zero_page.
> > > * sh: used empty_zero_page for boot parameters at the very early boot.
> > >   Rename the parameters page to boot_params_page and let sh use the generic
> > >   empty_zero_page.
> > 
> > With this in mainline as commit 6215d9f4470f ("arch, mm: consolidate
> > empty_zero_page") booting sh on QEMU is now broken.
> > The machine hangs before any output.
> 
> Hmm, looks like sh does not like boot_param_page declared as unsigned char *
> This fixes the issue for me:
> 
> diff --git a/arch/sh/include/asm/setup.h b/arch/sh/include/asm/setup.h
> index 63c9efc06348..b7c4469cb61e 100644
> --- a/arch/sh/include/asm/setup.h
> +++ b/arch/sh/include/asm/setup.h
> @@ -3,12 +3,13 @@
>  #define _SH_SETUP_H
>  
>  #include <uapi/asm/setup.h>
> +#include <asm/page.h>
>  
>  /*
>   * This is set up by the setup-routine at boot-time
>   */
> -extern unsigned char *boot_params_page;
> -#define PARAM boot_params_page
> +extern unsigned long boot_params_page[PAGE_SIZE / sizeof(unsigned long)];
> +#define PARAM ((unsigned char *)boot_params_page)
>  
>  #define MOUNT_ROOT_RDONLY (*(unsigned long *) (PARAM+0x000))
>  #define RAMDISK_FLAGS (*(unsigned long *) (PARAM+0x004))

Seems weird but works.

Tested-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Thanks!

> > Reproducer:
> > ./tools/testing/kunit/kunit.py run --arch sh --cross_compile sh4-linux- --raw_output=all example
> > 
> > > * hexagon: had an amusing comment about empty_zero_page
> > > 
> > > 	/* A handy thing to have if one has the RAM. Declared in head.S */
> > > 
> > >   that unfortunately had to go :)
> > 
> > (...)
