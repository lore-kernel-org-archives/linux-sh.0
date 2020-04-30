From: Rob Landley <rob@landley.net>
Date: Thu, 30 Apr 2020 21:13:10 +0000
Subject: Re: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem properly in there
Message-Id: <34688b36-4fdf-0c71-77cc-f98e6b9962df@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20200429214954.44866-1-jannh@google.com>
 <20200429215620.GM1551@shell.armlinux.org.uk>
 <CAHk-=wgpoEr33NJwQ+hqK1dz3Rs9jSw+BGotsSdt2Kb3HqLV7A@mail.gmail.com>
 <31196268-2ff4-7a1d-e9df-6116e92d2190@linux-m68k.org>
 <20200430145123.GE21576@brightrain.aerifal.cx>
In-Reply-To: <20200430145123.GE21576@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>, Greg Ungerer <gerg@linux-m68k.org>
Cc: Mark Salter <msalter@redhat.com>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Nicolas Pitre <nico@fluxnic.net>, Linux-sh list <linux-sh@vger.kernel.org>, Jann Horn <jannh@google.com>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Eric W . Biederman" <ebiederm@xmission.com>

On 4/30/20 9:51 AM, Rich Felker wrote:
> This sounds correct. My understanding of FLAT shared library support
> is that it's really bad and based on having preassigned slot indices
> for each library on the system, and a global array per-process to give
> to data base address for each library. Libraries are compiled to know
> their own slot numbers so that they just load from fixed_reg[slot_id]
> to get what's effectively their GOT pointer.
> 
> I'm not sure if anybody has actually used this in over a decade. Last
> time I looked the tooling appeared broken, but in this domain lots of
> users have forked private tooling that's not publicly available or at
> least not publicly indexed, so it's hard to say for sure.

Lots of people in this area are also still using 10 year old tools because it
breaks every time they upgrade.

Heck, nommu support for architectures musl doesn't support yet is _explicitly_
the main thing keeping uClibc alive:

  https://www.openwall.com/lists/musl/2015/05/30/1

Rob
