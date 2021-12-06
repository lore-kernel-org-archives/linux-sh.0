Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE77C433EF
	for <linux-sh@archiver.kernel.org>; Mon,  6 Dec 2021 12:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242590AbhLFMEx (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 6 Dec 2021 07:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242675AbhLFMEx (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 6 Dec 2021 07:04:53 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A568EC0613F8
        for <linux-sh@vger.kernel.org>; Mon,  6 Dec 2021 04:01:24 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso13216049otf.12
        for <linux-sh@vger.kernel.org>; Mon, 06 Dec 2021 04:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OLVkuf2VHqBraJN6UKqJW/7pIWk4jCD2gqOAT8Duosw=;
        b=Vh6Q5WDvCjfyr9Q/Kw49rYqcy/UPZCZY5YEmfXwiWvNrGk4VqNfChiPclAfZPQHhDN
         qCZKu+2g84yvnhUhk/i+dm5prq8dBtGhU3jml+YDhbRKV65NZQid1h3UA+6sR4G3t3bU
         M058vxbf1f3zOdhHF4Lr/xPybqpjSkwQ3KvLaI5dipjIP1w0VGg6O7QTA8X5Anq0c30Z
         bdtPPXAz9McLdG832r8qGwGyhIs7t7QBsY0HiIdHK5mQIPB3t45wAjzpaHK8GM4yeWCk
         BJEZU6Xgiw7COGYppK/kcWIp/mZ/JtPul0rm0nPjnYhX1Jg1apc34P+Rz7AcgKu/OtLE
         xmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OLVkuf2VHqBraJN6UKqJW/7pIWk4jCD2gqOAT8Duosw=;
        b=JsOWHzWDbeBIpCxraAlRzDBQPQUdNSYcaOd75+C5oGP+mOlsoqlL7HnYaQhFpZq8BP
         sAl+HKsLCeqn8f9lUXBfdyoDHUPeRsPQjSqSsCgPdGNr8vn8hypJ+c7m0kgjj/6m6W4A
         QW13EvSYQq7UoeEwfVymyizkmoXT7cbMy9MzvveZbZZ9meaIuxO3BoNnmEHxPP/GktMR
         4dpCRQiYF5mjgQ1JrHUm/L+rvMwwbG53hXa/GZb6hAOlpw1Y8IOJedkXTsxKBewAinM1
         P3HnIblurrPyWWW+occKG8dcVfu25tFxV5kHhzG+5Rlh77J670HZTArsvBc4JzIms2o7
         T8ew==
X-Gm-Message-State: AOAM5304zxf6uql7UCR/jzu0qJe/dr4YeS97rufHfRZLFrYyCDC51RRx
        zN7fcJnoWu+xcU7xIAHxNbEd0w==
X-Google-Smtp-Source: ABdhPJzHa/1wotKULJxF+ugrVF/ynN7dBGu2imoZeFzkV1v737ronebjDwExa+7/xQcAn8p0pjhHNQ==
X-Received: by 2002:a9d:4f0e:: with SMTP id d14mr29385451otl.137.1638792083214;
        Mon, 06 Dec 2021 04:01:23 -0800 (PST)
Received: from ?IPv6:2607:fb90:c29e:6304:f48f:7eff:fe87:20e1? ([2607:fb90:c29e:6304:f48f:7eff:fe87:20e1])
        by smtp.gmail.com with ESMTPSA id t11sm2178271otj.24.2021.12.06.04.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 04:01:22 -0800 (PST)
Subject: Re: [PATCH] percpu: km: ensure it is used with NOMMU (either UP or
 SMP)
To:     Dennis Zhou <dennis@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     linux-arch-owner@vger.kernel.org, linux-mm@kvack.org,
        tj@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        npiggin@gmail.com, hch@lst.de, arnd@arndb.de,
        linux-sh@vger.kernel.org, dalias@libc.org,
        linux-riscv@lists.infradead.org
References: <20211130172954.129587-1-vladimir.murzin@arm.com>
 <20211130172954.129587-2-vladimir.murzin@arm.com> <YaZiOnNd6fAnLcxz@fedora>
 <8c2b4666-cf13-3735-be1e-b8a1c71df113@arm.com> <YaqFyznA5hab3PUA@fedora>
From:   Rob Landley <rob@landley.net>
Message-ID: <a2473a90-bdd3-b5af-6967-73c59952b7c1@landley.net>
Date:   Mon, 6 Dec 2021 06:01:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaqFyznA5hab3PUA@fedora>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 12/3/21 3:02 PM, Dennis Zhou wrote:
> On Wed, Dec 01, 2021 at 11:51:04AM +0000, Vladimir Murzin wrote:
>> Hi,
>> 
>> On 11/30/21 5:41 PM, Dennis Zhou wrote:
>> > Hello,
>> > 
>> > On Tue, Nov 30, 2021 at 05:29:54PM +0000, Vladimir Murzin wrote:
>> >> Currently, NOMMU pull km allocator via !SMP dependency because most of
>> >> them are UP, yet for SMP+NOMMU vm allocator gets pulled which:
>> >>
>> >> * may lead to broken build [1]
>> >> * ...or not working runtime due to [2]
>> >>
>> >> It looks like SMP+NOMMU case was overlooked in bbddff054587 ("percpu:
>> >> use percpu allocator on UP too") so restore that.
>> >>
>> >> [1]
>> >> For ARM SMP+NOMMU (R-class cores)
>> >>
>> >> arm-none-linux-gnueabihf-ld: mm/percpu.o: in function `pcpu_post_unmap_tlb_flush':
>> >> mm/percpu-vm.c:188: undefined reference to `flush_tlb_kernel_range'
>> >>
>> >> [2]
>> >> static inline
>> >> int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>> >>                 pgprot_t prot, struct page **pages, unsigned int page_shift)
>> >> {
>> >>        return -EINVAL;
>> >> }
>> >>
>> >> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>> >> ---
>> >>  mm/Kconfig | 3 +--
>> >>  1 file changed, 1 insertion(+), 2 deletions(-)
>> >>
>> >> diff --git a/mm/Kconfig b/mm/Kconfig
>> >> index d16ba92..66331e0 100644
>> >> --- a/mm/Kconfig
>> >> +++ b/mm/Kconfig
>> >> @@ -425,9 +425,8 @@ config THP_SWAP
>> >>  # UP and nommu archs use km based percpu allocator
>> >>  #
>> >>  config NEED_PER_CPU_KM
>> >> -	depends on !SMP
>> >>  	bool
>> >> -	default y
>> >> +	default !SMP || !MMU
>> >>  
>> > 
>> > Should this be `depends on !SMP || !MMU` with default yes? Because with
>> > SMP && MMU, it shouldn't be an option to run with percpu-km.
>> 
>> IIUC these are equivalent, truth table would not change if is under "depends"
>> or "default"
>> 
>> SMP    MMU   NEED_PER_CPU_KM
>>  y      y    !y || !y => n || n => n
>>  y      n    !y || !n => n || y => y
>>  n      y    !n || !y => y || n => y
>>  n      n    !n || !n => y || y => y
>> 
> 
> I may be wrong, but I think this is slightly different as we're using
> #ifdef / #if defined().
> 
>> > 
>> >>  config CLEANCACHE
>> >>  	bool "Enable cleancache driver to cache clean pages if tmem is present"
>> >> -- 
>> >> 2.7.4
>> >>
>> > 
>> > It's interesting to me that this is all coming up at once. Earlier this
>> > month I had the same conversation with people involved with sh [1].
>> > 
>> > [1] https://lore.kernel.org/linux-sh/YY7tp5attRyK42Zk@fedora/
>> > 
>> > I can pull this shortly once I see whatever happened to linux-sh.
>> 
>> Ahh, good to know! Adding SH folks here (start of discussion [0]). I see you came
>> to the same conclusion, right? 
> 
> Yeah, I don't see anything else from linux-sh. So I'll go ahead and
> apply this with my change if you're fine with that.

I can't test against current until I get some unrelated fixes from Rich Felker
(who's been busy over the weekend), but I tested the "depends" version on 5.10
and got a shell prompt on my "make ARCH=sh j2_defconfig" board.

Tested-by: Rob Landley <rob@landley.net>

Rob
