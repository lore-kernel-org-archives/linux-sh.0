From: David Howells <dhowells@redhat.com>
Date: Fri, 01 Aug 2008 13:57:01 +0000
Subject: Re: [PATCH 1/3] binfmt_elf_fdpic: Support auxvec base platform string.
Message-Id: <27519.1217599021@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080728150430.GB16555@linux-sh.org> <20080728150359.GA16555@linux-sh.org>
In-Reply-To: <20080728150430.GB16555@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Paul Mundt <lethal@linux-sh.org> wrote:

> +	nitems = 1 + DLINFO_ITEMS + (k_platform ? 1 : 0) + \
> +		(k_base_platform ? 1 : 0) + AT_VECTOR_SIZE_ARCH;

Why the backslash?

David
