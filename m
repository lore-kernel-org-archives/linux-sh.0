Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AFBC433ED
	for <linux-sh@archiver.kernel.org>; Fri,  9 Apr 2021 03:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3CF6610CF
	for <linux-sh@archiver.kernel.org>; Fri,  9 Apr 2021 03:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhDIDJl (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 8 Apr 2021 23:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbhDIDJe (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 8 Apr 2021 23:09:34 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE60C061760
        for <linux-sh@vger.kernel.org>; Thu,  8 Apr 2021 20:09:22 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id i190so3267416pfc.12
        for <linux-sh@vger.kernel.org>; Thu, 08 Apr 2021 20:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p6V7kMAr/qfNsP2NpJNwSvSLsZ0EwZ6E9deTk98f6UM=;
        b=FqMTU93Mb4VBYmWBa2xwQCeJSoQRjSTY0KwqA8yKLBzbU80L4YLdxutfRcXzPWwQ85
         4VnipuSuKCOjQyzBJR/sofD/eWTYEq0xJzfqojfCVDV09IfYbdrU53yuUlDkInGAcBnC
         RSckyjdC9LYXRL671NZRN0jiv/64YKKar5RHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p6V7kMAr/qfNsP2NpJNwSvSLsZ0EwZ6E9deTk98f6UM=;
        b=h/B2ZPcV6TsHWWbCy3+8Yw70c1AgkvE5HNZX8jmBcqT0o9cGK/CyyxcC+gaumtMWbI
         r7nDH8jHiVxbtBaCk7/KkP0aV6FrSj1Exdnat56u8nz8pSUg+EQxbWk/yxAZXlB8mzG4
         ZKNQFzFFrLkd0bbAiEDd2yzltQ21xKtvpNLmPIbmSNHdrBwZYzGhQZ6Kj+hybdWjXYoW
         JkZxezZ+aKqC9DmHAt4o3IS2FuqCR7FeDDmhhjlvRJ9mJFcpLaHF4eURz2R/lrkCs5Js
         9Y0ij4P1zmB3QOyII1HRBaI+hq8IWKA65O/Sf3Rsz5O285i+cifh+tmGLyhCVuYb13Fz
         G50A==
X-Gm-Message-State: AOAM532c48xXSPGFpS0Fspu3pNzeBtaH+CyhsEPtlgNfi3uEQ/ZLPfKI
        ysxinh0khvyoPAfS5XtAexScDw==
X-Google-Smtp-Source: ABdhPJzk7Zl0O1lLvoWl18AE7wqoq81kr634C0TdGiP11qwod4pzWNf2ghvh6pnXAELrMZto7M9jVw==
X-Received: by 2002:a65:48c5:: with SMTP id o5mr10975475pgs.101.1617937761659;
        Thu, 08 Apr 2021 20:09:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i7sm649034pgq.16.2021.04.08.20.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:09:21 -0700 (PDT)
Date:   Thu, 8 Apr 2021 20:09:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH 18/20] kbuild: sh: remove unused install script
Message-ID: <202104082009.D5774EDC4@keescook>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <20210407053419.449796-19-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407053419.449796-19-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, Apr 07, 2021 at 07:34:17AM +0200, Greg Kroah-Hartman wrote:
> The sh arch has a install.sh script, but no Makefile actually calls it.
> Remove it to keep anyone from accidentally calling it in the future.
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
