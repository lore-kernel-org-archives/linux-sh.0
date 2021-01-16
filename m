Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138D3C433DB
	for <linux-sh@archiver.kernel.org>; Sat, 16 Jan 2021 06:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F9B23A55
	for <linux-sh@archiver.kernel.org>; Sat, 16 Jan 2021 06:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbhAPGmf (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 16 Jan 2021 01:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbhAPGme (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 16 Jan 2021 01:42:34 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC06C061794
        for <linux-sh@vger.kernel.org>; Fri, 15 Jan 2021 22:41:53 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id b24so10921367otj.0
        for <linux-sh@vger.kernel.org>; Fri, 15 Jan 2021 22:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=p4Nk3AilftG5ExBAGS6bfQpd59rxlKgXfcFq9DUpCjk=;
        b=pAanG4QYLVdqHA7d+KTehzpGBsRMb6s5xhzHsfq8B71fiian/mBZm5+o6sFXindpzA
         obvIa6SQAsXJZslpsW+FcDB1J4xC+3vxh49OAqdbRpiJwLlTLsx5TNuJqfRI33kBXAy0
         NvlUVqccvWJAmnbAyEBY7wi5WvONiihiwHLddVQn6Q2S9/ZI3s3z4/9uDjgJ2LOVmKeg
         Qo6CgKsFjI63dVfKO7Jx+faEpvvxOslSKTe0XTxheT0fwP0fKRDhAgPHyakgW1/l8TNe
         lEGwySnVRS3HCMGMvWMf8TLaeEwxDK+cMvNKVV57oVPUjre8xuOLdvn6TapS+F2yG55p
         5ZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=p4Nk3AilftG5ExBAGS6bfQpd59rxlKgXfcFq9DUpCjk=;
        b=BSON2pA6fejDUyDE1B8GeIJ4WgyG11/YktIBpidTEmupUX5bMHiGUUlbGh/tTn0zwY
         muap+u5jPYh0G/DMwBVFgFvvODH+fv5zFFU3Mee1qHvr2gm6Hiue78hx8QZxLBU+jcyR
         4oTsCShghmYl3wmDEuAI2VCLdpBHIplHP7+vUyWxqu4zJlwrvSM2OeUD8eHQqWst/DFH
         A+T5za9Pr1jgEcEOPMIVBa+HqkziuxkE+vr3QWL7NaD28Fd6XCe1vHyxqw+lCPcziQuy
         AgDJtJu+oH/L6g3AhoeHQu87hcQ13SQgw6Ks8Ff2OVXJpsxzNKh+u8vY2/SrGVabM5Rw
         oZsg==
X-Gm-Message-State: AOAM532nLvyw+OjVPWyR2DJdJVT7N9ue8pfVjjPApVBqierD4NPGOfLi
        hfO8WVjRMqDca/0CaA8ERhuGgMSiadw1Lg==
X-Google-Smtp-Source: ABdhPJyEsrxB0txbEUm6UqJKCpoLJBj/DEeFhI7BLALCwtVBrucFzbF8T55c4WgnHJrajqbLR2geyQ==
X-Received: by 2002:a9d:d10:: with SMTP id 16mr11464306oti.101.1610779312992;
        Fri, 15 Jan 2021 22:41:52 -0800 (PST)
Received: from ?IPv6:2607:fb90:e6af:5dea:6680:99ff:fe6f:cb54? ([2607:fb90:e6af:5dea:6680:99ff:fe6f:cb54])
        by smtp.gmail.com with ESMTPSA id c14sm2337402otp.19.2021.01.15.22.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 22:41:51 -0800 (PST)
Subject: Re: Old platforms never die, was Re: Old platforms: bring out your
 dead
To:     Finn Thain <fthain@telegraphics.com.au>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Gerhard Pircher <gerhard_pircher@gmx.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net>
 <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
 <alpine.LNX.2.23.453.2101131035500.6@nippy.intranet>
From:   Rob Landley <rob@landley.net>
Message-ID: <897dbd50-ce42-8fdb-8777-fab08185e324@landley.net>
Date:   Sat, 16 Jan 2021 00:54:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.23.453.2101131035500.6@nippy.intranet>
Content-Type: multipart/mixed;
 boundary="------------14B6DC6FBF1B2EFA5CB0B019"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------14B6DC6FBF1B2EFA5CB0B019
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 1/12/21 6:12 PM, Finn Thain wrote:
> If you're a museum interested in cultural artifacts from decades past, or 
> if you're a business doing data recovery, you're going to need to operate 
> those platforms.

Or if you're camping patent expirations and want to be able to point at prior
art for new hardware development WITHOUT a legal team big enough to have its own
office building.

> Once removed from mainline Linux, a port becomes basically frozen, and may 
> not be compatible with future emulators, which are a moving target. I say 
> that because last year I fixed bugs in Linux/m68k that made it incomatible 
> with recent QEMU releases (it was only compatible with old QEMU releases).

Speaking of which, my qemu m68k system has failed to boot ever since commit:

commit f93bfeb55255bddaa16597e187a99ae6131b964a
Author: Finn Thain <fthain@telegraphics.com.au>
Date:   Sun Jun 28 14:23:12 2020 +1000

    macintosh/via-macii: Poll the device most likely to respond

    Poll the most recently polled device by default, rather than the lowest
    device address that happens to be enabled in autopoll_devs. This improves
    input latency. Re-use macii_queue_poll() rather than duplicate that logic.
    This eliminates a static struct and function.

It hangs in a cpu-eating loop after "random: crng init done". Miniconfig
attached, the qemu invocation is:

qemu-system-m68k -M q800 -nographic -no-reboot -m 256 -kernel vmlinux \
  -initrd cpio.gz -append "panic=1 HOST=m68k console=ttyS0

Rob

P.S. This is the toybox "make root" m68k target from
https://github.com/landley/toybox/blob/master/scripts/mkroot.sh#L171 if that's
useful to know. It doesn't get to the root filesystem and the build just creates
that miniconfig and runs it as the comments say...

--------------14B6DC6FBF1B2EFA5CB0B019
Content-Type: text/plain; charset=UTF-8;
 name="miniconfig-m68k"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="miniconfig-m68k"

IyBtYWtlIEFSQ0g9bTY4ayBhbGxub2NvbmZpZyBLQ09ORklHX0FMTENPTkZJRz1tNjhrLm1p
bmljb25mCiMgbWFrZSBBUkNIPW02OGsgLWogJChucHJvYykKIyBib290IHZtbGludXgKCgoj
IENPTkZJR19FTUJFRERFRCBpcyBub3Qgc2V0CiMgYXJjaGl0ZWN0dXJlIGluZGVwZW5kZW50
CkNPTkZJR19CSU5GTVRfRUxGPXkKQ09ORklHX0JJTkZNVF9TQ1JJUFQ9eQpDT05GSUdfTk9f
SFo9eQpDT05GSUdfSElHSF9SRVNfVElNRVJTPXkKQ09ORklHX0JMS19ERVY9eQpDT05GSUdf
QkxLX0RFVl9JTklUUkQ9eQpDT05GSUdfUkRfR1pJUD15CkNPTkZJR19CTEtfREVWX0xPT1A9
eQpDT05GSUdfRVhUNF9GUz15CkNPTkZJR19FWFQ0X1VTRV9GT1JfRVhUMj15CkNPTkZJR19W
RkFUX0ZTPXkKQ09ORklHX0ZBVF9ERUZBVUxUX1VURjg9eQpDT05GSUdfTUlTQ19GSUxFU1lT
VEVNUz15CkNPTkZJR19TUVVBU0hGUz15CkNPTkZJR19TUVVBU0hGU19YQVRUUj15CkNPTkZJ
R19TUVVBU0hGU19aTElCPXkKQ09ORklHX0RFVlRNUEZTPXkKQ09ORklHX0RFVlRNUEZTX01P
VU5UPXkKQ09ORklHX1RNUEZTPXkKQ09ORklHX1RNUEZTX1BPU0lYX0FDTD15CkNPTkZJR19O
RVQ9eQpDT05GSUdfUEFDS0VUPXkKQ09ORklHX1VOSVg9eQpDT05GSUdfSU5FVD15CkNPTkZJ
R19JUFY2PXkKQ09ORklHX05FVERFVklDRVM9eQpDT05GSUdfTkVUX0NPUkU9eQpDT05GSUdf
TkVUQ09OU09MRT15CkNPTkZJR19FVEhFUk5FVD15CkNPTkZJR19DT01QQVRfMzJCSVRfVElN
RT15CkNPTkZJR19FQVJMWV9QUklOVEs9eQpDT05GSUdfSUtDT05GSUc9eQpDT05GSUdfSUtD
T05GSUdfUFJPQz15CgojIGFyY2hpdGVjdHVyZSBzcGVjaWZpYwpDT05GSUdfTU1VPXkKQ09O
RklHX002ODA0MD15CkNPTkZJR19NNjhLRlBVX0VNVT15CkNPTkZJR19NQUM9eQpDT05GSUdf
U0NTSV9NQUNfRVNQPXkKQ09ORklHX01BQ0lOVE9TSF9EUklWRVJTPXkKQ09ORklHX0FEQj15
CkNPTkZJR19BREJfTUFDSUk9eQpDT05GSUdfTkVUX0NPUkU9eQpDT05GSUdfTUFDU09OSUM9
eQpDT05GSUdfU0VSSUFMX1BNQUNaSUxPRz15CkNPTkZJR19TRVJJQUxfUE1BQ1pJTE9HX1RU
WVM9eQpDT05GSUdfU0VSSUFMX1BNQUNaSUxPR19DT05TT0xFPXkKCgo=
--------------14B6DC6FBF1B2EFA5CB0B019--
