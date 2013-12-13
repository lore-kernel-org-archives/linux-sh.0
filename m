From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 13 Dec 2013 20:59:54 +0000
Subject: Re: [PATCH] sh: Add EXPORT_SYMBOL(min_low_pfn) and EXPORT_SYMBOL(max_low_pfn) to sh_ksyms_32.c
Message-Id: <20131213125954.d83a4044.akpm@linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1386893438-23573-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1386893438-23573-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 13 Dec 2013 09:51:00 +0100 Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Note that Ralf decided to fix it differently, by uninlining virt_addr_valid:

geeze, what a mess this is.

I suppose that the proposed sh patch is reasonable - it's the sh
implementation of virt_addr_valid() whcih chooses to use these symbols
so sh should export them to support that implementation.

