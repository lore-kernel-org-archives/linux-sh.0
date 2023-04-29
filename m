Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2233BC77B7C
	for <linux-sh@archiver.kernel.org>; Sat, 29 Apr 2023 20:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjD2UU4 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 29 Apr 2023 16:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjD2UUz (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 29 Apr 2023 16:20:55 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158F6198A
        for <linux-sh@vger.kernel.org>; Sat, 29 Apr 2023 13:20:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2496863c2c7so1176685a91.1
        for <linux-sh@vger.kernel.org>; Sat, 29 Apr 2023 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682799653; x=1685391653;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eT6Iosx0mXfdelnB+/awy2djLbdEQHSWYwF0l6D7UZk=;
        b=ECOq4apJvbMRfpWybGzzN8N3SQxb+4g3QZ5Ja3lycK6jef0tEat0EPoSm+c5Rl2HQZ
         7M/5vLkgGavbRBNI/Iph1n9oWKXV68c0zRBv/DfNjXL/GpZpy4RmZH/Zl8PQf9bLz8zn
         y6NfIlL5q35D9/JLi7IjUhXukABkG0GPFnHJJPnMg1xpwv0WoRV0MMF09L5WXl1w+pWw
         /8g3OdFZFtvkTkm+joMcc37KH8hz1dNB+hEouJPjOTUVnwoyr2TioClxNWGF2oGtwwn9
         AtCq5qiqM4UMvf9nLwYlqV5rLwkB/9B2nY6FVam34vPR+78+zno8EG0Oblwjci0k1lsv
         ip5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799653; x=1685391653;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT6Iosx0mXfdelnB+/awy2djLbdEQHSWYwF0l6D7UZk=;
        b=kgjTlc8cHT8xWO+DEif15Qv19EZyP2cnEswLV37D+DUgtip9ma7NTHcELW6zcI0BjM
         OGh5Khfr4mMoE7vb7+QQDCKMLsdY9yDsIfcYN5q9ZF19b9okvXICSMPllMWGnwabWndx
         nInb+rzDYvzhmHWHTZwGYM/WEC5i9hISH6rSJ1evUgs3iyrd1mdSDKfWE7cFtQrnyzeU
         OgJvhZL1vTlbBKZ5vWpQiXk9yPMA8KrurRbY+ULkF6DtBP+AKY38rO4CYbJd6/+SmemR
         QStViDNyPFS41v0q1/27Ti4mWXFLrSDRn69lEZ6AFnq6jbzd4AGfP+QlNu328zRVaXxg
         Xnpw==
X-Gm-Message-State: AC+VfDzXrFbpvLQYe/6kHqovfHDgQqDSaPG8/77Jx/ahCFismxkRx+Bt
        6uDLMB/XFX5Zg6CSpoKikRUkpQ==
X-Google-Smtp-Source: ACHHUZ5WOI/1aioBsqwebacxzZ9ZdQY0r+MMnoJ8pEVhZBGss1o6w2KghYZKaT+eG3K6P9EOLAdM9w==
X-Received: by 2002:a17:902:cece:b0:1aa:e451:e22 with SMTP id d14-20020a170902cece00b001aae4510e22mr1575813plg.40.1682799653446;
        Sat, 29 Apr 2023 13:20:53 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902a50d00b001a64ce7b18dsm15229418plq.165.2023.04.29.13.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:52 -0700 (PDT)
Date:   Sat, 29 Apr 2023 13:20:52 -0700 (PDT)
X-Google-Original-Date: Sat, 29 Apr 2023 13:20:35 PDT (-0700)
Subject:     Re: [PATCH] libgcc: Add forward declarations for generic library routines
In-Reply-To: <74a647f7-cf5f-4c23-aad6-77bf5b04e116@app.fastmail.com>
CC:     geert+renesas@glider.be, akpm@linux-foundation.org,
        linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, chris@zankel.net, jcmvbkbc@gmail.com,
        lkp@intel.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-8d0e378d-10f7-4107-99aa-b204c3d2a619@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Fri, 21 Apr 2023 13:38:52 PDT (-0700), Arnd Bergmann wrote:
> On Fri, Apr 21, 2023, at 16:54, Geert Uytterhoeven wrote:
>> With W=1 on platforms that use the generic gcc library routines
>> (csky/loongarch/mips/riscv/sh/xtensa):
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: https://lore.kernel.org/oe-kbuild-all/202303272214.RxzpA6bP-lkp@intel.com/
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Nice, this is one I don't have in my series,
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> I have patches for a lot of other missing prototype warnings, plan
> to send them out after -rc1.

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

I think I've merged some stuff around here before, but it's probably 
better for some more generic tree?  LMK if you guys wanted me to pick 
these up, though, I've got a smattering of small stuff already so I'll 
have another PR either way.
