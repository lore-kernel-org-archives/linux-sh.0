Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F2AC77B73
	for <linux-sh@archiver.kernel.org>; Tue, 30 May 2023 23:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbjE3XVe (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 30 May 2023 19:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbjE3XV1 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 30 May 2023 19:21:27 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E7D125
        for <linux-sh@vger.kernel.org>; Tue, 30 May 2023 16:21:11 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d4e4598f0so5680422b3a.2
        for <linux-sh@vger.kernel.org>; Tue, 30 May 2023 16:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488870; x=1688080870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gIVpjYFpxwY477D2q1tutyOoTXMzxG7tr6AvT0HGlgY=;
        b=jfJiBNZwCDcW0t1O+xpF1c2xToCW30Jz8zQaXHjwZTgxTyHxTvlnRlMS3kur7yVxTA
         MsGbc5Qg4jcc/wQHtewCT2WVDNSWx/XTbsvHXOHEpPVSBRVT851fe+vdKO2aLUcmV191
         eVdHck1oPB9Sm8/aZ10Xbe5SlbzQ2OUph9T3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488870; x=1688080870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIVpjYFpxwY477D2q1tutyOoTXMzxG7tr6AvT0HGlgY=;
        b=MrFpSpSOrQyaa4p4URCGKMvxuzaoGrOLmZC7Uof0mCSQXzXHOoPtVZXuTr0Iz8xDuM
         Iu1nQSva3PPXJJIjlN9B0dndzYz4HHUIbMA2sHhpLmEo9Fb9cTevXpIMauNOfPV0lnsc
         nbf3QwxVz/18pbbq/ucpxdN14N6AA/tClcizpXE5ge7TnVWij55bq83G2gEt3LAFHzpl
         02HUeh4MjrpHwJ37shxW7Lhb4za5cOCMUTcz5g/ei3a1fcK4e6n4CU5AT6KyUALR9oxy
         F7PafG+J1o8KbbKPQFFA2etSEVMyqBY1N8A1AyTZZhJo30QrD8cmni9zUHRaPI5F05IE
         6ASg==
X-Gm-Message-State: AC+VfDyGtLAUCQS6+yZCG5cXGyfrQhzpjpHFbZIA5K6Sis3X3IWdpVQ/
        zLqN9bqhhUd+yQ8lfNl5Wr8Uwg==
X-Google-Smtp-Source: ACHHUZ6a+iF8gO/7GTzwZBy4xcNB/leKn4ifXZOxeku9fKFIvdV+PoDEP3zi2aNr6sORHNSh/5I1Wg==
X-Received: by 2002:a05:6a00:a13:b0:64d:7162:9cf0 with SMTP id p19-20020a056a000a1300b0064d71629cf0mr4792726pfh.8.1685488870577;
        Tue, 30 May 2023 16:21:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c5-20020aa781c5000000b006439df7ed5fsm2184661pfn.6.2023.05.30.16.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:21:10 -0700 (PDT)
Date:   Tue, 30 May 2023 16:21:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-hardening@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] sh: Replace all non-returning strlcpy with strscpy
Message-ID: <202305301621.BD4A8EA78F@keescook>
References: <20230530163041.985456-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530163041.985456-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, May 30, 2023 at 04:30:41PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
