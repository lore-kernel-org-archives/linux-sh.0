Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C333C433F5
	for <linux-sh@archiver.kernel.org>; Fri, 22 Oct 2021 02:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C0C61390
	for <linux-sh@archiver.kernel.org>; Fri, 22 Oct 2021 02:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhJVCSs (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 21 Oct 2021 22:18:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232411AbhJVCSr (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Thu, 21 Oct 2021 22:18:47 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EE5F6138D;
        Fri, 22 Oct 2021 02:16:29 +0000 (UTC)
Date:   Thu, 21 Oct 2021 22:16:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH] ftrace/sh: Add arch_ftrace_ops_list_func stub to have
 compressed image still link
Message-ID: <20211021221627.5d7270de@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

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

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
This is based on my tree at:
  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
  branch: ftrace/core
  I can push this change through my tree with the SuperH maintainer's acks.

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
 

