Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E92C433F5
	for <linux-sh@archiver.kernel.org>; Thu,  7 Oct 2021 02:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AAF61248
	for <linux-sh@archiver.kernel.org>; Thu,  7 Oct 2021 02:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhJGC1E (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 6 Oct 2021 22:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhJGC1D (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 6 Oct 2021 22:27:03 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC0EC061746;
        Wed,  6 Oct 2021 19:25:09 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 75so4217273pga.3;
        Wed, 06 Oct 2021 19:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6Fbp2oLqg5VLyJhPP2UoprEyUpjt3vE+k1k8NDwLMpk=;
        b=fVpVXChAwZh74Yak5ikdgyaoheURY4K/ccbznO6zTnIB1AbJR+bIgOAW5/cSxWFoOZ
         cY0eBdVYRQP1/jK52zezVr0uzpqaKqL4UT7RQvBZyhmKIcoiByFnE72l/T/lAzTh60PX
         2ZZ2YfXaMMnXi99HoWBLG5uUJUaMAp+mwPmSs0A9L0wSZq5MBqIGrLe/fQpBMPOxvPnK
         4rfWTUo7RKXBeIwus/mUrNTfwOqbla5PIcLbJRJuwd6IvqLGvZcPe9NmM60QdmCBRqmR
         sMF0mjWUQFOWNx2GTwfCL5Ktgovulw8+KnJ+87QvW6vVfTE6IVfRZKsoah2Gd8VJ0NWK
         +Eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6Fbp2oLqg5VLyJhPP2UoprEyUpjt3vE+k1k8NDwLMpk=;
        b=dgs77bupENCFjzUry8FnJvPNsP97YcOzSZBsySEOKWw75LM8zIM4p5yU6bz3akj8X+
         aKXVx74urTu+PtXpFAkkAhu9YJVp1paZ67os9LnhPveV5wUOI13m5G23KCFEdb9YPx42
         y/B9dllFz4zv6V+wAADgIA+y8SMtDgVDWnQara2V5C4H36KtwpX9Af+Mzspcr743hfqX
         lTEEXz5sIvsuI2iX2eArq0+xUDjA7O9QtJXj7XLt4/nBz9awADhajyMPjlROGuiyOG7o
         OPNAopWnR334KM2HyoJeghXDQ4LjGci4IkuYWxCx3eCL/LKx30a7vcWO50954pr/0sIO
         BeIA==
X-Gm-Message-State: AOAM533TzoTodtjpZGHABOIJbcSEVHmd1zGVsts71IusFZ+099ywy3EN
        a20eHAZlDuFtYl/gv49F1JU=
X-Google-Smtp-Source: ABdhPJys1HdOqewyun+C+iToAvx9hnErbBSMfwtBGQraooU+JJaijDbgzG5Y0UhUonum+9KpDmz8JA==
X-Received: by 2002:a63:ed4a:: with SMTP id m10mr1303051pgk.448.1633573509317;
        Wed, 06 Oct 2021 19:25:09 -0700 (PDT)
Received: from [10.230.29.137] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g23sm22285369pfu.71.2021.10.06.19.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 19:25:08 -0700 (PDT)
Message-ID: <1a15bbef-cf3d-33c6-b6c1-3dd607d71d1d@gmail.com>
Date:   Wed, 6 Oct 2021 19:24:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 00/12] DT: CPU h/w id parsing clean-ups and cacheinfo id
 support
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, devicetree@vger.kernel.org
References: <20211006164332.1981454-1-robh@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211006164332.1981454-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org



On 10/6/2021 9:43 AM, Rob Herring wrote:
> The first 10 patches add a new function, of_get_cpu_hwid(), which parses
> CPU DT node 'reg' property, and then use it to replace all the open
> coded versions of parsing CPU node 'reg' properties.
> 
> The last 2 patches add support for populating the cacheinfo 'id' on DT
> platforms. The minimum associated CPU hwid is used for the id. The id is
> optional, but necessary for resctrl which is being adapted for Arm MPAM.
> 
> Tested on arm64. Compile tested on arm, x86 and powerpc.

On ARM and ARM64:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

lscpu -C continues to work on ARM64 as before with cache properties 
provided in the FDT.
-- 
Florian
