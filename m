From: Nicolas Pitre <nico@fluxnic.net>
Date: Thu, 30 Apr 2020 01:27:47 +0000
Subject: Re: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem properly in there
Message-Id: <nycvar.YSQ.7.76.2004292115050.2671@knanqh.ubzr>
List-Id: <linux-sh.vger.kernel.org>
References: <20200429214954.44866-1-jannh@google.com>
 <20200429215620.GM1551@shell.armlinux.org.uk>
 <CAHk-=wgpoEr33NJwQ+hqK1dz3Rs9jSw+BGotsSdt2Kb3HqLV7A@mail.gmail.com>
In-Reply-To: <CAHk-=wgpoEr33NJwQ+hqK1dz3Rs9jSw+BGotsSdt2Kb3HqLV7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rich Felker <dalias@libc.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Jann Horn <jannh@google.com>, Greg Ungerer <gerg@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Linux-MM <linux-mm@kvack.org>, Linux-sh list <linux-sh@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Christoph Hellwig <hch@lst.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Eric W . Biederman" <ebiederm@xmission.com>

On Wed, 29 Apr 2020, Linus Torvalds wrote:

> While we're at it, is there anybody who knows binfmt_flat?

I'd say Greg Ungerer.

> It might be Nicolas too.

I only contributed the necessary changes to make it work on targets with 
a MMU. Once fdpic started to worked I used that instead.

FWIW I couldn't find a toolchain that would produce FLAT binaries with 
dynamic libs on ARM so I only used static binaries.


Nicolas
