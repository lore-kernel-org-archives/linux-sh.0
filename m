Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31DA2DEA7B;
	Thu, 16 Apr 2026 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776337356; cv=none; b=atjkambXBwO0o3K0uToVfbRt6/XqezjaRDw4lM0+vNTfvslJ1Nm/vffojuWgzzwiiy4LTe8g9jj5mn7KUBvQYH/mYwO7gZaMaw77cHLdZ3ZYIfVcnzEgoKdlXJZeDX8oPc2Yy59/foelGggBdUIj04BxMNhow1B7JZ0/TbLMIXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776337356; c=relaxed/simple;
	bh=46lfpU4rVAhipbkBh+dqyHYerEK6axXIuEa3SsVYybY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7HATkNB7m7YkFMolAlwMzRaqP6HJ+QP/VAqXnQ7qW33DY7j6he0piJIYKe3JWZST2V0+NrAZETCNpPvIp5ZwHEzNFtVN8OGByvfngwCC7pBVOcpBzmEW7bfuBhnw+wI7q+dp8hi20frNut9YNPFc6TRFsu/oIlmKnX6i8TgIng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/lvgYMq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/lvgYMq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF43BC2BCAF;
	Thu, 16 Apr 2026 11:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776337355;
	bh=46lfpU4rVAhipbkBh+dqyHYerEK6axXIuEa3SsVYybY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g/lvgYMqhxgbdZTndBZsA+ofc5/WHdXHktUB69Po+cR1Gl88XowUpJhrnwSZEv2Z0
	 EFOUK6NK9bhmP95sehwR1ihfpVS6ev2LtISPmLK5hA4U3NAhUC1OSNZXj0GqV6z5Fj
	 wkfqAEUDqhuinGIVoCdtZ3rqhyAtDrA5xsNWXq7Z8fs3lq1c9y1xdFrC+kYc6iV+cC
	 gejIMgh02Vs+vC3DyeQGvoWICUtOz2Fi9zeyrdAQb5KRV4m9RgzTJZ8uSfiM8EVDCY
	 EH6prm0nfwKyFqGeSKs1L4h8rUPgkSrwcMAKQ80s8v+O7wWsN9R+oo6RYtXuFaZuHg
	 aPuaT1qjRVkBA==
Date: Thu, 16 Apr 2026 14:02:27 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 3/4] arch, mm: consolidate empty_zero_page
Message-ID: <aeDBw4O655-pXiHy@kernel.org>
References: <20260211103141.3215197-1-rppt@kernel.org>
 <20260211103141.3215197-4-rppt@kernel.org>
 <20260416100221-57063053-1c9e-4450-8b0c-d9783657fa47@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416100221-57063053-1c9e-4450-8b0c-d9783657fa47@linutronix.de>

On Thu, Apr 16, 2026 at 10:10:06AM +0200, Thomas Weißschuh wrote:
> Hi Mike,
> 
> On Wed, Feb 11, 2026 at 12:31:40PM +0200, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > Reduce 22 declarations of empty_zero_page to 3 and 23 declarations of
> > ZERO_PAGE() to 4.
> > 
> > Every architecture defines empty_zero_page that way or another, but for the
> > most of them it is always a page aligned page in BSS and most definitions
> > of ZERO_PAGE do virt_to_page(empty_zero_page).
> > 
> > Move Linus vetted x86 definition of empty_zero_page and ZERO_PAGE() to the
> > core MM and drop these definitions in architectures that do not implement
> > colored zero page (MIPS and s390).
> > 
> > ZERO_PAGE() remains a macro because turning it to a wrapper for a static
> > inline causes severe pain in header dependencies.
> > 
> > For the most part the change is mechanical, with these being noteworthy:
> > 
> > * alpha: aliased empty_zero_page with ZERO_PGE that was also used for boot
> >   parameters. Switching to a generic empty_zero_page removes the aliasing
> >   and keeps ZERO_PGE for boot parameters only
> > * arm64: uses __pa_symbol() in ZERO_PAGE() so that definition of
> >   ZERO_PAGE() is kept intact.
> > * m68k/parisc/um: allocated empty_zero_page from memblock,
> >   although they do not support zero page coloring and having it in BSS
> >   will work fine.
> > * sparc64 can have empty_zero_page in BSS rather allocate it, but it
> >   can't use virt_to_page() for BSS. Keep it's definition of ZERO_PAGE()
> >   but instead of allocating it, make mem_map_zero point to
> >   empty_zero_page.
> > * sh: used empty_zero_page for boot parameters at the very early boot.
> >   Rename the parameters page to boot_params_page and let sh use the generic
> >   empty_zero_page.
> 
> With this in mainline as commit 6215d9f4470f ("arch, mm: consolidate
> empty_zero_page") booting sh on QEMU is now broken.
> The machine hangs before any output.

Hmm, looks like sh does not like boot_param_page declared as unsigned char *
This fixes the issue for me:

diff --git a/arch/sh/include/asm/setup.h b/arch/sh/include/asm/setup.h
index 63c9efc06348..b7c4469cb61e 100644
--- a/arch/sh/include/asm/setup.h
+++ b/arch/sh/include/asm/setup.h
@@ -3,12 +3,13 @@
 #define _SH_SETUP_H
 
 #include <uapi/asm/setup.h>
+#include <asm/page.h>
 
 /*
  * This is set up by the setup-routine at boot-time
  */
-extern unsigned char *boot_params_page;
-#define PARAM boot_params_page
+extern unsigned long boot_params_page[PAGE_SIZE / sizeof(unsigned long)];
+#define PARAM ((unsigned char *)boot_params_page)
 
 #define MOUNT_ROOT_RDONLY (*(unsigned long *) (PARAM+0x000))
 #define RAMDISK_FLAGS (*(unsigned long *) (PARAM+0x004))
 
> Reproducer:
> ./tools/testing/kunit/kunit.py run --arch sh --cross_compile sh4-linux- --raw_output=all example
> 
> > * hexagon: had an amusing comment about empty_zero_page
> > 
> > 	/* A handy thing to have if one has the RAM. Declared in head.S */
> > 
> >   that unfortunately had to go :)
> 
> (...)
> 
> 
> Thomas

-- 
Sincerely yours,
Mike.
