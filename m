From: Oleg Endo <oleg.endo@t-online.de>
Date: Tue, 29 May 2012 20:09:09 +0000
Subject: Re: Has anyone got gcc-4.7.0 to build an SH64 kernel without dying?
Message-Id: <1338322149.2152.5.camel@yam-132-YW-E178-FTW>
List-Id: <linux-sh.vger.kernel.org>
References: <10426.1338312184@redhat.com>
In-Reply-To: <10426.1338312184@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: lethal@linux-sh.org, dhorak@redhat.com, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, 2012-05-29 at 18:23 +0100, David Howells wrote:
> Has anyone had any success building a gcc-4.7.0 that can build SH64 binaries
> without dying?  I am seeing ICEs and SEGVs:
> 
> include/linux/genhd.h:214:3: internal compiler error: Segmentation fault
> mm/madvise.c:285:2: internal compiler error: Segmentation fault
> mm/percpu.c: In function 'pcpu_free_area':
> mm/percpu.c:602:1: error: unrecognizable insn:
> (insn 74 73 75 8 (set (reg:SI 279)
>         (abs:SI (reg:SI 280))) mm/percpu.c:575 -1
>      (nil))
> mm/percpu.c:602:1: internal compiler error: in extract_insn, at recog.c:2123
> 

Hmm .. abs:SI ... I'm afraid that was me.  Sorry about that!
Somebody noticed the problem with abs:SI on SH64 a while ago, too.
However, I don't remember whether the fix made it into 4.7.0 or into the
4.7.1 branch.  Could you try with the 4.7.1 branch?

Cheers,
Oleg

