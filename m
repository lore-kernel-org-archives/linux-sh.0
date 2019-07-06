From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Sat, 06 Jul 2019 11:46:38 +0000
Subject: Re: [PATCH 18/39] docs: admin-guide: add kdump documentation into it
Message-Id: <20190706084638.7dc875f2@coco.lan>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
 <654e7591c044632c06257e0f069a52c0bb993554.1561724493.git.mchehab+samsung@kernel.org>
 <6911b74c-848f-0060-3db5-b5d7e8061cb5@linux.alibaba.com>
 <20190705055904.GB2790@localhost.localdomain>
In-Reply-To: <20190705055904.GB2790@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Dave Young <dyoung@redhat.com>
Cc: Rich Felker <dalias@libc.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Jerry Hoemann <jerry.hoemann@hpe.com>, Harry Wei <harryxiyou@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Alex Shi <alex.shi@linux.alibaba.com>, Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@lists.ozlabs.org

Em Fri, 5 Jul 2019 13:59:04 +0800
Dave Young <dyoung@redhat.com> escreveu:

> On 07/05/19 at 11:43am, Alex Shi wrote:
> > 
> > 
> > 在 2019/6/28 下午8:30, Mauro Carvalho Chehab 写道:  
> > > The Kdump documentation describes procedures with admins use
> > > in order to solve issues on their systems.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > > ---
> > >  Documentation/admin-guide/bug-hunting.rst            | 4 ++--
> > >  Documentation/admin-guide/index.rst                  | 1 +
> > >  Documentation/{ => admin-guide}/kdump/gdbmacros.txt  | 0
> > >  Documentation/{ => admin-guide}/kdump/index.rst      | 1 -
> > >  Documentation/{ => admin-guide}/kdump/kdump.rst      | 0
> > >  Documentation/{ => admin-guide}/kdump/vmcoreinfo.rst | 0  
> > 
> > I am not sure if it's convenience for people to have more levels in docs.
> > 
> > But I guess, move archs into a Documentation/arch/ dir should be fine. like Documentation/arch/{x86,arm,arm64,ia64,m68k,s390,powerpc,...}  
> 
> Alex, moving kdump to admin-guide sounds reasonable to me.  I also agree
> with you for those arch dependent files can be moved to
> Documentation/arch/, maybe you are talking about some other patches in
> the series for the arch/? 

Alex,

It makes sense for me to have a Documentation/arch directory, and place
the arch-specific docs over there.

There's actually a technical advantage on doing that: Sphinx is dumb
with regards to PDF/LaTeX output: it requires all top documents to be
listed at Documentation/conf.py, under this var:

	latex_documents = [
		...
	]

As it creates one runtime Makefile at Documentation/output per listed
document there. So, the more we group such documents, the less merge
conflicts we'll have at Documentation/conf.py.

Btw, there's a [TECH TOPIC] proposal for KS/2019 meant to discuss 
Documentation.

I suspect we could discuss the pros/cons of doing such change there.

My personal view is that we should keep the Documentation/ root dir as
clean as possible as a long term goal.

On the other hand, it makes the path bigger and harder to rename.

On a side note, last time we discussed documentation at KS I remember
I proposed to shortcut "Documentation/" to just "docs/". The consensus
on that time were to keep the big name. I still think that a shorter
one could help people to remind where documentation will be located.

Thanks,
Mauro
