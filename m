Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E03C636CD
	for <linux-sh@archiver.kernel.org>; Wed,  1 Feb 2023 14:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjBAOIe (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 1 Feb 2023 09:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjBAOId (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 1 Feb 2023 09:08:33 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADE849968
        for <linux-sh@vger.kernel.org>; Wed,  1 Feb 2023 06:08:31 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 203so11392405pfx.6
        for <linux-sh@vger.kernel.org>; Wed, 01 Feb 2023 06:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z8ihYsabv6FaCkZlvJjrpqfzbw0j+BAuZu4TGOzb3Wc=;
        b=wZr8IXRvFmr1P4okOUsClwu3fvZSrYNl5laSrqV6rhDYXsSFpVJn3aenwvoDtDCMsF
         78aRNpZc7o+Yrk0DTrq3exRArljuq6Bp6eVYQxzoA1/gSFLweevRETG1H3cfaVAT2uyi
         kjqMZSHC5em6IFqDMUIon+3uSzbinAn4/+WTonJdTQHoA4BtwtVQp+gqnN5ifiLjHT2S
         ow4/Px4dY0IQa+SYKjrM2NRv9BvI8Pj9Sn860sozPwgmX4GHk2NYziG+wFWmhyliAtYM
         zc5lwiEJJxt6NehLue8vhjnS1bTjYcHLn5aO2HRlcMCPC6h+VjHcPZOpxBaNU1Gmk7Mn
         7l0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8ihYsabv6FaCkZlvJjrpqfzbw0j+BAuZu4TGOzb3Wc=;
        b=e4qHshX2HCRZV9vFaxvjdUMN9azOeTj29BdHJG0V4dNoNdKJJQpgyn6P6L+7Q2TaNp
         ckixYdoESH49eqIr41fc+BQf3SfzUwI1Pk+WkRrKAErPSZD2emnuMT42Mx1iUbKKwPKi
         0hovDahRDNQjGD2wDMeKsR47mIkvCPx5tXZ36Few3cOUbT4QQH0WT11hD9dqopWzKCp/
         Qrsha5oSG7/K0LEiTvmyiCuxJGZBjDZRvHd2MGoA71HsROhAuLn1WElA17WnwXPSo+TA
         9RN/BMOUvE7QOTcyAv+LtD23qYf/iJPnGpmHN4TtPYP2BLq9XAGfzfjY/9L6Os3XDT7H
         1bvg==
X-Gm-Message-State: AO0yUKUM5KRCVUcL6JrhxMwktEF666hblYU+thlD4ipkF642O10BlWPo
        FlW9OHBUM8FW6eJJ6Fdgqgwzd1bApZoNskoMuiM33w==
X-Google-Smtp-Source: AK7set/hxn7sAfblMpdpMPWHyLNDxBQTxnDdGtDdgs0nJfpnRDUKJhUHAHezrgSwMNAg6vv4MsSFeNhbD/acHeXiqCA=
X-Received: by 2002:aa7:8215:0:b0:593:92e9:991e with SMTP id
 k21-20020aa78215000000b0059392e9991emr610338pfi.43.1675260511059; Wed, 01 Feb
 2023 06:08:31 -0800 (PST)
MIME-Version: 1.0
References: <20230201125642.624255-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230201125642.624255-1-gregkh@linuxfoundation.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 1 Feb 2023 15:08:20 +0100
Message-ID: <CADYN=9LPvuxr6EjQtiGqnT8XA7FvurBmzYjfXz1yxvr+D+TN8w@mail.gmail.com>
Subject: Re: [PATCH] maple: remove unneeded maple_bus_uevent() callback.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, 1 Feb 2023 at 13:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The driver core recently changed the uevent bus callback to take a const
> pointer, and the maple_bus_uevent() was not correctly fixed up.  Instead
> of fixing the function parameter types, just remove the callback
> entirely as it does not do anything, so it is not necessary.
>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: 2a81ada32f0e ("driver core: make struct bus_type.uevent() take a const *")
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thank you for the quick fix.

Tested-by: Anders Roxell <anders.roxell@linaro.org>


Cheers,
Anders

> ---
> sh maintainers, I'll take this through my tree as that's where the
> offending commit is that causes the build breakage.
>
>  drivers/sh/maple/maple.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
> index e24e220e56ee..e05473c5c267 100644
> --- a/drivers/sh/maple/maple.c
> +++ b/drivers/sh/maple/maple.c
> @@ -760,12 +760,6 @@ static int maple_match_bus_driver(struct device *devptr,
>         return 0;
>  }
>
> -static int maple_bus_uevent(struct device *dev,
> -                           struct kobj_uevent_env *env)
> -{
> -       return 0;
> -}
> -
>  static void maple_bus_release(struct device *dev)
>  {
>  }
> @@ -782,7 +776,6 @@ static struct maple_driver maple_unsupported_device = {
>  struct bus_type maple_bus_type = {
>         .name = "maple",
>         .match = maple_match_bus_driver,
> -       .uevent = maple_bus_uevent,
>  };
>  EXPORT_SYMBOL_GPL(maple_bus_type);
>
> --
> 2.39.1
>
