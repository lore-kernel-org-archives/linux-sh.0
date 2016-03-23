From: Rob Landley <rob@landley.net>
Date: Wed, 23 Mar 2016 05:08:51 +0000
Subject: Re: Fixing SH cache assumptions
Message-Id: <56F224E3.9040406@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20160322211905.GA11781@brightrain.aerifal.cx>
In-Reply-To: <20160322211905.GA11781@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 03/22/2016 04:19 PM, Rich Felker wrote:
> Currently arch/sh has a hard-coded assumption that the cache is
> virtually indexed (and virtually tagged, from what I can tell), and
> thus needs to account for pages that may alias. While this is correct
> for SH3/4, it's wrong for anything NOMMU (since there are no virtual
> addresses, only physical) and the only reason SH2 works at all is
> because its small cache size (256 lines * 16 bytes per line) matches
> the page size, yielding an alias_mask of 0. If the cache were any
> larger (like it is on J2) then the alias avoidance logic would kick in
> and lead to calling kmap_coherent (which is BUG() on NOMMU) and
> possibly other incorrect or suboptimal behavior.
> 
> I've avoided the issue so far on J2 simply by lying that the cache is
> small, but this needs a proper fix. It would be easy to just #ifndef
> out the logic that sets up alias_mask and shm_align_mask on NOMMU, but
> I think it would be better to somehow represent the cache indexing in
> the cache_info struct or elsewhere. In case the future J4 has a
> physically indexed cache (which is my hope), such an approach should
> naturally work for it with no further modifications.

Wikipedia[citation needed] is under the impression that physically
indexed caches are not a happy thing on systems with MMU:

https://en.wikipedia.org/wiki/CPU_cache#Address_translation

(I so want search anchors. Instead of #Address_translation, if I could
add $PIPT it could jump you right where you needed to go. But no,
mozilla never did that and chrome apparently hasn't thought of it.)

This sounds like something nommu systems do. Are any other nommu systems
currently device tree enabled? (Blackfish? Coldfire? Is any of the
Cortex-M stuff actually merged in-tree yet?)

> Any preferences for how I do this? Just add a type field to cache_info
> and make the default VIVT for existing models?

It sounds like a device tree issue. How would you represent it there?

> Rich

Rob
