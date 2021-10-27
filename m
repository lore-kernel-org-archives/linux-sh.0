Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B504C433EF
	for <linux-sh@archiver.kernel.org>; Wed, 27 Oct 2021 12:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7188A6103C
	for <linux-sh@archiver.kernel.org>; Wed, 27 Oct 2021 12:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbhJ0MEL (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232956AbhJ0MEK (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Wed, 27 Oct 2021 08:04:10 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D299B60F70;
        Wed, 27 Oct 2021 12:01:44 +0000 (UTC)
Date:   Wed, 27 Oct 2021 08:01:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>
Subject: Re: [for-next][PATCH 10/12] ftrace/sh: Add
 arch_ftrace_ops_list_func stub to have compressed image still link
Message-ID: <20211027080143.1e7555dc@gandalf.local.home>
In-Reply-To: <95ac8344-ff8c-d66f-00c7-06c43a61fca3@omp.ru>
References: <20211026162315.297389528@goodmis.org>
        <20211026162349.204017174@goodmis.org>
        <95ac8344-ff8c-d66f-00c7-06c43a61fca3@omp.ru>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, 27 Oct 2021 11:58:31 +0300
Sergey Shtylyov <s.shtylyov@omp.ru> wrote:

> > From: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>  
> 
>     Collective author, really? :-)

Yeah, Stephen already pointed this that the author didn't have a
"signed-off-by", when in reality my patchwork (which I send my own patches
through) somehow add that as the author and not me :-p

-- Steve
