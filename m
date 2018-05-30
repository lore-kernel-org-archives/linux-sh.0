From: Rob Landley <rob@landley.net>
Date: Wed, 30 May 2018 14:41:30 +0000
Subject: Re: [PATCH] sh: pass machine size to sparse
Message-Id: <d396b6b2-0fa7-aac1-c23b-a31b1c0d446a@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20180528164018.16064-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20180528164018.16064-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/28/2018 11:40 AM, Luc Van Oostenryck wrote:
> By default, sparse assumes a 64bit machine when compiled on x86-64
> and 32bit when compiled on anything else.
> 
> This can of course create all sort of problems, like issuing false
> warnings like: 'shift too big (32) for type unsigned long', or
> worse, to not emit legitimate warnings.
> 
> Fix this by passing to sparse the appropriate -m32/-m64 flag

$ ${CROSS_COMPILE}gcc -E -dM - < /dev/null | grep __SIZEOF_LONG__
#define __SIZEOF_LONG__ 8

You can ask the compiler, you don't need to redundantly add this to every
architecture's Makefile.

Rob
