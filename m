From: Rich Felker <dalias@libc.org>
Date: Tue, 22 Mar 2016 21:19:05 +0000
Subject: Fixing SH cache assumptions
Message-Id: <20160322211905.GA11781@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Currently arch/sh has a hard-coded assumption that the cache is
virtually indexed (and virtually tagged, from what I can tell), and
thus needs to account for pages that may alias. While this is correct
for SH3/4, it's wrong for anything NOMMU (since there are no virtual
addresses, only physical) and the only reason SH2 works at all is
because its small cache size (256 lines * 16 bytes per line) matches
the page size, yielding an alias_mask of 0. If the cache were any
larger (like it is on J2) then the alias avoidance logic would kick in
and lead to calling kmap_coherent (which is BUG() on NOMMU) and
possibly other incorrect or suboptimal behavior.

I've avoided the issue so far on J2 simply by lying that the cache is
small, but this needs a proper fix. It would be easy to just #ifndef
out the logic that sets up alias_mask and shm_align_mask on NOMMU, but
I think it would be better to somehow represent the cache indexing in
the cache_info struct or elsewhere. In case the future J4 has a
physically indexed cache (which is my hope), such an approach should
naturally work for it with no further modifications.

Any preferences for how I do this? Just add a type field to cache_info
and make the default VIVT for existing models?

Rich
