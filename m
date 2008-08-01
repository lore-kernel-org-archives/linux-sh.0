From: David Howells <dhowells@redhat.com>
Date: Fri, 01 Aug 2008 14:04:15 +0000
Subject: Re: [PATCH 3/3] binfmt_elf_fdpic: Wire up AT_EXECFD, AT_EXECFN, AT_SECURE.
Message-Id: <27598.1217599455@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080728150521.GD16555@linux-sh.org> <20080728150359.GA16555@linux-sh.org> <20080728150430.GB16555@linux-sh.org> <20080728150501.GC16555@linux-sh.org>
In-Reply-To: <20080728150521.GD16555@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Paul Mundt <lethal@linux-sh.org> wrote:

> These auxvec entries are the only ones left unhandled out of the current
> base implementation. This syncs up binfmt_elf_fdpic with linux/auxvec.h
> and current binfmt_elf.
> 
> Signed-off-by: Paul Mundt <lethal@linux-sh.org>

Acked-by: David Howells <dhowells@redhat.com>

Though I'm not sure bprm->exec is any use in NOMMU circumstances:-/
