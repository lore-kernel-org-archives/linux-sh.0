Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5388DC433F5
	for <linux-sh@archiver.kernel.org>; Wed,  5 Jan 2022 17:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242477AbiAERox (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242475AbiAERox (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 5 Jan 2022 12:44:53 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE29C0611FD
        for <linux-sh@vger.kernel.org>; Wed,  5 Jan 2022 09:44:53 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id s127so46321oig.2
        for <linux-sh@vger.kernel.org>; Wed, 05 Jan 2022 09:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CYkxlfgv45mqTZADc0Kifg55ygD2FGzQIL6sFuK7qLc=;
        b=8J5Y+EYV/p4WRjI6UeE/U4rLd23xUQXQHMxZY2dziV7p38HniCS9/GD8MOzZYADJmz
         I3Fzy/ruyj7TX1FJatMP8LTuIZfHcybsP/rSeCImRdtGbhgA3ZHHfXO+3lSoBbOag8bE
         6XPYJzrj9hZjCii9MsycFuW5OtVvEwZEOJgT3erMsuhVkpu9inH2AZNZkHTwwNT9J7kI
         cKE8HGcjzB9JThX0V4wIVdy+XR5IHaw16QF2RjsSTLuVASD2aLWtWS/ETGpbl+K2xoAb
         49Az626oI52/jENAeGZckV6JiCSsIYom9bbK7rqoFqKuFbZnuA2Pyuz6z98Hb1TGYPOQ
         pF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CYkxlfgv45mqTZADc0Kifg55ygD2FGzQIL6sFuK7qLc=;
        b=xz9REhfXeMswgNLUrdg5c/nMG8ET1Ynwivs8w//6c4uogGqXSZ4LHawbtEOSog7oSK
         PUYCCIks1GYWYrVbPpbJjFkHaCVhSSfSQqK7TfHlbBuNtK53rO0uPxHZq4nJwdGupwSQ
         +4QQmz7UAFTqS+Ch0a+OniLM6udxPeSmSegG2DVL0R8r6bXYkcgdMCvUatn27kFualvD
         j0DsuGz+GTzK/yJ+e3TjUqXjgqj48ta3+ZrLYblbBVnNL/+5w63cX1QJNrgfUTgPGZ3A
         lgc4PhoGRz1HScNbcdC7rxOwqlScZd1E+1nf5dTZmAlqMZh1ZzQd1KcaEIFwWrKDYO49
         3EmA==
X-Gm-Message-State: AOAM530RKMLvIqzISJeek3z9LARyfIPfyHY4XZtuk9pi7l2f612whg0E
        RQYZFFBo6COAjs9OO8dYQKabtMU9PPFSVQ==
X-Google-Smtp-Source: ABdhPJw7Vo+HXAvCcuQGUd58gCnDJV8yHSr52quHXZxS8lB1Hnf5ir7hrJCS9RaR54CbAbIfZFdKLA==
X-Received: by 2002:aca:4b49:: with SMTP id y70mr460547oia.41.1641404692516;
        Wed, 05 Jan 2022 09:44:52 -0800 (PST)
Received: from [192.168.86.166] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id g2sm255418oos.47.2022.01.05.09.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 09:44:52 -0800 (PST)
Subject: Re: [PATCH] sh: sq: use default_groups in kobj_type
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
References: <20220104162240.1309639-1-gregkh@linuxfoundation.org>
From:   Rob Landley <rob@landley.net>
Message-ID: <4622e641-1423-e72a-4f6d-5f2cc747a148@landley.net>
Date:   Wed, 5 Jan 2022 11:46:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104162240.1309639-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 1/4/22 10:22 AM, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the sh sq sysfs code to use default_groups field which has
> been the preferred way since aa30f47cf666 ("kobject: Add support for
> default attribute groups to kobj_type") so that we can soon get rid of
> the obsolete default_attrs field.

Let's see, sh4-specific, depends on CONFIG_SH_STORE_QUEUES... it built but I'm
not finding an "sq" entry under /proc. (Or anything with "mapping" in it...)

Oh well, probably right? Didn't break anything for me:

Tested-by: Rob Landley <rob@landley.net>

Rob
