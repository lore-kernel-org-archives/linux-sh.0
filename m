From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 29 Jan 2008 00:49:56 +0000
Subject: Re: Hi all, how could I check if my compiler use fpu instruction?
Message-Id: <20080129004956.GC9937@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <200801282208.08210.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <200801282208.08210.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It is incredibly difficult to reply to your mail when you insist on
putting the body of your text in the subject line. Please use a more
meaningful subject and actually use the body for something other than
your .sig, thanks.

Regarding FP use, this depends on your target, and on your CFLAGS. If
you're using a target that supports an FPU, FP instructions are generated
by default. You will need to explicitly inhibit FP instruction generation
if you do not want it. You can look at arch/sh/Makefile for various ways
we try to prevent the compiler from generating FP instructions ("try" is
operative here, since GCC often has its own ideas about things).
