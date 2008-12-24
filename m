From: Kaz Kojima <kkojima@rr.iij4u.or.jp>
Date: Wed, 24 Dec 2008 22:57:53 +0000
Subject: Re: stack usage with libgcc math funcs
Message-Id: <20081225.075753.68205872.kkojima@rr.iij4u.or.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <200812241257.33701.vapier@gentoo.org>
In-Reply-To: <200812241257.33701.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Mike Frysinger <vapier@gentoo.org> wrote:
> i dont know superh assembly, so i cant really check the code myself.  starting 
> with at gcc-4.1.2 (at least, gcc-3.4.6 doesnt seem to have this issue), a few 
> objects in libgcc.a lack GNU-stack markings.  here is the scanelf output 
> against libgcc.a from gcc-4.3.2.  basically, '!WX' just means that the objects 
> do not have a .note.GNU-stack section.
> assuming libgcc doesnt actually use the stack to exec code, the attached patch 
> should fix things i think.

Thanks for pointing this out.  Could you please send your
patches to gcc-patches or file this issue to gcc bugzilla?
Unfortunately, now gcc trunk is in stage 4 and any patches
for non strict regressions can't be accepted temporary.
I'll schedule these patches for 4.5, then apply them to
the open branches after 4.5.

Thanks,
	kaz
