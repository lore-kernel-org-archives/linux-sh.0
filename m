From: Kaz Kojima <kkojima@rr.iij4u.or.jp>
Date: Thu, 25 Dec 2008 01:22:24 +0000
Subject: Re: stack usage with libgcc math funcs
Message-Id: <20081225.102224.195303268.kkojima@rr.iij4u.or.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <200812241257.33701.vapier@gentoo.org>
In-Reply-To: <200812241257.33701.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Mike Frysinger <vapier@gentoo.org> wrote:
> well, i would say this is a long standing regression.  gcc-3.4.6 does not 
> result in exec stacks with any of the libgcc.a math functions ... but you're 
> the gcc expert.

.note.GNU-stack wasn't used in gcc-3.4 era.  This type of
problem wouldn't be a "strict" regression, from the compiler's
viewpoint.

Regards,
	kaz
