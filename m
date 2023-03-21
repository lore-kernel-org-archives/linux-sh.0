Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20756C6FD1D
	for <linux-sh@archiver.kernel.org>; Tue, 21 Mar 2023 16:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjCUQnu (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 21 Mar 2023 12:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjCUQns (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 21 Mar 2023 12:43:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8501F515C9;
        Tue, 21 Mar 2023 09:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Z+zwblPNJ3OUYOnKk/QBbkl8n+ZHXybiPX0PiQx3oXU=; b=YHEt7/8HVk+HXyQdyu4UIyshX9
        24kbrya3mv8KOjHy2Mvq9WjJcPISA8U2TMNhAe71LJOCWB2xxAXOlT8a7A0sB0w1B06p8iCOAv+rL
        0d8pFv2ojSaI9VUu343HerXQVkP2UWXXTYjzWFROZzX2elqgRzqjHVtLuN4zllt6HH2UQrFGl+iY0
        7kGmtienyRFdp+fwP4KMvaE5qlhe7hqKwQj0G5fgN5END84mQjluWFCBg6A+13Yk6XimfuLf/Cq0D
        GTDq/tUG4bI9++AFKsUWh2fAla691b9RQlx0W0uP24zEaKTuqhChjmaJQSEr9/MnrQixHA4mk1fFc
        Iv/73d0Q==;
Received: from [2601:1c2:980:9ec0::21b4]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pef4j-00D6ty-1A;
        Tue, 21 Mar 2023 16:43:05 +0000
Message-ID: <227fdc99-b54a-eeb0-c4e6-21ed92731240@infradead.org>
Date:   Tue, 21 Mar 2023 09:43:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm/slab: Fix undefined init_cache_node_node() for NUMA
 and !SMP
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
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
        linux-kernel@vger.kernel.org
References: <67261c513706241d479b8b4cf46eb4e6fb0417ba.1679387262.git.geert+renesas@glider.be>
 <ZBneELQuakjva1xa@casper.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZBneELQuakjva1xa@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org



On 3/21/23 09:40, Matthew Wilcox wrote:
> On Tue, Mar 21, 2023 at 09:30:59AM +0100, Geert Uytterhoeven wrote:
>> -#if (defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)) || defined(CONFIG_SMP)
>> +#if defined(CONFIG_NUMA) || defined(CONFIG_SMP)
> 
> I'm amused by the thought of CONFIG_NUMA without CONFIG_SMP.
> Is it possible to have one node with memory and a single CPU, then
> another node with memory and no CPU?

More likely 1 with CPU+memory, 1 with memory only.

I've been told that that are also I/O-only nodes.

-- 
~Randy
