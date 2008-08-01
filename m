From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 01 Aug 2008 21:46:55 +0000
Subject: Re: [PATCH 1/3] binfmt_elf_fdpic: Support auxvec base platform string.
Message-Id: <20080801214655.GB13448@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080728150430.GB16555@linux-sh.org> <20080728150359.GA16555@linux-sh.org> <27519.1217599021@redhat.com>
In-Reply-To: <27519.1217599021@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Aug 01, 2008 at 02:57:01PM +0100, David Howells wrote:
> Paul Mundt <lethal@linux-sh.org> wrote:
> 
> > +	nitems = 1 + DLINFO_ITEMS + (k_platform ? 1 : 0) + \
> > +		(k_base_platform ? 1 : 0) + AT_VECTOR_SIZE_ARCH;
> 
> Why the backslash?
> 
Habitual behavioural patterns?

If you feel strongly about it it can just be edited out of the patch.
