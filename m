From: Eric Paris <eparis@redhat.com>
Date: Wed, 19 Mar 2014 23:15:26 +0000
Subject: Re: [PATCH 1/4] SH: define syscall_get_arch() for superh
Message-Id: <1395270926.10106.2.camel@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <1395266643-3139-1-git-send-email-eparis@redhat.com>
	 <532A2FE8.7020502@cogentembedded.com>
In-Reply-To: <532A2FE8.7020502@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-audit@redhat.com, linux-sh@vger.kernel.org

On Thu, 2014-03-20 at 03:01 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 03/20/2014 01:04 AM, Eric Paris wrote:
> 
> > This patch defines syscall_get_arch() for the superh platform.  It does
> > so in both syscall_32.h and syscall_64.h.  I'm not certain if the
> > implementation in syscall_64.h couldn't just be used in syscall.h as I
> > can't really track the setting of CONFIG_64BIT...
> 
> > This way is safe, but we might be able to combine these if a superh
> > person were able to review...
> 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> > Cc: linux-sh@vger.kernel.org
> > ---
> >   arch/sh/include/asm/syscall_32.h | 10 ++++++++++
> >   arch/sh/include/asm/syscall_64.h | 14 ++++++++++++++
> >   2 files changed, 24 insertions(+)
> 
> > diff --git a/arch/sh/include/asm/syscall_32.h b/arch/sh/include/asm/syscall_32.h
> > index 7d80df4..460e9c6 100644
> > --- a/arch/sh/include/asm/syscall_32.h
> > +++ b/arch/sh/include/asm/syscall_32.h
> [...]
> > @@ -93,4 +94,13 @@ static inline void syscall_set_arguments(struct task_struct *task,
> >   	}
> >   }
> >
> > +static inline int syscall_get_arch(void)
> > +{
> > +	int arch = EM_SH;
> > +
> > +#ifdef CONFIG_CPU_LITTLE_ENDIAN
> > +		arch |= __AUDIT_ARCH_LE;
> 
>     Er, why the indentation jumped to the right suddenly?

Bad copy and pasting, will fix.  But I'd love to be able to just use the
64bit version in syscall.h and not need 2 copies...

-Eric

