Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DB5C433F5
	for <linux-sh@archiver.kernel.org>; Tue, 26 Oct 2021 16:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD1160EB9
	for <linux-sh@archiver.kernel.org>; Tue, 26 Oct 2021 16:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbhJZQ0P (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 26 Oct 2021 12:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234647AbhJZQ0O (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Tue, 26 Oct 2021 12:26:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BC74610E6;
        Tue, 26 Oct 2021 16:23:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mfPEr-000qSt-By;
        Tue, 26 Oct 2021 12:23:49 -0400
Message-ID: <20211026162349.204017174@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 26 Oct 2021 12:23:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [for-next][PATCH 10/12] ftrace/sh: Add arch_ftrace_ops_list_func stub to have compressed
 image still link
References: <20211026162315.297389528@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

From: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Using the linker script to fix an issue where some archs call the
function tracer with just the ip (instruction pointer) and pip (parent
instruction pointer) where as more up to date archs also pass in the
associated ftrace_ops and the ftrace_regs pointer, the generic code
will be called either with two parameters or four. To avoid any C
undefined behavior of calling two parameters to four or four to two
parameter function, two functions are created, where a preprocessor
macro uses the one that matches the architecture. As the function
pointers for them may be different, a typecast is used. But this
triggers issues with newer compilers that will fail due to -Werror.

A linker trick is now used to map the generic function to the function
that is used (note the generic function is only used to set the default
function callback). The linker trick defines ftrace_ops_list_func (the
generic function) to arch_ftrace_ops_list_func (the arch defined one).

Link: https://lore.kernel.org/all/20200617165616.52241bde@oasis.local.home/

But this fails sh arch because their linker script is included in their
compressed image that does not define arch_ftrace_ops_list_func at all

  sh4-linux-ld:arch/sh/boot/compressed/../../kernel/vmlinux.lds:32: undefined symbol `arch_ftrace_ops_list_func' referenced in expression

Included a stub by that name in the misc.c to allow the code to
compile and link, even though it's not used.

This is similar to what was done for ftrace_stub:

  b83b43ffc6e4b ("fgraph: Fix function type mismatches of
  ftrace_graph_return using ftrace_stub")

Link: https://lkml.kernel.org/r/20211021221627.5d7270de@rorschach.local.home

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/sh/boot/compressed/misc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/misc.c
index a03b6680a9d9..ca05c99a3d5b 100644
--- a/arch/sh/boot/compressed/misc.c
+++ b/arch/sh/boot/compressed/misc.c
@@ -115,6 +115,9 @@ void __stack_chk_fail(void)
 void ftrace_stub(void)
 {
 }
+void arch_ftrace_ops_list_func(void)
+{
+}
 
 #define stackalign	4
 
-- 
2.33.0
