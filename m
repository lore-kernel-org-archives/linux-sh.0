Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161A5C4332F
	for <linux-sh@archiver.kernel.org>; Wed, 27 Oct 2021 08:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01DB61040
	for <linux-sh@archiver.kernel.org>; Wed, 27 Oct 2021 08:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241128AbhJ0JBF (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 27 Oct 2021 05:01:05 -0400
Received: from mxout01.lancloud.ru ([45.84.86.81]:46980 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241123AbhJ0JBE (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 27 Oct 2021 05:01:04 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru B793F20DE16B
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <95ac8344-ff8c-d66f-00c7-06c43a61fca3@omp.ru>
Date:   Wed, 27 Oct 2021 11:58:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [for-next][PATCH 10/12] ftrace/sh: Add arch_ftrace_ops_list_func
 stub to have compressed image still link
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>
References: <20211026162315.297389528@goodmis.org>
 <20211026162349.204017174@goodmis.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211026162349.204017174@goodmis.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 26.10.2021 19:23, Steven Rostedt wrote:

> From: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

    Collective author, really? :-)

> Using the linker script to fix an issue where some archs call the
> function tracer with just the ip (instruction pointer) and pip (parent
> instruction pointer) where as more up to date archs also pass in the
> associated ftrace_ops and the ftrace_regs pointer, the generic code
> will be called either with two parameters or four. To avoid any C
> undefined behavior of calling two parameters to four or four to two
> parameter function, two functions are created, where a preprocessor
> macro uses the one that matches the architecture. As the function
> pointers for them may be different, a typecast is used. But this
> triggers issues with newer compilers that will fail due to -Werror.
> 
> A linker trick is now used to map the generic function to the function
> that is used (note the generic function is only used to set the default
> function callback). The linker trick defines ftrace_ops_list_func (the
> generic function) to arch_ftrace_ops_list_func (the arch defined one).
> 
> Link: https://lore.kernel.org/all/20200617165616.52241bde@oasis.local.home/
> 
> But this fails sh arch because their linker script is included in their
> compressed image that does not define arch_ftrace_ops_list_func at all
> 
>    sh4-linux-ld:arch/sh/boot/compressed/../../kernel/vmlinux.lds:32: undefined symbol `arch_ftrace_ops_list_func' referenced in expression
> 
> Included a stub by that name in the misc.c to allow the code to
> compile and link, even though it's not used.
> 
> This is similar to what was done for ftrace_stub:
> 
>    b83b43ffc6e4b ("fgraph: Fix function type mismatches of
>    ftrace_graph_return using ftrace_stub")
> 
> Link: https://lkml.kernel.org/r/20211021221627.5d7270de@rorschach.local.home
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[...]

MBR, Sergey
