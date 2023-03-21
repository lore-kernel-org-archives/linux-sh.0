Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8612FC74A5B
	for <linux-sh@archiver.kernel.org>; Tue, 21 Mar 2023 16:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCUQli (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 21 Mar 2023 12:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCUQle (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 21 Mar 2023 12:41:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9573CE32;
        Tue, 21 Mar 2023 09:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kpqcXT8QqZUbgAbHLkFBXBAuimNYfe86vG0UJSyYaa0=; b=mT6QzWgAzHeZ2aR0SzXvvHka2g
        v0h4J+l4MslLiuDg9mUJXGjaPdp51AOBdd5SqPyBs9GTOGJ94bkGQuL5XHXLLMADUPlcF5DcYpH3k
        jUU+V95m0jtK3yuqWE582W6R8rkZLCMJL1unrYc3TkuFa6grmhRaxd7rZvVANe0RJ3w6XCJqNW/TL
        y7MAwIMBunId3Cosr0okHwHX0JhoU4Nm/soPHMDObvAjPuwZmby7iPwtO8UjQcYkocYHOCp23OXHc
        1YDroaylCEY2wsEJd8vGVqjZ28sBSQ3oYz0jV9sHvC0tZlLdgXYIgOfWCwcaBX2WoEoPDuD98lNxm
        qCdmHxYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pef2W-002CQM-Rt; Tue, 21 Mar 2023 16:40:48 +0000
Date:   Tue, 21 Mar 2023 16:40:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] mm/slab: Fix undefined init_cache_node_node() for NUMA
 and !SMP
Message-ID: <ZBneELQuakjva1xa@casper.infradead.org>
References: <67261c513706241d479b8b4cf46eb4e6fb0417ba.1679387262.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67261c513706241d479b8b4cf46eb4e6fb0417ba.1679387262.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, Mar 21, 2023 at 09:30:59AM +0100, Geert Uytterhoeven wrote:
> -#if (defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)) || defined(CONFIG_SMP)
> +#if defined(CONFIG_NUMA) || defined(CONFIG_SMP)

I'm amused by the thought of CONFIG_NUMA without CONFIG_SMP.
Is it possible to have one node with memory and a single CPU, then
another node with memory and no CPU?
